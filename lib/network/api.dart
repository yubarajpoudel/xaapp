class API {

  static const String BASE_URL = "https://my-json-server.typicode.com/yubarajpoudel/xaapp";
  static const post = "posts";
  static const comment = "comments";
}

enum EndPoint {
  POST,
  COMMENT
}

extension MyUrl on EndPoint {
  Uri get url {
    return Uri.parse("${API.BASE_URL}/${['posts', 'comments'][index]}");
  }
}