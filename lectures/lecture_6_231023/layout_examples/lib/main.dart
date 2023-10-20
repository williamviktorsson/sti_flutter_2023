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
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.black, width: 4),
          color: Colors.red,
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.red, Colors.amber])),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      //   color: Colors.red, // remove when adding decoration
      alignment: Alignment.bottomLeft, // change this around
      child: const Text('Container'),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: Container(
                color: Colors.blue,
                child: const Center(child: Text('Column/Row/Expanded')))),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.green,
            child: Row(children: [
              ElevatedButton(child: const Text("press me? "), onPressed: () {}),
              ElevatedButton(child: const Text("press me? "), onPressed: () {}),
              ElevatedButton(child: const Text("press me? "), onPressed: () {})
            ]),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.red,
            child: Row(children: [
              ElevatedButton(child: const Text("press me? "), onPressed: () {}),
              ElevatedButton(child: const Text("press me? "), onPressed: () {}),
              ElevatedButton(child: const Text("press me? "), onPressed: () {})
            ]),
          ),
        )
      ],
    );
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
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
          color: Colors.blue,
          child: Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.amber,
                  child: const Text('Stack'))),
        )),
        const Positioned(left: 50, top: 50, child: Text('Stuff?')),
      ],
    );
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
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Wrap(
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines of chips
        children: <Widget>[
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('AH'),
            ),
            label: const Text('Hamilton'),
          ),
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('ML'),
            ),
            label: const Text('Lafayette'),
          ),
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('HM'),
            ),
            label: const Text('Mulligan'),
          ),
          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),          Chip(
            avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900,
              child: const Text('JL'),
            ),
            label: const Text('Laurens'),
          ),
        ],
      ),
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
    return Container(
      color: Colors.pinkAccent.shade100,
      alignment: Alignment.center,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Map'),
          ),
          ListTile(
            leading: Icon(Icons.photo_album),
            title: Text('Album'),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Phone'),
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            title: Text('Contacts'),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
          ),
        ],
      ),
    );
  }
}

class GridViewExample extends StatelessWidget {
  const GridViewExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      alignment: Alignment.center,
      child: const Text('GridView'),
    );
  }
}
