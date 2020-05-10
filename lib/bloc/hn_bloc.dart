import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:newsapp/models/article.dart';
import 'package:rxdart/rxdart.dart';

class HackerNewsBloc {
  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[];

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

  HackerNewsBloc() {
    _updateArticles().then((_) => {
          _articlesSubject.add(
            UnmodifiableListView(_articles),
          ),
        });
  }

  Future<Null> _updateArticles() async {
    final futureArticles = _ids.map((id) => _getArticle(id: id));
    final articles = await Future.wait(futureArticles);
    _articles = articles;
  }

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
}
