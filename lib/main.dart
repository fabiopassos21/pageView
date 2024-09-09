import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController? page;
  void scroll() {
    print('ssss');
  }

  @override
  void initState() {
    super.initState();
    page = PageController(initialPage: 1)..addListener(scroll);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: page,
      children: [
        Container(
          child: makePage(
              'https://images.pexels.com/photos/1576667/pexels-photo-1576667.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
        ),
        Container(
          child: makePage(
              'https://images.pexels.com/photos/592077/pexels-photo-592077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
        ),
        Container(
          child: makePage(
              'https://images.pexels.com/photos/1606328/pexels-photo-1606328.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
        ),
      ],
    );
  }

  Widget makePage(String image1) {
    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(image1), fit: BoxFit.cover),
          gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
            0.3,
            0.9
          ], colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.2)
          ])),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  '1',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
