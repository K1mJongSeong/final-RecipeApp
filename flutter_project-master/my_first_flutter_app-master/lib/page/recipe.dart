import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/components/manor_widget.dart';
import 'package:my_first_flutter_app/repository/explain_repository.dart';
import 'package:my_first_flutter_app/page/home.dart';

class Recipeview extends StatefulWidget {
  Map<String, String> data;
  Recipeview({Key key, this.data}) : super(key: key);

  @override
  _RecipeviewState createState() => _RecipeviewState();
}

class _RecipeviewState extends State<Recipeview> {
  Size size;
  int _current;
  String currentmenu;
  Explainrepository explainrepository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
    _current = 0;
    currentmenu = widget.data["cid"];
  }

  @override
  void initState() {
    super.initState();
    explainrepository = Explainrepository();
  }

  Widget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back),
        color: Colors.white,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.share),
          color: Colors.white,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert),
          color: Colors.white,
        ),
      ],
    );
  }

  Widget _callimg() {
    return Container(
      child: Stack(
        children: [
          Hero(
              tag: widget.data["cid"],
              child: Image.asset(
                widget.data["image"],
                width: size.width,
                fit: BoxFit.fill,
              )),
        ],
      ),
    );
  }

  Widget _userInfo() {
    return Row(
      children: [
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
        //   child: Container(
        //     width: 50,
        //     height: 50,
        //     child: Image.asset("assets/images/cook.PNG"),
        //   ),
        // )
        CircleAvatar(
          radius: 25,
          backgroundImage: Image.asset("assets/images/cook.PNG").image,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "김종성",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Expanded(
            child: ManorTemperature(
          manorTemp: 82.5,
        ))
      ],
    );
  }

  Widget _line() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  _loadexplains() {
    return explainrepository.loadExplainsFromLocation(currentmenu);
  }

  Widget _contentDetail(List<Map<String, String>> exdata) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Text(
                widget.data["name"],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                //locationTypeToString[currentmenu],
                "한식",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 15),
              Text(
                exdata[_current]["ex1"],
                style: TextStyle(fontSize: 12, height: 1.5),
              ),
              Text(
                exdata[_current]["ex2"],
                style: TextStyle(fontSize: 12, height: 1.5),
              ),
              Text(
                exdata[_current]["ex3"],
                style: TextStyle(fontSize: 12, height: 1.5),
              ),
              Text(
                exdata[_current]["ex4"],
                style: TextStyle(fontSize: 12, height: 1.5),
              ),
              Text(
                exdata[_current]["ex5"],
                style: TextStyle(fontSize: 12, height: 1.5),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            height: 1,
            color: Colors.grey.withOpacity(0.3),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "만드는 법",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                exdata[_current]["tip1"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip2"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip3"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip4"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip5"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip6"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip7"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip8"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip9"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                exdata[_current]["tip10"],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _exreturn() {
    return FutureBuilder(
        future: _loadexplains(),
        builder: (BuildContext context, dynamic snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return _contentDetail(snapshot.data);
          }
          return Center(
            child: Text("데이터 오류"),
          );
        });
  }

  Widget _bodyWidget() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            _callimg(),
            _userInfo(),
            _line(),
            _exreturn(),
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}
