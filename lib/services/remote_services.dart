import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societ_act/models/case_class.dart';
import 'package:societ_act/models/posts_class.dart';
import 'package:societ_act/services/server.dart';
import 'package:societ_act/views/search_cases_screen.dart';

class RemoteServices {
  static var client = http.Client();

  Future<List<Datum>?> fetchPosts() async {
    // try {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    final result = await InternetAddress.lookup(baseUrl);
    if (result.isNotEmpty && result[0].address.isNotEmpty) {
      var response = await client.get(
        Uri.https(baseUrl, postsRoute),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        List<Datum>? postsList = [];
        var posts = postFromJson(response.body);
        for (var i in posts.data) {
          Datum post = Datum(
            id: i.id,
            type: i.type,
            attributes: i.attributes,
          );
          postsList.add(post);
        }
        // print('Cases get request successful.');
        return postsList;
      } else {
        // print('Couldn\'t get posts! ${response.statusCode}');
        return null;
      }
    } else {
      // print('Address couldnt be looked at');
      return null;
    }
  }

  Future<List<Info>?> fetchCases(
    String location,
    String category,
    List<String> keywords,
    String token,
    BuildContext context,
  ) async {
    try {
      final result = await InternetAddress.lookup(baseUrl);
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        final response = await http.post(
          Uri.https(baseUrl, casesRoute, {
            'location': location,
            'category': category,
            'keywords': keywords,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        if (response.statusCode == 200) {
          List<Info>? infosList = [];
          var cases = caseFromJson(response.body);
          for (var i in cases.data) {
            Info info = Info(
              id: i.id,
              type: i.type,
              attributes: i.attributes,
            );
            infosList.add(info);
          }
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => SearchCasesScreen(
                cases: infosList,
                token: token,
              ),
            ),
          );
          await Flushbar(
            message: "Request Successful!",
            icon: const Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.green,
            ),
            backgroundColor: const Color(0xFF457B9D),
            duration: const Duration(seconds: 3),
            leftBarIndicatorColor: Colors.green,
          ).show(context);
          return infosList;
        } else {
          //show error message
          // print('Couldn\'t get posts! ${response.statusCode}');
          await Flushbar(
            message: "Request failed with status: ${response.statusCode}.",
            icon: const Icon(
              Icons.info_outline,
              size: 28.0,
              color: Color(0xFFE63946),
            ),
            backgroundColor: const Color(0xFF457B9D),
            duration: const Duration(seconds: 3),
            leftBarIndicatorColor: const Color(0xFFE63946),
          ).show(context);
          return null;
        }
      } else {
        // print('Address couldnt be looked at');
        await Flushbar(
          message: "Please check your internet connection and try again",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Color(0xFFE63946),
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: const Color(0xFFE63946),
        ).show(context);
        return null;
      }
    } catch (e) {
      // print(e);
      await Flushbar(
        message: "Data not found!",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Color(0xFFE63946),
        ),
        backgroundColor: const Color(0xFF457B9D),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: const Color(0xFFE63946),
      ).show(context);
    }
    return null;
  }

  Future<bool> addCase(
    Map<String, String> body,
    String filepath,
    String token,
    BuildContext context,
  ) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token',
    };
    try {
      var request =
          http.MultipartRequest('POST', Uri.https(baseUrl, postsRoute))
            ..fields.addAll(body)
            ..headers.addAll(headers)
            ..files.add(await http.MultipartFile.fromPath('picture', filepath));
      var response = await request.send();
      if (response.statusCode == 201) {
        await Flushbar(
          message: "Great! your post has been submitted",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.green,
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.green,
        ).show(context);
        return true;
      } else {
        await Flushbar(
          message: "Request failed with code ${response.statusCode}",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Color(0xFFE63946),
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: const Color(0xFFE63946),
        ).show(context);
        // print('Failed to post data: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      await Flushbar(
        message: "Request failed!",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Color(0xFFE63946),
        ),
        backgroundColor: const Color(0xFF457B9D),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: const Color(0xFFE63946),
      ).show(context);
      // print('$e');
      return false;
    }
  }

  Future<bool> addComment(
    String id,
    String comment,
    String token,
    BuildContext context,
  ) async {
    try {
      final response = await http.get(
        Uri.https(
          baseUrl,
          "$createCommentRoute/$id/$comment",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        await Flushbar(
          message: "Comment sent successfully!",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.green,
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.green,
        ).show(context);
        return true;
      } else {
        await Flushbar(
          message: "Request failed with code ${response.statusCode}",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Color(0xFFE63946),
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: const Color(0xFFE63946),
        ).show(context);
        return false;
      }
    } catch (e) {
      // print(e);
      await Flushbar(
        message: "Request failed!",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Color(0xFFE63946),
        ),
        backgroundColor: const Color(0xFF457B9D),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: const Color(0xFFE63946),
      ).show(context);
      return false;
    }
  }

  //--------------------------CASES-ADOPT-SERVICES-----------------------------

  Future<bool> adoptCase(
    String id,
    String username,
    String token,
    BuildContext context,
  ) async {
    try {
      final response = await http.get(
        Uri.https(
          baseUrl,
          "$adoptRoute/$id",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        await Flushbar(
          message: "Casse adopted from $username",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Colors.green,
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: Colors.green,
        ).show(context);
        return true;
      } else {
        await Flushbar(
          message: "Request failed with code ${response.statusCode}",
          icon: const Icon(
            Icons.info_outline,
            size: 28.0,
            color: Color(0xFFE63946),
          ),
          backgroundColor: const Color(0xFF457B9D),
          duration: const Duration(seconds: 3),
          leftBarIndicatorColor: const Color(0xFFE63946),
        ).show(context);
        return false;
      }
    } catch (e) {
      // print(e);
      await Flushbar(
        message: "Request failed!",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Color(0xFFE63946),
        ),
        backgroundColor: const Color(0xFF457B9D),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: const Color(0xFFE63946),
      ).show(context);
      return false;
    }
  }
}
