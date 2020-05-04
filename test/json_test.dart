import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/article.dart';

void main() {
  test('parses topstories.json', () {
    const jsonString =
        '[23057411,23055335,23061236,23042618,23054881,23062001,23061371,23042616,23060643,23060607,23051122,23054061,23050717,23057363,23042617,23057697,23052066,23057686,23051415,23057500,23056401,23050509,23060699,23055470,23052836,23058232,23056925,23057426,23056723,23046107,23050018,23044538,23052179,23051690,23051492,23056634,23045080,23050394,23049764,23047687,23049561,23041095,23056758,23044967,23042528,23041589,23040444,23040406,23047728,23038878,23051799,23045182,23060751,23060743,23060724,23060632,23060600,23060510,23060316,23060178,23060161,23060129,23059893,23059313,23058980,23058876,23058295,23058101]';

    expect(parseTopStories(jsonString).first, 23057411);
  });

  test(
    'parses item.json or Network',
    () async {
      final urlPrefix = 'https://hacker-news.firebaseio.com/v0/newstories.json';

      final response = await http.get(urlPrefix);
      if (response.statusCode == 200) {
        final idList = parseTopStories(response.body);
        if (idList.isNotEmpty) {
          final storyUrl =
              'https://hacker-news.firebaseio.com/v0/item/${idList.first}.json';
          final storyResponse = await http.get(storyUrl);
          if (storyResponse.statusCode == 200) {
            print("Check   ${parseArticle(storyResponse.body).by}");
            expect(parseArticle(storyResponse.body), isNotNull);
          } else {
            print("ERROR   ${parseArticle(storyResponse.body)}");
          }
        }
      }
    },
  );
}
