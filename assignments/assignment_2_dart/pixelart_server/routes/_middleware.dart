import 'package:dart_frog/dart_frog.dart';

Handler middleware(Handler handler) {
  return (context) async {
    final response = await handler(context);
    return response.copyWith(
      headers: {
        ...response.headers,
        'Access-Control-Allow-Origin': '*', 
        'Access-Control-Allow-Methods': 'POST,GET,DELETE,PUT,OPTIONS',  
      },
    );
  };
}
