import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/post_api_service.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => PostApiService.create(),
      dispose: (context, PostApiService service) => service.client.dispose(),
      child: MaterialApp(
        title: 'Hello',
        home: HomePage(),
      ),
    );
  }
}
