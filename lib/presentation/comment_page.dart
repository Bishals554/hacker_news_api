import 'package:flutter/material.dart';
import '../api.dart';
import 'dart:convert';



class CommentPage extends StatefulWidget {
  final int index;
  final List items;

  CommentPage({
    required this.index,
    required this.items
});



  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var comments = [];

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    final commentIds = List<int>.from(widget.items[widget.index]['kids']);
    final response = commentIds.map((id) => Api.getItem(id));
    final commentData = await Future.wait(response);
    setState(() {
      comments = commentData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: comments.isEmpty ? Center(child: CircularProgressIndicator()) : ListView.builder(
        itemCount: comments.length,
          itemBuilder: (context, index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade300,
              border: Border.all(width: 2)
            ),
            margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: ListTile(
              title: Text((comments[index]['text'])),


            ),

          );

          }
      ),

    );
  }
}
