import 'package:flutter/material.dart';
import 'package:open_mike/home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome To,",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 30),
            Text(
              "OPEN MIKE",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(hintText: 'Enter your wallet address'),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text('Register', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
