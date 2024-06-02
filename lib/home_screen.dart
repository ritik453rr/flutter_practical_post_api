import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api_practical/model/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postlist = [];
  Future<List<PostModel>> getPost() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Api"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: getPost(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Loading....');
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(postlist[index].title.toString()),
                                ],
                              ),
                            ),
                          );
                        },),
                  );
                }
              })
        ],
      ),
    );
  }
}
