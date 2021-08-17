import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedView extends StatelessWidget {
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
              Image(
                image: NetworkImage(
                    "https://terrigen-cdn-dev.marvel.com/content/prod/1x/avengersendgame_lob_crd_05.jpg"),
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Avengers",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                "Director: Kevin Feige",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
            ])));
  }
}
