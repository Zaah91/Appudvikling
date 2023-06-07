import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales/auth.dart';
import 'package:flutter/material.dart';
import 'package:sales/service/api-service.dart';
import 'package:sales/widget_tree.dart';
import '../models/post_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('API kald');
  }

  Widget _userUid() {
    return Text(user?.email ?? 'user email');
  }

  int _currentIndex = 0;

  void _onItemTapped(int index){
    if(index == 1){
      signOut();
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //_userUid(),
            Expanded(child: _body()), // Wrap i expanded for at det virker
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar( // importeret fra widget_tree.dart
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    
    );
  }

  FutureBuilder _body(){
    final apiService = ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future: apiService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done){
          final List<PostModel> posts = snapshot.data!;
          return _posts(posts);
        }
        else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      },
      );
  }

  Widget _posts(List<PostModel> posts){
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black38, width: 1),
          ),
          child: Column(
            children: [
              Text(
                posts[index].title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox( height: 10,),
              Text(
                posts[index].title
              )
            ]
            ),
        );
      },
    );
  }

}