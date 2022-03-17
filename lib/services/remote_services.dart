import 'dart:async';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:societ_act/models/case_class.dart';
import 'package:societ_act/models/posts_class.dart';
import 'package:societ_act/models/users_network_class.dart';
import 'package:societ_act/services/server.dart';
import 'package:societ_act/views/search_cases_screen.dart';
import 'package:societ_act/views/widgets/loading_dialog.dart';

class RemoteServices {
  static var client = http.Client();
  static Future<Post?> fetchPosts() async {
    try {
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
          // List<Datum>? postsList = [];
          var postsList = postFromJson(response.body);
          return postsList;
        } else {
          // print('Couldn\'t get posts! ${response.statusCode}');
          return null;
        }
      } else {
        print('Address couldnt be looked at');
        return null;
      }
    } on SocketException catch (_) {
      print(_);
      return null;
    }
  }

  Stream<List<NData>?> getPeople(String id, String type) =>
      Stream.fromFuture(fetchPeople(id, type));

  Future<List<NData>?> fetchPeople(String id, String type) async {
    // try {
    // Getting user token
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    final result = await InternetAddress.lookup(baseUrl);
    if (result.isNotEmpty && result[0].address.isNotEmpty) {
      if (type == '') {
        var response = await client.get(
          Uri.https(baseUrl, networkRoute),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        if (response.statusCode == 200) {
          List<NData>? peopleList = [];
          var posts = networkFromJson(response.body);
          for (var i in posts.data) {
            NData person = NData(
              id: i.id,
              type: i.type,
              attributes: i.attributes,
            );
            peopleList.add(person);
          }
          return peopleList;
        } else {
          // print('Couldn\'t get posts! ${response.statusCode}');
          return null;
        }
      } else if (type != '') {
        var response = await client.get(
          Uri.https(baseUrl, '$ffRoute/$type/$id'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        if (response.statusCode == 200) {
          List<NData>? peopleList = [];
          var posts = networkFromJson(response.body);
          for (var i in posts.data) {
            NData person = NData(
              id: i.id,
              type: i.type,
              attributes: i.attributes,
            );
            peopleList.add(person);
          }
          return peopleList;
        } else {
          return null;
        }
      }
      return null;
    } else {
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
    // try {
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
    } catch (e) {
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
    // } catch (e) {
    //   print(e);
    //   await Flushbar(
    //     message: "Data not found!",
    //     icon: const Icon(
    //       Icons.info_outline,
    //       size: 28.0,
    //       color: Color(0xFFE63946),
    //     ),
    //     backgroundColor: const Color(0xFF457B9D),
    //     duration: const Duration(seconds: 3),
    //     leftBarIndicatorColor: const Color(0xFFE63946),
    //   ).show(context);
    // }
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
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LoadingDialog();
      },
    );
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
        Navigator.pop(context);
        Navigator.of(context).pushNamed('home');
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
        Navigator.pop(context);
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
      Navigator.pop(context);
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

  Future<bool> casesAFR(
    String userCase,
    String type,
    String id,
    String username,
    String token,
    BuildContext context,
  ) async {
    try {
      if (userCase == 'case') {
        final response = await http.get(
          Uri.https(
            baseUrl,
            "$cases/$type/$id",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        if (response.statusCode == 200) {
          if (type == 'adopt') {
            await Flushbar(
              message: "Case adopted from $username",
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.green,
              ),
              backgroundColor: const Color(0xFF457B9D),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.green,
            ).show(context);
          } else if (type == 'resolve') {
            await Flushbar(
              message:
                  "Congratulations 🥳 $username, your case has been resolved 😊",
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.green,
              ),
              backgroundColor: const Color(0xFF457B9D),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.green,
            ).show(context);
          } else if (type == 'follow') {
            await Flushbar(
              message: "You have followed 🥳 $username post",
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.green,
              ),
              backgroundColor: const Color(0xFF457B9D),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.green,
            ).show(context);
          }

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
      } else if (userCase == 'user') {
        final response = await http.get(
          Uri.https(
            baseUrl,
            "$users/$type/$id",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        if (response.statusCode == 200) {
          if (type == 'follow') {
            await Flushbar(
              message: "You have followed 🥳 $username",
              icon: const Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.green,
              ),
              backgroundColor: const Color(0xFF457B9D),
              duration: const Duration(seconds: 3),
              leftBarIndicatorColor: Colors.green,
            ).show(context);
          }
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
      }
      return false;
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

  Future<bool> onLikeButtonTapped(
    bool isLiked,
    String id,
    String token,
    BuildContext context,
  ) async {
    /// send your request here
    // final bool success= await sendRequest();

    try {
      if (isLiked == false) {
        final response = await http.get(
          Uri.https(
            baseUrl,
            "$likeRoute/$id",
          ),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        if (response.statusCode == 200) {
          // print('$id LIKED = ${!isLiked}');
          return !isLiked;
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
          return !isLiked;
        }
      } else {
        // print('$id UNLIKED = ${!isLiked}');
        return !isLiked;
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
      return !isLiked;
    }

    /// if failed, you can do nothing
    // return success? !isLiked:isLiked;
  }

  // Logout method
  void logout(BuildContext context, String token) async {
    // logout from the server ...
    try {
      final result = await InternetAddress.lookup(baseUrl)
          .timeout(const Duration(seconds: 3));
      if (result.isNotEmpty && result[0].address.isNotEmpty) {
        final response = await http.post(
          Uri.https(baseUrl, logoutRoute),
          headers: {
            'Accept': '*/*',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );
        if (response.statusCode == 200) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.remove('user');
          localStorage.remove('token');
          Navigator.of(context).popAndPushNamed('login');
          // print('LOGGED OUT SUCCESSFULLY!');
          await Flushbar(
            message: "Logged out Successfully!",
            icon: const Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.green,
            ),
            backgroundColor: const Color(0xFF457B9D),
            duration: const Duration(seconds: 3),
            leftBarIndicatorColor: Colors.green,
          ).show(context);
        } else {
          // print(
          //     'COULD NOT LOGOUT. PLEASE TRY AGAIN LATER! ${response.statusCode}');
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
        }
      } else {
        // ignore: avoid_print
        print('ADDRESS LOOKED BUT SOMETHING BAD HAPPENED');
        // Navigator.of(context).pushNamed('nointernet');
      }
    } on SocketException catch (_) {
      Navigator.of(context).pushNamed('nointernet');
      // ignore: avoid_print
      print('Not Connected');
      await Flushbar(
        message: "The server cannot be reached at the moment!",
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
  }
}
