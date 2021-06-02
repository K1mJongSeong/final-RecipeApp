import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_first_flutter_app/createPost.dart';
import 'package:my_first_flutter_app/commons/utils.dart';

class ThreadPostData {
  final String userName;
  final String userThumbnail;
  final String postDate;
  final String postTimeStamp;
  final String postContent;
  final String postImage;
  final int postLikeCount;
  final int postCommentCount;

  ThreadPostData(
      {this.userName,
      this.userThumbnail,
      this.postDate,
      this.postContent,
      this.postImage,
      this.postLikeCount,
      this.postCommentCount,
      this.postTimeStamp});
}

final List<String> entries4 = <String>[
  'assets/images/김치볶음밥.jpg',
  'assets/images/닭갈비.jpg',
  'assets/images/돼지고기김치볶음.jpg',
  'assets/images/떡볶이.jpg',
  'assets/images/오리주물럭.jpg',
  'assets/images/잡채.jpg',
  'assets/images/제육볶음.jpg',
  'assets/images/김치찌개.jpg',
  'assets/images/된장찌개.jpg',
  'assets/images/spoon.png',
];

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  bool _isLoading = false;
  @override
  void initState() {
    //_takeUserDataFromFB();
    super.initState();
  }

  void _incrementCounter() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => createPost()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/appbar6.PNG'),
        backgroundColor: Color(0xFFCCCC99),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('thread')
            .orderBy('postTimeStamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return Stack(
            children: [
              snapshot.data.documents.length > 0
                  ? ListView(
                      shrinkWrap: true,
                      children: snapshot.data.documents.map(_listTile).toList(),
                    )
                  : Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.grey[700],
                              size: 64,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                'There is no post',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: "Increment",
        child: Icon(Icons.create),
      ),
    );
  }

  Widget _listTile(DocumentSnapshot data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 12),
      child: Card(
        color: basic,
        elevation: 7.0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.perm_identity,
                        size: 34,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['userName'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          readTimestamp(data['postTimeStamp']),
                          style: TextStyle(fontSize: 16, color: Colors.black87),
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
                padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                child: Text(
                  data['postContent'],
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(
                height: 2,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Like ${data['postLikeCount']}',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.mode_comment),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Comment ${data['postCommentCount']}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
        // child: ListTile(
        //   onTap: (){
        //     print("tap the list tile");
        //   },
        //   title: Text(data.postContent,style: TextStyle(fontSize: 18),),
        // ),
      ),
    );
  }
}
