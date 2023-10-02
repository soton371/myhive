import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myhive/home.dart';
import 'package:myhive/models/recipient_mod.dart';
import 'package:myhive/recipient/recipient.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(RecipientModelAdapter());
  await Hive.openBox<RecipientModel>("recipient");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
