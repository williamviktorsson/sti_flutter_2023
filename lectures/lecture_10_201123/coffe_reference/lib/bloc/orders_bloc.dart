import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

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

  static Order fromJson(Map<String, dynamic> json) => Order(
      json['userId'] as String,
      OrderStatus.values[json['status'] as int],
      DateTime.parse(json['placedAt'] as String),
      json['completedAt'] != null
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      json['fcmToken']);
}

abstract class OrderEvent {}

class CreateOrder extends OrderEvent {
  final Order order;

  CreateOrder(this.order);
}

class LoadOrders extends OrderEvent {}

sealed class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}

class OrdersBloc extends Bloc<OrderEvent, OrderState> {
  User user;
  OrdersBloc({required this.user}) : super(OrderInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrderLoading());

      await emit
          .forEach(FirebaseFirestore.instance.collection("orders").snapshots(),
              onData: (snapshot) {
        List<Order> orders =
            snapshot.docs.map((doc) => Order.fromJson(doc.data())).toList();
        return OrderLoaded(orders);
      });
    });
    on<CreateOrder>((event, emit) {
      try {
        // Create a new order with the current DateTime
        Order order = event.order;

        // Add the order to the user's orders collection
        FirebaseFirestore.instance.collection("orders").add(order.toJson());
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });
  }

  placeOrder() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token;

    try {
      token = await messaging.getToken(
        vapidKey: kIsWeb
            ? "BAEPPhp2BPV1ZOZXqIQh6fBvbJnjmbrIWUzQNdpHJfVbkxVvmsD4ug4l1UBBH94nCRnKFwtZz6sG273tv6e86Oo"
            : null,
      );
      print(token);
    } catch (e) {
      print(e);
    }

    add(CreateOrder(
        Order(user.uid, OrderStatus.queue, DateTime.now(), null, token)));
  }
}
