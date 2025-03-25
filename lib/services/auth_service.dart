import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // Sign up with email & password
  Future<String?> signUp(String email, String password) async {
    final response = await supabase.auth.signUp(email: email, password: password);
    return response.user != null ? null : response.error?.message;
  }
   //image upload
   Future<String?> uploadProfilePic(File imageFile, String userId) async {
    final fileExt = imageFile.path.split('.').last;
    final filePath = 'profiles/$userId.$fileExt';

    final response = await supabase.storage
        .from('fluttergram')
        .upload("images.jpg", imageFile);

    if (response.error == null) {
      final imageUrl = supabase.storage.from('fluttergram').getPublicUrl(filePath);
      return imageUrl;
    }
    return null;
  }

  // Login with email & password
  Future<String?> signIn(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(email: email, password: password);
    return response.user != null ? null : response.error?.message;
  }

  // Logout
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return supabase.auth.currentUser != null;
  Future<void> updateUserProfilePic(String userId, String imageUrl) async {
    await supabase.from('users').update({'profile_pic': imageUrl}).eq('id', userId);
  }
}
  }

