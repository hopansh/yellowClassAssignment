import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/dbHelper.dart';

// ignore: must_be_immutable
class MovieList extends StatefulWidget {
  var data;

  MovieList(this.data);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var alert = false;
  var delIndex = -1;
  final dbHelper = DbHelper.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    Widget _listTile(data, index) {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/add");
        },
        child: Stack(
          children: [
            Container(
              height: height * 0.15,
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, (height * 0.1) + 10, 10, 5),
              padding: EdgeInsets.only(left: (width * 0.35) + 20, top: 20),
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      2.0, // Move to right 10  horizontally
                      3.0, // Move to bottom 10 Vertically
                    ),
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
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Director: " + data[index]['director'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/add");
                          },
                          icon: Icon(
                            Icons.edit,
                            size: 30,
                            color: Colors.deepOrange,
                          )),
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
                          ))
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
                child: Image(
                  image: NetworkImage(
                      "https://terrigen-cdn-dev.marvel.com/content/prod/1x/avengersendgame_lob_crd_05.jpg"),
                  fit: BoxFit.cover,
                ))
          ],
        ),
      );
    }

    return alert
        ? AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Once deleted it can't be recovered"),
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
                    print('Deleted $response');
                    setState(() {
                      alert = false;
                    });
                  },
                  child: Text("Delete"))
            ],
          )
        : (ListView.builder(
            padding: EdgeInsets.only(bottom: 50),
            itemCount: widget.data.length == 0 ? 1 : widget.data.length,
            itemBuilder: (context, index) {
              if (widget.data.length == 0)
                return Center(child: Text("Click on Add Button to add Movies"));

              return _listTile(widget.data, index);
            }));
  }
}
