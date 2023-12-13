import 'dart:convert';

import 'package:appstagram/model/account_model.dart';
import 'package:appstagram/model/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Account>> getDataAccounts() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.45:3000/account'));

    print('status code: ${response.statusCode}');
    var dataResponse = jsonDecode(response.body);

    List<Account> dataAccount =
        (dataResponse as List).map((e) => Account.fromJson(e)).toList();
    return dataAccount;
  }

  static Future<List<Post>> getDataPost() async {
    final response = await http.get(Uri.parse('http://192.168.1.45:3000/post'));

    print('status code: ${response.statusCode}');
    var dataResponse = jsonDecode(response.body);

    List<Post> dataPost =
        (dataResponse as List).map((e) => Post.fromJson(e)).toList();
    return dataPost;
  }

  static Future<List<Post>> getPostid(String id) async {
    final response =
        await http.get(Uri.parse('http://192.168.1.45:3000/post?id=' + id));

    print('status code : ${response.statusCode}');
    var dataResponse = jsonDecode(response.body);

    List<Post> dataPostId =
        (dataResponse as List).map((e) => Post.fromJson(e)).toList();
    return dataPostId;
  }
}
