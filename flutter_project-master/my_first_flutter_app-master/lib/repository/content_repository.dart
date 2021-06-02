class Contentrepository {
  Map<String, dynamic> data = {
    "kr": [
      {
        "cid": "1",
        "image": "assets/images/김치볶음밥.jpg",
        "name": "김치볶음밥",
        "explain": "김치볶음밥은 김치의 톡 쏘는 맛이 볶은 밥의 느끼함을 보완해주어 맛의 균형이 잘 맞는다",
        "like": "",
      },
      {
        "cid": "2",
        "image": "assets/images/닭갈비.jpg",
        "name": "닭갈비",
        "explain": "양념고추장에 재워 둔 닭갈비를 양배추·고구마·당근·파와 함께 볶는 음식",
        "like": "",
      },
      {
        "cid": "3",
        "image": "assets/images/돼지고기김치볶음.jpg",
        "name": "돼지고기김치볶음",
        "explain": "돼지고기를 김치·파와 함께 볶은 음식",
        "like": "",
      },
      {
        "cid": "4",
        "image": "assets/images/떡볶이.jpg",
        "name": "떡볶이",
        "explain": "떡과 부재료를 양념에 볶거나 끓여서 먹는 음식.",
        "like": "",
      },
      {
        "cid": "5",
        "image": "assets/images/오리주물럭.jpg",
        "name": "오리주물럭",
        "explain": "양념고추장에 재워 둔 오리고기를 양파·대파·부추·숙주나물 등과 함께 볶은 음식.",
        "like": "",
      },
      {
        "cid": "6",
        "image": "assets/images/잡채.jpg",
        "name": "잡채",
        "explain": "이름 그대로 잡다한 재료(당면, 돼지고기, 채소, 버섯 등)를 모아 볶은 음식.",
        "like": "",
      },
      {
        "cid": "7",
        "image": "assets/images/제육볶음.jpg",
        "name": "제육볶음",
        "explain": "양념고추장에 재워 둔 돼지고기를 볶은 음식.",
        "like": "",
      },
      {
        "cid": "8",
        "image": "assets/images/김치찌개.jpg",
        "name": "김치찌개",
        "explain": "한국의 대표적인 음식인 김치를 넣고 얼큰하게 끓인 음식.",
        "like": "",
      },
      {
        "cid": "9",
        "image": "assets/images/된장찌개.jpg",
        "name": "된장찌개",
        "explain": "된장을 푼 물에 갖은 재료를 넣어 끓인 음식.",
        "like": "",
      },
    ],
    "cn": [],
    "jp": [],
    "eu": [
      {
        "cid": "10",
        "image": "assets/images/spoon.png",
        "name": "머핀",
        "explain": "밀가루에 설탕, 유지, 우유, 달걀, 베이킹파우더 따위를 넣고 틀을 사용하여 오븐에 구워 낸 음식.",
        "like": "",
      },
    ],
  };

  final Map<String, String> locationTypeToString = {
    "kr": "한식",
    "cn": "중식",
    "jp": "일식",
    "eu": "양식",
  };

  Future<List<Map<String, String>>> loadContentsFromLocation(
      String location) async {
    await Future.delayed(Duration(milliseconds: 1000));
    return data[location];
  }
}
