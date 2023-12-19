import 'package:flutter/material.dart';
import 'package:workspace/Pages/workhome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const Home()
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: workHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}