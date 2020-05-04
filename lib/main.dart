import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newa App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  List<Article> _articles = articles;
  List<int> _ids = [
    23064716,
    23064714,
    23064703,
    23064702,
    23064673,
    23064635,
    23064631,
    23064622,
    23064585,
    23064557,
    23064538,
    23064529,
  ];

  Future<Article> _getArticle({int id}) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/${id}.json';
    final storyResponse = await http.get(storyUrl);
    if (storyResponse.statusCode == 200) {
      print("Check   ${parseArticle(storyResponse.body)}");
      return parseArticle(storyResponse.body);
    } else {
      print("ERROR   ${parseArticle(storyResponse.body)}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: _ids
            .map(
              (ids) => FutureBuilder<Article>(
                  future: _getArticle(id: ids),
                  builder:
                      (BuildContext context, AsyncSnapshot<Article> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _buildItem(snapshot.data);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )
            .toList(),
      ),
    );
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: const EdgeInsets.all(14.0),
      child: ExpansionTile(
        title: Text(
          article.title ?? 'N/A',
          style: TextStyle(fontSize: 20.0),
        ),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.launch),
                color: Colors.green,
                onPressed: () async {
                  if (await canLaunch(article.url)) {
                    launch(article.url);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
