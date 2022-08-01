import 'package:asset_mapper/UploadMissingPage/upload_page.dart';
import 'package:asset_mapper/uploadPage/upload_page.dart';
import 'package:asset_mapper/utils/utils.dart';
import 'HomePage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:asset_mapper/utils/size_model.dart';

// App entrance
void main() {
  runApp(const MyApp());
}

// MyApp Widget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeFit.initialize();

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AMPages(),
    );
  }
}


class AMPages extends StatefulWidget {
  const AMPages({Key? key}) : super(key: key);

  @override
  State<AMPages> createState() => _AMPagesState();
}

class _AMPagesState extends State<AMPages> {
  int _currentIndex = 0;

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
      title: const Text("Community Selector"),
      actions: [
        ElevatedButton(onPressed: (){
          communityId = UNIONTOWN;
          Navigator.of(context).pop();
        }, child: const Text("Uniontown")),
        ElevatedButton(onPressed: (){
          communityId = MONONGAHELA;
          Navigator.of(context).pop();
        }, child: const Text("Monongahela")),
      ],
      content: const Text("Please select your community"),
    ));
  }

  @override
  void initState() {
    super.initState();
    // Dialog to select the community
    // Future.delayed(Duration.zero, () => showAlert(context));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Put away keyboard
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload_outlined),
              activeIcon: Icon(Icons.cloud_upload),
              label: "Upload Assets",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud_upload_outlined),
              activeIcon: Icon(Icons.cloud_upload),
              label: "Upload Missing Assets",
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const <Widget>[
            HomePage(),
            UploadPage(),
            UploadMissingPage(),
          ],
        ),
      ),
    );
  }
}







