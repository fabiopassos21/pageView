import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pageview/post.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import "dart:async";

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
  double turn = 1;
  Future<List<Post>> recuperaPost() async {
    http.Response response = await http
        .get(Uri.parse("https://api.jsonbin.io/v3/b/66e07b64acd3cb34a8815cf5"));

    var dadosJson = json.decode(response.body);

    List<Post> postagens = [];

    for (var post in dadosJson['record']['post']) {
      Post p = Post(post["id"], post["local"], post["nome"], post["img"],
          post["estrela"]);

      postagens.add(p);
    }
    postagens.shuffle();

    return postagens;
  }

  put() async {
    var url = Uri.parse("https://api.jsonbin.io/v3/b/66e07b64acd3cb34a8815cf5");
    var getResponse = await http.get(url, headers: {
      "Content-Type": "application/json",
    });
    if (getResponse.statusCode == 200) {
      Map<String, dynamic> dadosExistente = json.decode(getResponse.body);
      Map<String, dynamic> novoRestaurante = {
        "id": 12,
        "local": "Novo Restaurante",
        "nome": "Descrição do novo restaurante...",
        "img":
            "https://cdn.pixabay.com/photo/2023/07/26/16/43/food-8151625_640.jpg",
        "estrela": 5
      };
      dadosExistente["record"]["post"].add(novoRestaurante);
      var body = json.encode(dadosExistente);
      var putResponse = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: body,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    page = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: recuperaPost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao Carregar Dados"));
          } else if (snapshot.hasData) {
            List<Post> posts = snapshot.data!;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: page,
              itemCount: 5,
              itemBuilder: (context, index) {
                Post post = posts[index];
                return makePage(
                  post.img,
                  post.local,
                  post.nome,
                  index + 1,
                  post.estrela,
                );
              },
            );
          }
          ;
          return Text("Deu certo ");
        },
      ),
    );
  }

  Widget makePage(String img, String title, String descrition, page, int star) {
    List<Widget> estrelaWidget = [];
    for (int i = 0; i < star; i++) {
      estrelaWidget.add(
        Container(
          margin: EdgeInsets.all(3),
          child: Icon(
            Icons.star,
            color: Colors.yellow,
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover),
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
                    '/5',
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedRotation(
                  turns: turn,
                  duration: Duration(seconds: 1),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          turn += 1;
                          recuperaPost();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      label: Icon(Icons.refresh, color: Colors.amber)),
                ),
                Row(
                  children: estrelaWidget,
                ),
                Text(
                  star.toString() + ('.0'),
                  style: TextStyle(
                    color: Colors.white,
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
            ElevatedButton(onPressed: put, child: Text("Gerar Post "))
          ],
        ),
      ),
    );
  }
}
