import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  String siteUrl = 'api.themoviedb.org';
  String popularUrl = '/person/popular';
  String apiKey = 'bbecbb43c11c9129838f5450ab5f254e';
  String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYmVjYmI0M2MxMWM5MTI5ODM4ZjU0NTBhYjVmMjU0ZSIsInN1YiI6IjYyYjM2ZmM0MDI1NzY0MDA1Mjc2Nzg1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yUdtEmn3CXG9benuQ2jvxXSmh85VzhOIXysUNSSs35w';

  Future<dynamic> getPersonData() async {
    var personData;
    Uri uri = Uri.parse('https://$siteUrl/3$popularUrl?api_key=$apiKey&page=1');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      String data = response.body;
      personData = jsonDecode(data)['results'];
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return personData;
  }

  Future<String> getProfileImagePath(int id) async {
    var personData = await getPersonData();
    String personImage = personData[id]['profile_path'];
    if (kDebugMode) print(personImage);
    return personImage;
  }

  Future<String> getPersonName(int id) async {
    var personData = await getPersonData();
    String personName = personData[id]['name'];
    if (kDebugMode) print(personName);
    return personName;
  }

  @override
  void initState() {
    getPersonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Image.asset('assets/logo/logo.png'),
          title: Text('Popular Persons'),
        ),
        body: GridView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => buildPersonItem(index),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        ));
  }

  Padding buildPersonItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Flexible(
            child: FutureBuilder(
                future: getProfileImagePath(index),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    return Image(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${snapshot.data.toString()}'));
                  }
                }),
          ),
          FutureBuilder(
              future: getPersonName(index),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Center(child: Text(snapshot.data.toString()));
                }
              })
        ],
      ),
    );
  }
}
