// /*
// * Author: Haotian(Jeremy) Li
// *
// * Desc: This is the asset's name function block for Upload Page
// */
//
// import 'package:asset_mapper/UploadPage/upload_utils.dart';
// import 'package:flutter/material.dart';
//
// class NameContent extends StatefulWidget {
//   bool isShowBlock;
//   NameContent(this.isShowBlock, {Key? key}) : super(key: key);
//
//   @override
//   State<NameContent> createState() => _NameContentState();
// }
//
// class _NameContentState extends State<NameContent> {
//   @override
//   Widget build(BuildContext context) {
//     return widget.isShowBlock?
//     Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(bottom: 12.0),
//             child: Text(
//               "Name",
//               style: TextStyle(
//                 fontSize: 16,
//               ),
//             ),
//           ),
//           TextFormField(
//             controller: nameEditingController,
//             decoration: const InputDecoration(
//               icon: Icon(Icons.drive_file_rename_outline_rounded),
//               labelText: "Asset Name",
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ],
//       ),
//     ): const SizedBox(height: 0.1);
//   }
// }