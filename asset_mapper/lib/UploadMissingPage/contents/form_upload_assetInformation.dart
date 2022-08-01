import 'package:flutter/material.dart';
import '../upload_utils.dart';


class customForm extends StatefulWidget {
  const customForm({Key? key}) : super(key: key);

  @override
  State<customForm> createState() => _customFormState();
}

class _customFormState extends State<customForm> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Asset Name:",
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
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Asset Name',
              labelText: "Enter the asset\'s name",
              border: OutlineInputBorder()
            ),
            onSaved: (value) {
              print(value);
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Asset Description:",
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
            controller: desController,
            decoration: InputDecoration(
              hintText: 'Asset Description',
              labelText: "Enter a short description of the asset",
              border: OutlineInputBorder(),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Website:",
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
            controller: webController,
            decoration: InputDecoration(
              hintText: 'Website',
              labelText: "Official website/Facebook or other social media page",
              border: OutlineInputBorder(),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Click on the map to mark the exact location of the asset:",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            textAlign: TextAlign.left,
          ),
        ),

      ],
    );
  }
}

