import 'dart:io';

import 'package:binged_movies/helpers/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedView extends StatefulWidget {
  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  var _isInit = true;
  final dbHelper = DbHelper.instance;
  var title = "";
  var director = "";
  var image;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      final colId = ModalRoute.of(context).settings.arguments;
      if (colId != null) {
        final res = await dbHelper.getMovie(colId);
        setState(() {
          title = res[0]['title'].toString();
          director = res[0]['director'].toString();
          image = res[0]['poster'];
        });
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                "Director: " + director,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 20.0,
              ),
              image != null
                  ? Image.file(
                      File(image),
                      height: 500,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : CircularProgressIndicator(),
            ])));
  }
}
