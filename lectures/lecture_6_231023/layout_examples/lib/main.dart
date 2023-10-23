import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NavigationExample(),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  final destinations = const <Widget>[
    NavigationDestination(
      icon: Icon(Icons.check_box_outline_blank),
      label: 'Container\n',
    ),
    NavigationDestination(
      icon: Icon(Icons.rectangle_outlined),
      label: 'Column\nRow ',
    ),
    NavigationDestination(
      icon: Icon(Icons.storage),
      label: 'Stack\nPositioned',
    ),
    NavigationDestination(
      icon: Icon(Icons.wrap_text),
      label: 'Wrap\n',
    ),
    NavigationDestination(
      icon: Icon(Icons.list),
      label: 'ListView\n',
    ),
    NavigationDestination(
      icon: Icon(Icons.border_all),
      label: 'GridView\n',
    ),
  ];

  final routes = const <Widget>[
    ContainerExample(),
    ColumnRowExpandedExample(),
    StackPositionedExample(),
    WrapExample(),
    ListViewExample(),
    GridViewExample(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber[800],
          selectedIndex: currentPageIndex,
          destinations: destinations),
      body: SizedBox.expand(child: routes[currentPageIndex]),
    );
  }
}

class ContainerExample extends StatelessWidget {
  const ContainerExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // add decoration with border (width, radius, color)
      // show margin
      // show padding
      // perhaps show gradient (lineargradient)
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
          width: 5,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),

      margin: const EdgeInsets.all(60),
      padding: const EdgeInsets.all(20),

      child: Container(
          color: Colors.red, child: const Center(child: Text('Container'))),
    );
  }
}

class ColumnRowExpandedExample extends StatelessWidget {
  const ColumnRowExpandedExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // show column with different alignments
    // add container and show wrapping in expanded
    // show replacing row with column
    // show adding row to column
    // show expanded flex properties
    return const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("test"),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("test"),
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("test"),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("test"),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("test"),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("test"),
            ),
          ),
        ]);
  }
}

class StackPositionedExample extends StatelessWidget {
  const StackPositionedExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // show stack and positioned stuff
    // first item in array is bottom of stack
    return Stack(children: [
      Positioned.fill(
        child: Center(
          child: Container(
            color: Colors.red,
            width: 100,
            height: 100,
          ),
        ),
      ),
      Positioned.fill(
        child: Center(
          child: Container(
            color: Colors.yellow,
            width: 50,
            height: 50,
          ),
        ),
      ),
    ]);
  }
}

class WrapExample extends StatelessWidget {
  const WrapExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // show wrap with spacing and run spacing
    //    spacing is gap between adjacent chips
    //    runSpacing is gap between lines of chips
    return Wrap(
      spacing: 40.0, // gap between adjacent chips
      runSpacing: 40.0,
      children: List.generate(
          50,
          (index) => const Card(
                  child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("test"),
              ))),
    );
  }
}

class ListViewExample extends StatelessWidget {
  const ListViewExample({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // show listview
    // show listTiles as children
    // show leading/title/subtitle/trailing
    return ListView.builder(itemBuilder: (context, index) {
      return Card(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("test"),
      ));
    });
  }
}

class GridViewExample extends StatelessWidget {
  const GridViewExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // show gridview.count
    // vary crossAxisCount
    // show children as chips or something
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(
          100,
          (index) => Card(
                  child: Padding(
                padding: EdgeInsets.all(2.0),
                child: Text('${index}'),
              ))),
    );
  }
}
