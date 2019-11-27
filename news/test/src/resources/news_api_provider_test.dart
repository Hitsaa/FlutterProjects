import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async{
    // Setup of test case
    final newsApi = NewsApiProvider();
//this mock client is essentially a testing version of the client class.
/*
Whenever we make use of my clients if we try to run some code that executes the request the request never actually goes to some outside API. There's no actual network request
completed.Instead the mock client will essentially instantly complete the request for us. It solves both the two issues that we're running into earlier.
Number one the request gets instantly completed.So it doesn't slow down our tests.Number two we have the ability to control the data that gets returned from the Mock clients.
 */

    newsApi.client = MockClient((Request request) async {
        return Response(json.encode([1,2,3,4]), 200);
    });

    final ids = await newsApi.fetchTopIds();
    expect(ids, [1,2,3,4]);
  });
  
  test('FetchItem returns a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((Request request) async {
      final jsonMap = {'id' : 123};
      return Response(json.encode(jsonMap),200);
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}

