import 'package:flutter/material.dart';

void main() => runApp(const App());


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 246, 1, 181)),
        useMaterial3: true,
      ),
      home : const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Demo App by Ellen"),
        leading: const Text("Olha pra cá"),
        actions: const <Widget> [
          Icon(Icons.plus_one),
        ],
      ),
      // ignore: prefer_const_constructors
      body: const Center(child: Text("Olá Mundo")),
    );
  }

}