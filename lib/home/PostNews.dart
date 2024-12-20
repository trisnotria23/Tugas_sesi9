import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Albums.dart';

class PostNews extends StatefulWidget {
  const PostNews({super.key});

  @override
  State<PostNews> createState() => _PostNewsState();
}

class _PostNewsState extends State<PostNews> {
  Future<Albums> createAlbum(String title) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      return Albums.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  final TextEditingController _controller = TextEditingController();
  Future<Albums>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data Example'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: (_futureAlbum == null) ? buildInputForm() : buildResultView(),
      ),
    );
  }

  Widget buildInputForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Enter Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Icon(Icons.title, color: Colors.deepPurple),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              setState(() {
                _futureAlbum = createAlbum(_controller.text);
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter a title')),
              );
            }
          },
          child: const Text(
            'Create Data',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildResultView() {
    return FutureBuilder<Albums>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(color: Colors.deepPurple),
              SizedBox(height: 10),
              Text('Creating data...'),
            ],
          );
        } else if (snapshot.hasData) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.deepPurple.withOpacity(0.1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, size: 50, color: Colors.green),
                  const SizedBox(height: 10),
                  Text(
                    'Album Created Successfully!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    snapshot.data!.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _futureAlbum = null;
                        _controller.clear();
                      });
                    },
                    child: const Text('Create Another'),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 50, color: Colors.red),
              const SizedBox(height: 10),
              Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  setState(() {
                    _futureAlbum = null;
                  });
                },
                child: const Text('Try Again'),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
