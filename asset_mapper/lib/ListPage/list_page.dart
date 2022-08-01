/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is the ListPage demo
* TODO: Expanded database and finish this page as 3rd page
*/

import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asset List", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: const ListPageContent(),
    );
  }
}

class ListPageContent extends StatefulWidget {
  const ListPageContent({Key? key}) : super(key: key);

  @override
  State<ListPageContent> createState() => _ListPageContentState();
}

class _ListPageContentState extends State<ListPageContent> {
  final int _displayCount = 20;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _displayCount,
        itemBuilder: (context, index) {
          return _listViewItem(index);
        },
    );
  }

  Widget _listViewItem(int index) {
    return ListTile(
      title: Text("Asset: ${index+1}"),
      subtitle: const Text("Website"),
      leading: const Icon(Icons.food_bank),
      trailing: const Icon(Icons.favorite_border),
    );
  }
}
