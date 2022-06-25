import 'package:flutter/material.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({Key? key}) : super(key: key);

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

// https://www.rguktong.ac.in/img/user-temp.jpg
class _PopularScreenState extends State<PopularScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Image.asset('assets/logo/logo.png'),
          title: const Text('Flutter Movie App'),
        ),
        body: GridView.builder(
          itemCount: 50,
          itemBuilder: (context, index) => buildPersonItem(index),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ));
  }
}

Padding buildPersonItem(int index) => Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: const [
            Flexible(
              child: Image(
                  image: NetworkImage(
                      'https://www.rguktong.ac.in/img/user-temp.jpg')),
            ),
            Text('Person Name')
          ],
        ),
      ),
    );
