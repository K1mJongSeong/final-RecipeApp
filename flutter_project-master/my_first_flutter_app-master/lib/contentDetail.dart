import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/FB/FBCloudStore.dart';
import 'package:my_first_flutter_app/commons/const.dart';
import 'colors.dart';
import 'package:my_first_flutter_app/commons/utils.dart';

class ContentDetail extends StatefulWidget {
  const ContentDetail({Key key, this.postData, this.myData}) : super(key: key);
  final DocumentSnapshot postData;
  final MyProfileData myData;
  @override
  _ContentDetailState createState() => _ContentDetailState();
}

class _ContentDetailState extends State<ContentDetail> {
  final TextEditingController _msgTextController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/appbar6.PNG',
            fit: BoxFit.fill,
            width: 1000,
          ),
          backgroundColor: (Color(0xFFCCCC99)),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('thread')
                .document(widget.postData['userName'])
                .collection('comment')
                .orderBy('commentTimeStamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return LinearProgressIndicator();
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            //color: basic,
                            color: Colors.white,
                            elevation: 7.0,
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // CircleAvatar(
                                      //   radius: 40,
                                      //   backgroundImage: NetworkImage(user.photoURL),
                                      // ),
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 2.0, 10.0, 2.0),
                                          //child: getProfileImage(),
                                          child: Icon(
                                            Icons.account_circle,
                                            size: 34,
                                          )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.postData['userName'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              Utils.readTimestamp(widget
                                                  .postData['postTimeStamp']),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 10, 4, 10),
                                    child: Text(
                                      widget.postData['postContent'],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  // widget.postData['postImage'] != 'NONE'   // -----------< 오류 있음 firebase에 이미지 넣고 Test 해봐야함
                                  //     ? GestureDetector(
                                  //         // onTap: () {
                                  //         //   _moveToContentDetail();
                                  //         // },
                                  //         child: Utils.cacheNetworkImageWithEvent(
                                  //             context, widget.postData['postImage'], 0, 0))
                                  // :
                                  Container(),
                                  Divider(
                                    height: 2,
                                    color: Colors.black,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.thumb_up,
                                              size: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Like ( ${widget.postData['postLikeCount']} )',
                                                style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.mode_comment),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Comment ( ${snapshot.data.documents.length} )',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          snapshot.data.documents.length > 0
                              ? ListView(
                                  shrinkWrap: true,
                                  children:
                                      snapshot.data.documents.map((document) {
                                    return _commentListItem(document, size);
                                  }).toList(),
                                )
                              : Container(),
                          //_commentListItem(size),
                          //_commentListItem(size),
                        ],
                      ),
                    ),
                  ),
                  _buildTextComposer()
                ],
              );
            }));
  }

  Widget _commentListItem(DocumentSnapshot data, Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 2.0, 10.0, 2.0),
                  child: Icon(
                    Icons.account_circle,
                    size: 34,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              data['userName'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              data['commentContent'],
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    width: size.width - 75,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Container(
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(Utils.readTimestamp(data['commentTimeStamp'])),
                          Text(
                            'Like',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                          ),
                          Text(
                            'Reply',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800]),
                          ),
                        ],
                      ),
                    ),
                    // Text(readTimestamp(widget.postData['postTimestamp'])
                    // ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 10,
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: 12,
                      color: Colors.blue[900],
                    ),
                    Text(
                      '1',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: [
            new Flexible(
              child: new TextField(
                controller: _msgTextController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Write a comment"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 2.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () {
                    print('${_msgTextController.text}');
                    _handleSubmitted(_msgTextController.text);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {
      await FBCloudStore.commentToPost(
          widget.postData['userName'], _msgTextController.text, widget.myData);
      await FBCloudStore.updatePostCommentCount(widget.postData);
      FocusScope.of(context).requestFocus(FocusNode());
      _msgTextController.text = '';
    } catch (e) {}
  }
}
