import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myhive/auth_value.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> saveAuthValue()async{
    final authBox = await Hive.openBox('authBox');
    authBox.put('token', 'auth-token-001');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hive"),
      ),
      body: const Center(
        child: Text("Tap button to save auth token"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          saveAuthValue();
          Navigator.push(context, CupertinoPageRoute(builder: (_)=> const AuthValueScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
