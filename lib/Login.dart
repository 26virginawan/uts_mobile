import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:tokosepatu/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tokosepatu/DbHelper.dart';
import 'package:tokosepatu/EntryForm.dart';
import 'package:flutter/widgets.dart';
import 'models/item.dart'; //pendukung program asinkron

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;
  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<Item>();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'images/logo.png',
              height: 300,
              width: 300,
            ),
            Container(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person, color: Colors.black87),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  focusColor: Colors.orangeAccent,
                  hintText: 'Username',
                  hintStyle: GoogleFonts.poppins(color: Colors.black87),
                ),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.black87),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orangeAccent),
                  ),
                  focusColor: Colors.orangeAccent,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.poppins(color: Colors.black87),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 200, top: 15),
              child: Text(
                "Forgot Password?",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    )),
                color: Colors.orangeAccent,
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                },
              ),
            ),
            Container(
              child: Text(
                "Dont have an Account ? Sign Up",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
