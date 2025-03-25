import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
      setState(() {
        _userData = response;
      });
    }
  }

  void _logout() async {
    await supabase.auth.signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_userData!['avatar_url'] ?? ''),
                  child: _userData!['avatar_url'] == null ? Icon(Icons.person, size: 50) : null,
                ),
                SizedBox(height: 10),
                Text(_userData!['username'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                Text(_userData!['email'], style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
    );
  }
}
