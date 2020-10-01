import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.only(left: 60, right: 60, top: 250, bottom: 300),
          child: Container(
            // alterar para only
            padding: EdgeInsets.all(20),
            color: Colors.black.withOpacity(0.3),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(hintText: 'Digite o seu e-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'Sua senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
