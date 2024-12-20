import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listview/home/apiPage/NewsCard.dart';
import 'package:listview/model/Getnews.dart';

class Newspage extends StatefulWidget {
  const Newspage({super.key});

  @override
  State<Newspage> createState() => _NewspageState();
}

class _NewspageState extends State<Newspage> {
  Future<List<Getnews>> fetchPost() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      var getPostsData = json.decode(response.body) as List;
      return getPostsData.map((i) => Getnews.fromJson(i)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  late Future<List<Getnews>> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FutureBuilder<List<Getnews>>(
            future: futurePost,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    var post = snapshot.data![index];
                    return Column(
                      children: [
                        Newscard(
                          getnews: post,
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const Center(child: Text('No posts available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
