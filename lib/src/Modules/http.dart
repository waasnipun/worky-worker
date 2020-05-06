import 'dart:convert';

import "package:http/http.dart" as http;

class RequestResult
{
  bool ok;
  dynamic data;
  RequestResult(this.ok, this.data);
}

const PROTOCOL = "http";
const DOMAIN = "192.168.1.5:8000";

 http_get(String route) async{
  var url = "http://10.0.2.2:8000/$route";
  var res = await http.get(Uri.encodeFull(url),headers:{"Accept":"application/json"});
  var responseBody = json.decode(res.body);
  return responseBody;
}

http_post(String route, var data) async{
  var url = "http://10.0.2.2:8000/$route";
  print(data);
  var dataStr = jsonEncode(data);
  var result = await http.post(Uri.encodeFull(url), body: dataStr, headers:{"Content-Type":"application/json"});
  print(dataStr);
  return RequestResult(true, jsonDecode(result.body));
}