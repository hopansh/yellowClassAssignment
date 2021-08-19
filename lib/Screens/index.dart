import 'package:binged_movies/Screens/Components/MovieList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/dbHelper.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  var refresh = 1;
  @override
  void initState() {
    super.initState();
  }

  final dbHelper = DbHelper.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.0,
          backgroundColor: Color(0xff1D1D28),
        ),
        body: Container(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: MovieList(),
        ));
  }
}
