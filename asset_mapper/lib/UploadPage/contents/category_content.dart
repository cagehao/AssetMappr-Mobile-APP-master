/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is the category selection function block for Upload Page
*/

import 'package:asset_mapper/UploadPage/upload_utils.dart';
import 'package:flutter/material.dart';
import 'package:asset_mapper/Model/model.dart';
import 'package:asset_mapper/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Click and select the asset's categories:",
        style: TextStyle(
          fontSize: 16,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class CategoryContent extends StatefulWidget {
  const CategoryContent({Key? key}) : super(key: key);

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  // late List<String> cateList;
  Map<int, bool> checkBoxState = {};

  @override
  void initState() {
    super.initState();

    eventBus.on<CategoryInfo>().listen((event) {
      Map<int, bool> map;
      Map<int, String> key = {};
      int i = 0;

      setState(() {
        for(var cat in event.categoryList) {
          checkBoxState[i] = false;
          catgoryKey[i] = cat;
          i++;
        }
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Row(
            children: [
              Checkbox(
                  value: checkBoxState[index],
                  onChanged: (value) {
                    setState(() {
                      checkBoxState[index] = value!;
                    });
                    eventBus.fire(UploadCategory(checkBoxState));
                  }
              ),
              Expanded(
                child: Text(
                  catgoryKey[index] ?? "None",
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 12
                  ),
                ),
              )
            ],
          );
        },
        childCount: catgoryKey.length,
      ),
    );
  }
}
