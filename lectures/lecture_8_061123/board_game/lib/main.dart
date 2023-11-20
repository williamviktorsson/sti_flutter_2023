import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BoardGameApp());
}

class Boom {
  int value = 0;
}

class BoardGameApp extends StatelessWidget {
  const BoardGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    final boom = ValueNotifier<int>(0);

    return MaterialApp(
      title: 'Crazy Board Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 183, 91, 37)),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider.value(
          value: boom, child: const MainPage(title: 'Crazy Board Game')),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class Stuff {
  int value = 0;
  String friend = 'Bob';
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final counter = context.watch<ValueNotifier<int>>();

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return HomeViewWidget(widget: widget);
  }
}

class HomeViewWidget extends StatelessWidget {
  const HomeViewWidget({
    super.key,
    required this.widget,
  });

  final MainPage widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(padding: const EdgeInsets.all(64.0), child: MyGrid()),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class MyGrid extends StatefulWidget {
  @override
  _MyGridState createState() => _MyGridState();
}

class _MyGridState extends State<MyGrid> {
  final List<ValueNotifier<Color>> colors = List.generate(
    16 * 8,
    (_) => ValueNotifier<Color>(Colors.white),
  );

  final selectedColor = ValueNotifier<Color>(Colors.black);
  final colorsx = <Color>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.black,
    Colors.white,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 64,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colorsx.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => selectedColor.value = colorsx[index],
                child: Container(
                  width: 64,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: colorsx[index], border: Border.all(width: 4)),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 16,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            children: List.generate(
              16 * 8,
              (index) => GestureDetector(
                onTap: () {
                  colors[index].value = selectedColor.value;
                },
                child: ValueListenableBuilder<Color>(
                  valueListenable: colors[index],
                  builder: (context, color, child) {
                    return Container(
                      decoration:
                          BoxDecoration(border: Border.all(), color: color),
                      child: child,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ListViewDragExample extends StatelessWidget {
  const ListViewDragExample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) {
      ValueNotifier<double> xAxis = ValueNotifier(-100);
      ValueNotifier<double> xAxis2 = ValueNotifier(-100);

      return GestureDetector(
          onHorizontalDragUpdate: (details) {
            xAxis.value += details.delta.dx;
            xAxis2.value -= details.delta.dx;
          },
          onHorizontalDragEnd: (details) {
            xAxis.value = -100;
            xAxis2.value = -100;
          },
          child: Stack(children: [
            ValueListenableBuilder(
                valueListenable: xAxis,
                builder: (context, value, child) {
                  return AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      left: value,
                      child: ButtonBar(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.delete)),
                        ],
                      ));
                }),
            ValueListenableBuilder(
                valueListenable: xAxis2,
                builder: (context, value, child) {
                  return AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      right: value,
                      child: ButtonBar(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.delete)),
                        ],
                      ));
                }),
            ListTile(title: Text('Item $index'))
          ]));
    });
  }
}

class SliadableTest extends StatelessWidget {
  SliadableTest({Key? key}) : super(key: key);

  final doNothing = (dynamic stuff) {};

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: const ValueKey(0),

      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        extentRatio: 0.2,
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.share,
            label: 'Share',
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: doNothing,
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            onPressed: doNothing,
            backgroundColor: Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: Icons.save,
            label: 'Save',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: const ListTile(title: Text('Slide me')),
    );
  }
}

class MyCanvas extends StatefulWidget {
  @override
  _MyCanvasState createState() => _MyCanvasState();
}

class _MyCanvasState extends State<MyCanvas> {
  List<List<Color>> colors = List.generate(
    64,
    (_) => List.generate(
      64,
      (_) => Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    const double padding = 64;

    double height = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom +
            padding * 2);
    double width = MediaQuery.of(context).size.width -
        (MediaQuery.of(context).padding.left +
            MediaQuery.of(context).padding.right +
            padding * 2);
    double min = height < width ? height : width;

    return Padding(
        padding: const EdgeInsets.all(padding),
        child: GestureDetector(
          onTapDown: (TapDownDetails details) {
            final RenderBox box = context.findRenderObject()! as RenderBox;
            final Offset localOffset =
                box.globalToLocal(details.globalPosition);
            final double squareSize = box.size.width / 64;
            final int i = localOffset.dx ~/ squareSize;
            final int j = localOffset.dy ~/ squareSize;
            print('You clicked on square $i, $j with color ${colors[i][j]}');
          },
          child: CustomPaint(
            size: Size(min, min),
            painter: MyPainter(colors),
          ),
        ));
  }
}

class MyPainter extends CustomPainter {
  final List<List<Color>> colors;

  MyPainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    double squareSize = size.width / 64;

    double margin = squareSize / 4;
    squareSize -= margin;
    double strokeWidth = squareSize / 16;

    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 64; i++) {
      for (var j = 0; j < 64; j++) {
        final fillPaint = Paint()
          ..color = colors[i][j]
          ..style = PaintingStyle.fill;
        final rect = Rect.fromLTWH(i * squareSize + i * margin,
            j * squareSize + j * margin, squareSize, squareSize);
        canvas.drawRect(rect, fillPaint); // Draw the filled square
        canvas.drawRect(rect, borderPaint); // Draw the border
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
