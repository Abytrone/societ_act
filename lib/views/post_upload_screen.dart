import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:societ_act/models/category_class.dart';
import 'package:societ_act/models/location_class.dart';
import 'package:societ_act/services/remote_services.dart';
import 'package:societ_act/services/server.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../models/user_class.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({
    Key? key,
    required this.token,
    required this.user,
  }) : super(key: key);
  final String? token;
  final User? user;

  @override
  _PostUploadScreenState createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  @override
  void initState() {
    super.initState();
    // _getUserInfo();
  }

  RemoteServices service = RemoteServices();
  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();
  final TextEditingController post = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController manualLocation = TextEditingController();

  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    try {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (file != null) {
        setState(() {
          _file = File(file.files.single.path!);
          _platformFile = file.files.first;
        });
      }
    } catch (e) {
      await Flushbar(
        message: "Error picking image, please try again",
        icon: const Icon(
          Icons.info_outline,
          size: 28.0,
          color: Colors.red,
        ),
        backgroundColor: const Color(0xFF457B9D),
        duration: const Duration(seconds: 3),
        leftBarIndicatorColor: Colors.red,
      ).show(context);
      // ignore: avoid_print
      print(e);
    }
  }

  String? location = '';
  int? locationID = 0;
  String? category = '';
  int? categoryID = 0;
  List<String> keywords = [];
  String keys = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF457B9D),
                    ),
              ),
            ),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              if (formKey!.currentState!.validate()) {
                formKey!.currentState!.save();

                Map<String, String> body = {
                  'title': title.text,
                  'category': categoryID.toString(),
                  'location': locationID.toString(),
                  'description': post.text,
                  'keywords': keywords
                      .toString()
                      .substring(1, keywords.toString().length - 1),
                };
                service.addCase(
                    body,
                    _platformFile == null ? 'null' : _file!.path,
                    widget.token!,
                    context);
                formKey!.currentState!.reset();
                title.clear();
                manualLocation.clear();
                keywords.clear();
                post.clear();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFF1D3557),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Post',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xFFF1FAEE),
      ),
      body: Container(
        color: const Color(0xFFF1FAEE),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                    minRadius: 20,
                    backgroundImage:
                        NetworkImage('${widget.user!.data.picture}'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(widget.user!.data.fullname!),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '@${widget.user!.data.username!}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Divider(
              height: 10,
              color: Color.fromARGB(255, 87, 87, 87),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey!,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null) {
                                return '* Required';
                              } else {
                                return null;
                              }
                            },
                            controller: title,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: 'Enter Title',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: DropdownSearch<Location>(
                            // validator: (value) {
                            //   if (value == null) {
                            //     return '* Required';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            errorBuilder: (BuildContext context, value, index) {
                              return Center(
                                child: Text(
                                  'No Data',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                ),
                              );
                            },
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Select Location',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              isCollapsed: true,
                              border: InputBorder.none,
                            ),
                            popupTitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Select Location',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ],
                            ),
                            popupBackgroundColor: const Color(0xFFEDF1F4),
                            dropDownButton: const Icon(
                              FontAwesomeIcons.angleDown,
                              color: Color(0xFF457B9D),
                            ),
                            showSearchBox: true,
                            mode: Mode.DIALOG,
                            onFind: (filter) async {
                              var response = await Dio().get(locationRoute,
                                  options: Options(headers: {
                                    'Accept': '*/*',
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${widget.token}'
                                  }));
                              var models =
                                  Location.fromJsonList(response.data['data']);
                              return models;
                            },
                            onChanged: (data) {
                              setState(() {
                                location = data?.name;
                                locationID = data?.id;
                              });
                              // print(data);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: DropdownSearch<Category>(
                            validator: (value) {
                              if (value == null) {
                                return '* Required';
                              } else {
                                return null;
                              }
                            },
                            errorBuilder: (BuildContext context, value, index) {
                              return Center(
                                child: Text(
                                  'No Data',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                        fontSize: 12,
                                      ),
                                ),
                              );
                            },
                            dropdownSearchBaseStyle:
                                Theme.of(context).textTheme.bodyText1,
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Select Category',
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                            popupTitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Select Category',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ],
                            ),
                            popupBackgroundColor: const Color(0xFFEDF1F4),
                            dropDownButton: const Icon(
                              FontAwesomeIcons.angleDown,
                              color: Color(0xFF457B9D),
                            ),
                            showSearchBox: true,
                            mode: Mode.DIALOG,
                            onFind: (filter) async {
                              var response = await Dio().get(
                                categoryRoute,
                                options: Options(
                                  headers: {
                                    'Accept': '*/*',
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer ${widget.token}'
                                  },
                                ),
                              );
                              var models =
                                  Category.fromJsonList(response.data['data']);
                              return models;
                            },
                            onChanged: (data) {
                              setState(() {
                                category = data?.name;
                                categoryID = data?.id;
                              });
                              // print(data);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, left: 10, right: 10, bottom: 5),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFieldTags(
                            initialTags: const [],
                            tagsStyler: TagsStyler(
                              tagMargin: const EdgeInsets.only(right: 4.0),
                              tagCancelIcon: const Icon(Icons.cancel,
                                  size: 15.0, color: Colors.red),
                              tagCancelIconPadding:
                                  const EdgeInsets.only(left: 4.0, top: 2.0),
                              tagPadding: const EdgeInsets.only(
                                  top: 2.0, bottom: 4.0, left: 8.0, right: 4.0),
                              tagDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              tagTextStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF457B9D)),
                            ),
                            textSeparators: const [" "],
                            textFieldStyler: TextFieldStyler(
                              hintText: "Examples: Hospitals, School Building",
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              helperText: "Please use space to separate tags",
                              helperStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 12,
                                    color: Colors.amber[900],
                                  ),
                              contentPadding:
                                  const EdgeInsets.only(bottom: 5, top: 12),
                              textFieldBorder: InputBorder.none,
                              textFieldFocusedBorder: InputBorder.none,
                            ),
                            onDelete: (tag) {
                              // print('onDelete: $tag');
                              setState(() {
                                keywords.remove(tag);
                              });
                            },
                            onTag: (tag) {
                              // print('onTag: $tag');
                            },
                            validator: (tag) {
                              // print('validator: $tag');

                              if (tag == '') {
                                return "* Required";
                              } else {
                                keywords.add(tag);
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      // Post Text
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 12, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(
                                    0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return '* Required';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: post,
                                maxLines: 10,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  hintText:
                                      'Let the world know the issue you care about...\n\n\n\n\n\n\n\n\n\n\n',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        fontSize: 15,
                                      ),
                                  border: InputBorder.none,
                                ),
                              ),
                              const Divider(
                                height: 10,
                                color: Color.fromARGB(255, 87, 87, 87),
                              ),
                              InkWell(
                                onTap: (() => selectFile()),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      'Select image',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        FontAwesomeIcons.fileImage,
                                        color: Color(0xFF1D3557),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Post image to be uploaded
                      _platformFile == null
                          ? Container()
                          : InkWell(
                              onTap: (() => selectFile()),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 230,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: Image.file(
                                        _file!,
                                      ).image,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
