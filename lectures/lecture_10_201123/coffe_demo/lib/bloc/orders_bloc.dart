import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum OrderStatus { queue, progress, completed }

class Order extends Equatable {
  final String userId;
  final OrderStatus status;
  final DateTime placedAt;
  DateTime? completedAt;
  final String? fcmToken;

  Order(
      this.userId, this.status, this.placedAt, this.completedAt, this.fcmToken);

  @override
  List<Object?> get props => [userId, status, placedAt, completedAt];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'status': status.index,
        'placedAt': placedAt.toIso8601String(),
        'completedAt': completedAt?.toIso8601String(),
        'fcmToken': fcmToken
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        json['userId'] as String,
        OrderStatus.values[json['status'] as int],
        DateTime.parse(json['placedAt'] as String),
        json['completedAt'] != null
            ? DateTime.parse(json['completedAt'] as String)
            : null,
        json['fcmToken'],
      );
}

sealed class OrderEvent {}

class CreateOrder extends OrderEvent {
  final Order order;

  CreateOrder(this.order);
}

class LoadOrders extends OrderEvent {}

sealed class OrderState {}

class OrderInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<Order> orders;

  OrdersLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}

class OrdersBloc extends Bloc<OrderEvent, OrderState> {
  OrdersBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) async {
      switch (event) {
        case CreateOrder():
          FirebaseFirestore.instance
              .collection("orders")
              .add(event.order.toJson());

        case LoadOrders():
          emit(OrdersLoading());

          await emit.forEach(
              FirebaseFirestore.instance.collection("orders").snapshots(),
              onData: (snapshot) {
            List<Order> orders =
                snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList();
            return OrdersLoaded(orders);
          });
      }
    });
  }
}
