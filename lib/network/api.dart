class API {

  static const String BASE_URL = "https://jsonplaceholder.typicode.com/";
  static const post = "posts";
}

enum EndPoint {
  POST,
}

extension MyUrl on EndPoint {
  Uri get url {
    return Uri.parse("${API.BASE_URL}/${['posts'][index]}");
  }
}