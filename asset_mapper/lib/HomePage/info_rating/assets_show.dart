

import 'package:asset_mapper/utils/db/assets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'comment_block.dart';
import 'package:asset_mapper/utils/utils.dart';



class AssetShow extends StatefulWidget {

  final Assets assetsInstance;
  const AssetShow(this.assetsInstance, {Key? key}) : super(key: key);//build function

  @override
  State<AssetShow> createState() => _AssetShowState();
}

class _AssetShowState extends State<AssetShow> {
  List<Widget> wList = [];
  final NameController = TextEditingController();

  _descriptionText(){
    if (widget.assetsInstance.assetList[showId].snippet != "null"){
      wList.add( Text(widget.assetsInstance.assetList[showId].snippet,
        style: assetDescriptionStyle,
        textAlign: TextAlign.left,
      ));
    }
  }

  _urlLinker(){
    if (widget.assetsInstance.assetList[showId].website.isEmpty || widget.assetsInstance.assetList[showId].website == "NaN"){
      return const Text("Website Not Found",
        style: assetDescriptionStyle,
        textAlign: TextAlign.left,
      );
    }
    else if(widget.assetsInstance.assetList[showId].website[0]=="h"){
      return wList.add( Container(
        padding: const EdgeInsets.all(3),
        child:InkWell(
            child: const Text("Open in Browser",
              style: urlLinkStyle,
            ),
            onTap: () => launch(widget.assetsInstance.assetList[showId].website)
        ),
      ));
    }
    // else{
    //   return Text("Website Not Found",
    //     style: assetDescriptionStyle,
    //     textAlign: TextAlign.left,
    //   );
    // }
  }

  _categoryLabel(){
    return wList.add(Container(
        padding: const EdgeInsets.fromLTRB(9, 4, 9, 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: const Color.fromARGB(210,128,211,229)
        ),
        child: Text(
          widget.assetsInstance.assetList[showId].assetCategory,
          style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
        )
    ));
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Asset Editor"),
          actions: [
            ElevatedButton(onPressed: () async {
              Navigator.of(context).pop();
              setState(() {});
            }, child: const Text("Submit")),
          ],
          content: Column(
            children: [
              Text("Name"),
              TextField(
                autocorrect: true,
                controller: NameController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Comments",
                  icon: Icon(Icons.comment),
                  hintText: "You can evaluate in sanitation, service, efficiency, etc.",
                  border: OutlineInputBorder(),
                ),
              ),
              Text("Address"),
              Text("Category"),
              Text("Website")
            ],
          )
        ));
  }

  void _openCommunityFilterDialog() async {
    Future.delayed(Duration.zero, () => showAlert(context));
  }

  _suggestEdit() {
    return wList.add(TextButton(
      onPressed: _openCommunityFilterDialog,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.blue)),
      child: const Text(
        "Suggest Edits",
        style: TextStyle(color: Colors.white),
      ),
    ),);
  }

  _freshState(){
    wList = [];
    _categoryLabel();
    _descriptionText();
    _urlLinker();
    _suggestEdit();
  }



  @override
  Widget build(BuildContext context) {

    if (dbFlag==false){
      return const SizedBox(
        height: 200.0,

        child: Text("loading",
          style: assetTitleStyle,
        ),
      );
    }
    _freshState();
    return
      Column(
        children: [
          const SizedBox(height: 10,),//the title
          Text(widget.assetsInstance.assetList[showId].assetName,
            style: assetTitleStyle,
          ),
          const SizedBox(height: 10,),//the title
          Row(
            children: [
              const SizedBox(width: 5,),
              Expanded(
                  child: Container(
                    height: 100,

                    padding: const EdgeInsets.all(2),

                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:wList
                    ),
                  )
              )
            ],
          ),


          const SizedBox(height: 10,),

          const CommentBlock(),

        ],
      );
  }
}



