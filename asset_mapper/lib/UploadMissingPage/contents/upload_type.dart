/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is the "select the upload Type" block for Upload Page
*/

import 'package:asset_mapper/uploadPage/upload_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:asset_mapper/Model/model.dart';
import 'package:asset_mapper/utils/utils.dart';

class UploadTypeContent extends StatefulWidget {
  const UploadTypeContent({Key? key}) : super(key: key);

  @override
  State<UploadTypeContent> createState() => _UploadTypeContentState();
}

class _UploadTypeContentState extends State<UploadTypeContent> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Is there something missing in your community, that you would like to see?",
            style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey,
            ),
          ),
        ),
        // FittedBox(
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Container(
        //         alignment: Alignment.center,
        //         width: 170,
        //         child: const Text(
        //           "New Asset you hope the community can build",
        //           style: TextStyle(fontSize: 14),
        //           maxLines: 2,
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        //
        //       CupertinoSwitch(
        //           activeColor: Colors.blue,
        //           value: buttonValue,
        //           onChanged: (value) {
        //             eventBus.fire(ButtonViewChange(value,!value));
        //             setState(() {
        //               buttonValue = value;
        //             });
        //           }
        //       ),
        //       Container(
        //         alignment: Alignment.center,
        //         width: 150,
        //         child: const Text(
        //           "Asset Already exist but we missed it",
        //           style: TextStyle(fontSize: 14),
        //           textAlign: TextAlign.center,
        //           maxLines: 2,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
