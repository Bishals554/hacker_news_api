import 'package:flutter/material.dart';
import 'package:news_flutter/presentation/comment_page.dart';

import '../api.dart';






class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final topStories = [];
  var items = [];
  var comments = [];
  var selectedIndex;

  @override
  void initState() {
    super.initState();
    getTopStories();
  }

  getTopStories() async {
    final topStories = await Api.getTopStories();
    final response = topStories.take(20).map((id) => Api.getItem(id));
    final itemData = await Future.wait(response);


    setState(() {
      items = itemData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        elevation: 0,
        title: Text('Top News'),
      ),
      body: items.isEmpty ? Center(child: CircularProgressIndicator()): ListView.builder(
        itemCount: items.length,
          itemBuilder: (context, index){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: ListTile(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentPage(index: index, items: items)));
                   // Get.to(() => CommentPage(index: index, items: items));
                 },
                  title: Text(items[index]['title'],style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                ),
              );
          }
      ),
    );
  }
}
