/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:async';

export 'src/pixelart_data.dart';
export 'src/pixelart_abstract_repository.dart';
export 'src/pixelart_crud_utils.dart';



// TODO: Export any libraries intended for clients of this package.
void main(List<String> args) {
  
	// Create a stream controller
final streamController = StreamController<int>();
 
// Listening to the stream
streamController.stream.listen((data) {
  print('Received: $data');
});
 
// Adding data to the stream
streamController.sink.add(1);
streamController.sink.add(2);

}
