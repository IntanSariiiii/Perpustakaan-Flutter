import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://nbrctkrdolebqhruhnzp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5icmN0a3Jkb2xlYnFocnVobnpwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1NTM5NDQsImV4cCI6MjA0NzEyOTk0NH0.4krKjcrK0ixkX8I9HmitQf_jNKbISBDoGVYRpEKCknQ');
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Perpustakaan',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

