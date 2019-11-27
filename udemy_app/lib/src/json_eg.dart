import 'dart:convert';
void main() {
  var rawJson = '{"url": "http://blah.jpg","id": 1}';

  var parsedJson = json.decode(rawJson);
  //print(parsedJson['id']);

  //var imageModel = new ImageModel(parsedJson['id'], parsedJson['url']);
  var imageModel = new ImageModel.fromJson(parsedJson);
  print(imageModel.url);
  //new ImageModel(10,'http://laksjd');
  //print(imageModel.id);
  //print(imageModel.url);
}

class ImageModel {
  int id;
  String url;

  ImageModel(this.id, this.url);

  ImageModel.fromJson(parsedJson) {
    id = parsedJson['id'];
    url = parsedJson['url'];
  }

}