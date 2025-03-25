import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/comment_service.dart';

class CommentService {
  final supabase = Supabase.instance.client;

  Future<void> addComment(String postId, String commentText) async {
    final user = supabase.auth.currentUser;

    if (user != null) {
      await supabase.from('comments').insert({
        'post_id': postId,
        'user_id': user.id,
        'comment': commentText,
        'created_at': DateTime.now().toIso8601String(),
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchComments(String postId) async {
    final response = await supabase
        .from('comments')
        .select()
        .eq('post_id', postId)
        .order('created_at', ascending: true);
    return response;
  }
}
class CommentSection extends StatefulWidget {
  final String postId;
  CommentSection({required this.postId});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final _commentService = CommentService();
  final _commentController = TextEditingController();
  List<Map<String, dynamic>> _comments = [];

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _fetchComments() async {
    final comments = await _commentService.fetchComments(widget.postId);
    setState(() {
      _comments = comments;
    });
  }

  void _addComment() async {
    if (_commentController.text.isNotEmpty) {
      await _commentService.addComment(widget.postId, _commentController.text);
      _commentController.clear();
      _fetchComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _commentController,
          decoration: InputDecoration(labelText: "Add a comment"),
        ),
        ElevatedButton(onPressed: _addComment, child: Text("Post Comment")),
        Divider(),
        Column(
          children: _comments.map((comment) {
            return ListTile(
              title: Text(comment['comment']),
              subtitle: Text(comment['created_at']),
            );
          }).toList(),
        ),
      ],
    );
  }
}