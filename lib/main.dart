import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
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

    page = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: PageView(
        scrollDirection: Axis.vertical,
        controller: page,
        children: [
          Container(
            child: makePage(
                'https://images.pexels.com/photos/1576667/pexels-photo-1576667.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                "USA",
                "Cidade lindas nos alpes da grecia",
                "1"),
          ),
          Container(
            child: makePage(
                'https://images.pexels.com/photos/592077/pexels-photo-592077.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                "Grecia",
                "Cidade lindas nos alpes da grecia, imagem da sedonia, com pinheiros e um por do sol de arrasar, a diaria custa em media 1500 USD",
                "2"),
          ),
          Container(
            child: makePage(
                'https://images.pexels.com/photos/1606328/pexels-photo-1606328.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                "Japan",
                "Cidade lindas nos alpes da grecia",
                "3"),
          ),
        ],
      ),
    );
  }

  Widget makePage(String image1, String title, String descrition, page) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    page.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '/4',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                )
              ],
            )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 15),
                ),
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 15),
                ),
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.yellow, size: 15),
                ),
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.grey, size: 15),
                ),
                Container(
                  margin: EdgeInsets.only(right: 3),
                  child: Icon(Icons.star, color: Colors.grey, size: 15),
                ),
                Text(
                  '4.0',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                Text("(2300)",
                    style: TextStyle(
                        color: Colors.white54, fontSize: 12, height: 1.5)),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(descrition,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.9),
                    fontSize: 15,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
