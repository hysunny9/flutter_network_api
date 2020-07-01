import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:network_api/data/post_api_service.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  int postId;
  SinglePostPage({this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
      ),
      body: FutureBuilder<Response>(
          future: Provider.of<PostApiService>(context).getPost(postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final Map<String, dynamic> post =
                  json.decode(snapshot.data.bodyString);
              return _buildPost(post);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

Widget _buildPost(Map<String, dynamic> post) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(
          post['title'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          height: 8,
        ),
        Text(post['body'])
      ],
    ),
  );
}
