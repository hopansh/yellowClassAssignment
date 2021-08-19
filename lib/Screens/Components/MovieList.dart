import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/dbHelper.dart';

// ignore: must_be_immutable
class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var alert = false;
  var delIndex = -1;
  var _loading = false;
  var mainData = [];

  final dbHelper = DbHelper.instance;
  getData() async {
    mainData = [];
    setState(() {
      _loading = true;
    });
    final response = await dbHelper.getMovieList();
    print('Data $response');
    response.forEach((element) {
      mainData.add(element);
    });
    mainData.sort((a, b) => b["_id"].compareTo(a["_id"]));
    setState(() {
      _loading = false;
    });
  }

  Future<void> _refreshMovies(BuildContext context) async {
    getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Widget _listTile(data, index) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/view");
        },
        child: Stack(
          children: [
            Container(
              height: height * 0.15,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, (height * 0.1) + 10, 10, 5),
              padding: EdgeInsets.only(left: (width * 0.35) + 20, top: 20),
              decoration: BoxDecoration(
                color: Color(0xff1D1D28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[index]['title'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Director: " + data[index]['director'],
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/add",
                                    arguments: data[index]['_id'])
                                .then((value) => _refreshMovies(context));
                          },
                          icon: Icon(Icons.edit,
                              size: 30, color: Colors.blueGrey[100])),
                      IconButton(
                          onPressed: () {
                            print('pressed $index');
                            setState(() {
                              delIndex = data[index]['_id'];
                              alert = true;
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            size: 30,
                            color: Colors.red,
                          )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: height * 0.23,
              width: width * 0.35,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Image.file(
                File(data[index]['poster']),
                height: 200,
                width: 120,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      );
    }

    return alert
        ? AlertDialog(
            title: Text(
              "Are you sure?",
              style: TextStyle(color: Colors.black),
            ),
            content: Text(
              "Once deleted it can't be recovered",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      delIndex = -1;
                      alert = false;
                    });
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () async {
                    final response = await dbHelper.delete(delIndex);
                    setState(() {
                      alert = false;
                    });
                    _refreshMovies(context);
                  },
                  child: Text("Delete"))
            ],
          )
        : _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshMovies(context),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.08,
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Binged Movies",
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Lucida',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          InkWell(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/add")
                                      .then((value) => _refreshMovies(context));
                                  ;
                                },
                                icon: Icon(
                                  Icons.add_circle,
                                  size: 35,
                                  color: Colors.deepOrange,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.87,
                      child: ListView.builder(
                          itemCount: mainData.length == 0 ? 1 : mainData.length,
                          itemBuilder: (context, index) {
                            if (mainData.length == 0)
                              return Center(
                                  heightFactor: 45,
                                  child: Text(
                                      "Click on Add Button to add Movies"));
                            return _listTile(mainData, index);
                          }),
                    ),
                  ],
                ));
  }
}
