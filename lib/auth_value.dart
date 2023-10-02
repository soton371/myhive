import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myhive/recipient/recipient.dart';

class AuthValueScreen extends StatefulWidget {
  const AuthValueScreen({super.key});

  @override
  State<AuthValueScreen> createState() => _AuthValueScreenState();
}

class _AuthValueScreenState extends State<AuthValueScreen> {
  String? token;

  Future<void> fetchToken() async {
    final authBox = await Hive.openBox('authBox');
    token = authBox.get("token");
    setState(() {});
  }

  Future<void> deleteToken() async {
    final authBox = await Hive.openBox('authBox');
    authBox.delete("token");
    token = authBox.get("token");
    debugPrint("token after log out: $token");
  }

  @override
  void initState() {
    super.initState();
    fetchToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Auth Value"),
      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(token??'init'),
          ElevatedButton(onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (_)=>const RecipientScreen()));
          }, child: const Text("Go to Recipient"))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteToken();
          Navigator.pop(context);
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
