import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Upload an image
  Future<String?> uploadImage(String filePath) async {
    final file = await supabase.storage.from('posts').upload(filePath, filePath);
    return file; // Returns image URL
  }
  //add image
  Future<String?> uploadPostImage(File imageFile, String userId) async {
    final fileExt = imageFile.path.split('.').last;
    final filePath = 'posts/$userId-${DateTime.now().millisecondsSinceEpoch}.$fileExt';

    final response = await supabase.storage
        .from('fluttergram')
        .upload(filePath, imageFile);

    if (response.error == null) {
      return supabase.storage.from('fluttergram').getPublicUrl(filePath);
    }
    return null;
  }

  Future<void> createPost(String userId, String content, String? imageUrl) async {
    await supabase.from('posts').insert({
      'user_id': userId,
      'content': content,
      'image_url': imageUrl,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}

  //like a post
  Future<void> likePost(String postId) async {
    final post = await supabase
        .from('posts')
        .select('likes')
        .eq('id', postId)
        .single();

    if (post != null) {
      int currentLikes = post['likes'] ?? 0;
      await supabase
          .from('posts')
          .update({'likes': currentLikes + 1})
          .eq('id', postId);
    }
  }
}


  // Create a post
  Future<void> createPost(String userId, String imageUrl, String caption) async {
    await supabase.from('posts').insert({
      'user_id': userId,
      'image_url': imageUrl,
      'caption': caption,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  // Fetch all posts
  Future<List<Map<String, dynamic>>> getPosts() async {
    final response = await supabase.from('posts').select();
    return response;
  }
}
