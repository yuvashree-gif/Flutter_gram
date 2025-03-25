import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/post_service.dart';
import '../widgets/comment_section.dart';

class PostCard extends StatefulWidget {
  final String postId;
  final String content;
  final int likes;

  PostCard({required this.postId, required this.content, required this.likes});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int _likeCount = 0;
  final _postService = PostService();

  @override
  void initState() {
    super.initState();
    _likeCount = widget.likes;
  }

  void _likePost() async {
    await _postService.likePost(widget.postId);
    setState(() {
      _likeCount++;
    });
  }
   Column(
  children: [
    Text(widget.content, style: TextStyle(fontSize: 18)),
    Row(
      children: [
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: _likePost,
        ),
        Text("$_likeCount Likes"),
      ],
    ),
    CommentSection(postId: widget.postId),
  ],
),
Column(
  children: [
    Text(widget.content, style: TextStyle(fontSize: 18)),
    widget.imageUrl != null
        ? Image.network(widget.imageUrl!, height: 200, width: 200, fit: BoxFit.cover)
        : Container(),
    Row(
      children: [
        IconButton(
          icon: Icon(Icons.favorite, color: Colors.red),
          onPressed: _likePost,
        ),
        Text("$_likeCount Likes"),
      ],
    ),
    CommentSection(postId: widget.postId),
  ],
),

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(widget.content, style: TextStyle(fontSize: 18)),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: _likePost,
              ),
              Text("$_likeCount Likes"),
            ],
          ),
        ],
      ),
    );
  }
}
