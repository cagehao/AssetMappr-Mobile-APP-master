/*
* Author: Haotian(Jeremy) Li, Anna Wang
*
* Desc: This is the Upload Page (Uploading new/missing assets) Layout
*/

import 'package:asset_mapper/UploadMissingPage/contents/upload_button.dart';
import 'package:asset_mapper/UploadMissingPage/upload_utils.dart';
import 'package:flutter/material.dart';
import 'package:asset_mapper/Model/model.dart';
import 'package:asset_mapper/utils/utils.dart';
import 'package:asset_mapper/UploadMissingPage/contents/upload_type.dart';
import 'package:asset_mapper/UploadMissingPage/contents/separator.dart';
import 'package:asset_mapper/UploadMissingPage/contents/name_content.dart';
import 'package:asset_mapper/UploadMissingPage/contents/address_content.dart';
import 'package:asset_mapper/UploadMissingPage/contents/category_content.dart';
import 'package:asset_mapper/UploadMissingPage/contents/note_content.dart';

import 'contents/form_upload_assetInformation.dart';


class UploadMissingPage extends StatelessWidget {
  const UploadMissingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Missing Assets", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: const UploadPageContent(),
    );
  }
}

class UploadPageContent extends StatefulWidget {
  const UploadPageContent({Key? key}) : super(key: key);

  @override
  State<UploadPageContent> createState() => _UploadPageContentState();
}

class _UploadPageContentState extends State<UploadPageContent> {
  bool _showNameBlock = buttonValue;
  bool _showCommentBlock = !buttonValue;

  @override
  void initState() {
    super.initState();

    eventBus.on<ButtonViewChange>().listen((event) {
      setState(() {
        buttonValue = event.showNameBlock;
        _showNameBlock = event.showNameBlock;
        _showCommentBlock = event.showCommentBlock;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget> [
        SliverList(
            delegate: SliverChildListDelegate(
              [
                const UploadTypeContent(),
                const Separator(),
                customForm(),
                // NameContent(_showNameBlock),
                const AddressContent(),
                const CategoryText(),
              ]
            )
        ),
        const CategoryContent(),
        SliverList(
            delegate: SliverChildListDelegate(
              [
                // const NoteContent(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your Name:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: TextFormField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      labelText: "Enter your name (optional)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Your Role:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: TextFormField(
                    controller: userRoleController,
                    decoration: InputDecoration(
                      hintText: 'Your Role',
                      labelText: "Are you a resident? A teacher? A business owner? A town planner?",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                UploadButton(_showNameBlock),
              ]
            )
        )
      ],
    );
  }
}


