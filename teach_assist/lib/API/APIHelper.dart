import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Utils/Config/env.dart';

///Used for making API calls to server

class APIHelper {
  static String BASE_URI = Env.BASE_URI;

  static const Map<String, String> _header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',

  };

  static Future post({
    required String uri,
    dynamic body,
    Map<String, String> header = _header,
    String errorMsg = "Failed",
  }) async {
    final res = await http.post(
      Uri.parse(BASE_URI + uri),
      headers: header,
      body: body,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      // print("postReq: ${res.body}");
      return jsonDecode(res.body);
    } else {
      print("#post-error: ${res.body}");
      throw Exception({"msg": errorMsg, "res": res});
    }
  }

  static Future get({
    required String uri,
    Map<String, String> header = _header,
    dynamic body,
    String errorMsg = "Failed",
  }) async {
    final res = await http.get(
      Uri.parse(BASE_URI + uri),
      headers: header,
    );
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception({"msg": errorMsg, "res": res});
    }
  }

  static Future put({
    required String uri,
    dynamic body,
    Map<String, String> header = _header,
    String errorMsg = "Failed",
  }) async {
    final res = await http.put(
      Uri.parse(BASE_URI + uri),
      headers: header,
      body: body,
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception({"msg": errorMsg, "res": res});
    }
  }

  static Future delete({
    required String uri,
    Map<String, String> header = _header,
    String errorMsg = "Failed",
  }) async {
    final res = await http.delete(
      Uri.parse(BASE_URI + uri),
      headers: header,
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception({"msg": errorMsg, "res": res.body});
    }
  }
}

// void main() async {
//   try {
//     // final postRes = await APIHelper.post(
//     //   uri: "/documents/many",
//     //   body: jsonEncode([
//     //     {"niraj": 1511},
//     //     {"niraj2": 1511}
//     //   ]),
//     // );
//     // print("#postRes $postRes");
//
//     final getRes = await APIHelper.get(uri: "/documents");
//     print("#getRes $getRes");
//
//     // final putRes = await APIHelper.put(
//     //   uri: "/documents/1",
//     //   body: jsonEncode({"niraj": 1512}),
//     // );
//     // print("#putRes $putRes");
//     //
//     // final deleteRes = await APIHelper.delete(uri: "/documents/1");
//     // print("#deleteRes $deleteRes");
//   } catch (e) {
//     print("Error: $e");
//   }
// }
