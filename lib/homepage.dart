import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:network_api/data/post_api_service.dart';
import 'package:provider/provider.dart';

import 'create_post_page.dart';
import 'single_post_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _naviagtionToCreatePost(context);
          },
          child: Icon(Icons.add),
        ),
        body: _buildBody(context));
  }

  _naviagtionToCreatePost(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return CreatePostPage();
      },
    ));
  }
}

FutureBuilder<Response> _buildBody(BuildContext context) {
  return FutureBuilder<Response>(
    future: Provider.of<PostApiService>(context).getPosts(),
    builder: (context, snapShots) {
      if (snapShots.connectionState == ConnectionState.done) {
        print(json.decode(snapShots.data.bodyString));
        final List posts = json.decode(snapShots.data.bodyString);
        return _buildPost(context, posts);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

ListView _buildPost(BuildContext context, List posts) {
  return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Card(
            elevation: 4,
            child: ListTile(
              title: Text(
                posts[index]['title'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(posts[index]['body']),
              onTap: () => _naviagtionToPost(context, posts[index]['id']),
            ));
      });
}

_naviagtionToPost(BuildContext context, int id) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => SinglePostPage(postId: id),
  ));
}
