import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'theme.dart';
import 'my_app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ragpqfnnlvplgggxpxyg.supabase.co', // Replace with your Supabase URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJhZ3BxZm5ubHZwbGdnZ3hweHlnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI3MjE0OTcsImV4cCI6MjA1ODI5NzQ5N30.JqlInegfFddos6Qp4NLUU1FOqv9LPl9qBndbiS2qCCw', // Replace with your Supabase Anon Key
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterGram with Supabase',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
class NotificationService {
  final SupabaseClient supabase = Supabase.instance.client;

  void listenForNotifications() {
    supabase
        .from('likes')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      if (data.isNotEmpty) {
        print('New Like Notification: ${data.last}');
        // Handle notification UI
      }
    });

    supabase
        .from('comments')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) {
      if (data.isNotEmpty) {
        print('New Comment Notification: ${data.last}');
        // Handle notification UI
      }
    });
  }
}









