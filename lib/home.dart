import 'package:blog/create_blog.dart';
import 'package:blog/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



class HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();

  QuerySnapshot blogSnapshot;

  Widget BlogsList(){
    return Container(
      child: Column(
        children: <Widget>[
          blogSnapshot != null ? ListView.builder(
            itemCount: blogSnapshot.documents.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
              return BlogsTile(
                authorName: blogSnapshot.documents[index].data['authorName'],
                title: blogSnapshot.documents[index].data['title'],
                description: blogSnapshot.documents[index].data['desc'],
                imgUrl: blogSnapshot.documents[index].data['imgUrl'],

              );
              }) : Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),)
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    crudMethods.getData().then((result){
      blogSnapshot = result;
    });


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Flutter', style: TextStyle(
              color: Colors.white,
              fontSize: 22,

            ),),
            Text('Blog', style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 22,
            ),)
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlogsList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}



class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;
  BlogsTile({@required this.imgUrl, @required this.title, @required this.description,@required this.authorName});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imgUrl)),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text('title'),
                Text('description'),
                Text('authorName')
              ],
            ),
          )
        ],
      ),
    );
  }
}
