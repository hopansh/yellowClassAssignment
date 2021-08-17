import 'package:binged_movies/Screens/Components/MovieList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/dbHelper.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool _loading = true;
  var data = [];
  Future<void> _refreshMovies(BuildContext context) async {
    getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  final dbHelper = DbHelper.instance;
  getData() async {
    data = [];
    final response = await dbHelper.getMovieList();
    print('Data $response');
    response.forEach((element) {
      data.add(element);
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: height * 0.15,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            " Binged Movies",
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {Navigator.pushNamed(context, '/add')},
          child: Icon(Icons.add),
        ),
        body: Container(
          height: height * 0.85,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _loading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  child: MovieList(data),
                  onRefresh: () => _refreshMovies(context)),
        ));
  }
}
