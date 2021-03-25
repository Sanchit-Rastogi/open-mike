import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Open Mike',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        //leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
              postBox('Sanchit', 'This is a test post.', context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget postBox(String user, String post, BuildContext context) {
  return Container(
    padding: EdgeInsets.only(bottom: 25),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.lightBlueAccent,
          radius: 25,
        ),
        SizedBox(width: 20),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          width: MediaQuery.of(context).size.width * (0.7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(post),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 90,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Like',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.thumb_up,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
