import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/post_service.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _postService = PostService();
  final _contentController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _uploadPost() async {
    final userId = "YOUR_USER_ID"; // Replace with current user ID
    String? imageUrl;

    if (_selectedImage != null) {
      imageUrl = await _postService.uploadPostImage(_selectedImage!, userId);
    }

    await _postService.createPost(userId, _contentController.text, imageUrl);
    _contentController.clear();
    setState(() => _selectedImage = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: _contentController, decoration: InputDecoration(labelText: "What's on your mind?")),
          _selectedImage != null
              ? Image.file(_selectedImage!, height: 200, width: 200, fit: BoxFit.cover)
              : Container(),
          Row(
            children: [
              IconButton(icon: Icon(Icons.image), onPressed: _pickImage),
              ElevatedButton(onPressed: _uploadPost, child: Text("Post")),
            ],
          ),
        ],
      ),
    );
  }
}
