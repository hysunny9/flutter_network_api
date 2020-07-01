import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:network_api/data/post_api_service.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class CreatePostPage extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Post"),
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                TextField(
                    controller: title,
                    decoration: InputDecoration(
                      hintText: 'title',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    )),
                SizedBox(height: 8),
                TextField(
                    controller: body,
                    decoration: InputDecoration(
                      hintText: 'body',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    )),
                RaisedButton(
                  onPressed: () async {
                    final future = await Provider.of<PostApiService>(context)
                        .postPost(json
                            .encode({'title': title.text, 'body': body.text}));
                    print(future.body);
                    Toast.show(
                        "The post has been created successfully", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  },
                  child: Text("Submit"),
                )
              ],
            )));
  }
}
