import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderExample extends StatelessWidget {
  ProviderExample({Key? key}) : super(key: key);

  ValueNotifier<int> counter = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Center(
                  child: GridView.count(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 100,
            children: List.generate(100, (index) {
              ValueNotifier<int> temp = ValueNotifier(0);

              return ChangeNotifierProvider.value(
                  value: temp, child: const ExamplePressable());
            }),
          ))),
          ValueListenableBuilder(
              valueListenable: counter,
              builder: (context, value, _) {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        value.toString(),
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class ExamplePressable extends StatelessWidget {
  const ExamplePressable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> counter = context.watch<ValueNotifier<int>>();

    return InkWell(
      onTap: () {
        counter.value++;
      },
      onLongPress: () {
        counter.value = 0;
      },
      child: Container(
        margin: EdgeInsets.all(2),
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        child: Center(
          child: Text(
            counter.value.toString(),
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
    ;
  }
}
