import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MovieList extends StatelessWidget {
  var data;
  MovieList(this.data);

  @override
  Widget build(BuildContext context) {
    Widget _listTile(data, index) {
      return ListTile(
        onTap: () => {Navigator.pushNamed(context, '/view')},
        title: Text(
          data[index]['title'],
        ),
        subtitle: Text(data[index]['director']),
        trailing: Icon(
          Icons.open_in_new,
          color: Colors.deepOrange,
        ),
      );
    }

    return (ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _listTile(data, index);
        }));
  }
}
