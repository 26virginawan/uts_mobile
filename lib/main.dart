//kode utama Aplikasi tampilan awal
import 'package:flutter/material.dart';
import 'package:tokosepatu/home.dart'; //package letak folder Anda

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tambahkan Item',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Home(),
    );
  }
}
