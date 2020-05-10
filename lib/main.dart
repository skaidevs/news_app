import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:newsapp/bloc/hn_bloc.dart';
import 'package:newsapp/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  final hcBloc = HackerNewsBloc();
  runApp(
    MyApp(
      bloc: hcBloc,
    ),
  );
}

class MyApp extends StatelessWidget {
  final HackerNewsBloc bloc;

  const MyApp({Key key, this.bloc}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newa App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'News',
        bloc: bloc,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);

  final String title;
  final HackerNewsBloc bloc;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
          initialData: UnmodifiableListView<Article>([]),
          stream: widget.bloc.articles,
          builder: (context, snapshot) => ListView(
                children: snapshot.data.map(_buildItem).toList(),
              )),
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
