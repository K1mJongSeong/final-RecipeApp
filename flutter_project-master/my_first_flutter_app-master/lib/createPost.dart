import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:my_first_flutter_app/commons/const.dart';
import 'package:my_first_flutter_app/commons/utils.dart';
import 'package:my_first_flutter_app/FB/FBCloudStore.dart';
import 'package:my_first_flutter_app/FB/FBStorage.dart';

class createPost extends StatefulWidget {
  MyProfileData myData;
  createPost({this.myData});
  @override
  _createPostState createState() => _createPostState();
}

class _createPostState extends State<createPost> {
  TextEditingController writingTextController = TextEditingController();
  FocusNode writingTextFocus = FocusNode();
  final FocusNode _nodeText1 = FocusNode();
  bool _isLoading = false;
  File _postImageFile;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          displayArrows: false,
          focusNode: writingTextFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () {
                  print('Select Image');
                  _getImageAndCrop();
                },
                child: Container(
                  color: Colors.grey[200],
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add_photo_alternate, size: 28),
                      Text(
                        "Add Image",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ],
        ),
      ],
    );
  }

  void _postToFB() async {
    setState(() {
      _isLoading = true;
    });
    String postID = Utils.getRandomString(8) + Random().nextInt(500).toString();
    String postImageURL;
    if (_postImageFile != null) {
      postImageURL = await FBStorage.uploadPostImages(
          postID: postID, postImageFile: _postImageFile);
    }
    FBCloudStore.sendPostInFirebase(postID, writingTextController.text,
        widget.myData, postImageURL ?? 'NONE');

    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  Future<void> _sendPostInFirebase(String postContent) async {
    setState(() {
      _isLoading = true;
    });
    Firestore.instance.collection('thread').document().setData({
      //'postID': postID,
      'userName': 'KimJongSeong',
      'userThumnail': '',
      'postTimeStamp': DateTime.now().millisecondsSinceEpoch,
      'postContent': postContent,
      'postImage': 'testUserImage',
      'postLikeCount': 0,
      'postCommentCount': 0
    });
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFCCCC99),
        title: Text('게시물 작성'),
        centerTitle: true,
        actions: [
          FlatButton(
            onPressed: () {
              print("Post content is ${writingTextController.text}");
              _sendPostInFirebase(writingTextController.text);
            },
            child: Text(
              'Post',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: KeyboardActions(
        config: _buildConfig(context),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 28,
                ),
                Card(
                  color: Colors.white,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    width: size.width,
                    height: size.height -
                        MediaQuery.of(context).viewInsets.bottom -
                        80,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 14.0, left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            height: 1,
                            color: Colors.black,
                          ),
                          TextFormField(
                            autofocus: true,
                            focusNode: writingTextFocus,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Start Writing',
                              hintMaxLines: 4,
                            ),
                            controller: writingTextController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            _isLoading
                ? Positioned(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                      color: Colors.white.withOpacity(0.7),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Future<void> _getImageAndCrop() async {
    File imageFileFromGallery =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFileFromGallery != null) {
      File cropImageFile = await Utils.cropImageFile(
          imageFileFromGallery); //await cropImageFile(imageFileFromGallery);
      if (cropImageFile != null) {
        setState(() {
          _postImageFile = cropImageFile;
        });
      }
    }
  }
}
