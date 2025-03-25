import 'package:flutter/material.dart';
import '../services/post_service.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();

  void _addPost() {
    if (_postController.text.isNotEmpty) {
      setState(() {
        PostService.addPost(_postController.text);
      });
      _postController.clear();
    }
  }

  void _logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterGram"),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _logout)],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: _postController, decoration: InputDecoration(labelText: "Write a post")),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: _addPost),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: PostService.getPosts().length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(PostService.getPosts()[index]));
              }
              bool _isDarkMode = false;

              void _toggleTheme() {
                setState(() {
                   _isDarkMode = !_isDarkMode;
                     });
              }
              appBar: AppBar(
                title: Text("FlutterGram"),
                actions: [
    IconButton(
      icon: Icon(Icons.person),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ProfilePage()),
        );
      },
    ),
    IconButton(
      icon: Icon(Icons.logout),
      onPressed: _logout,
    ),
  ],
),
},
            ),
          ),
        ],
      ),
    );
  }
}
