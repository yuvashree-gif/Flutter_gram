import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));

      final userId = "YOUR_USER_ID"; // Replace with current user ID
      final imageUrl = await _authService.uploadProfilePic(_selectedImage!, userId);

      if (imageUrl != null) {
        await _authService.updateUserProfilePic(userId, imageUrl);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _selectedImage != null
              ? CircleAvatar(backgroundImage: FileImage(_selectedImage!), radius: 50)
              : Icon(Icons.account_circle, size: 50),
          ElevatedButton(onPressed: _pickImage, child: Text("Upload Profile Picture")),
        ],
      ),
    );
  }
}
