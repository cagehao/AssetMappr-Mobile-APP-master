/*
* Author: Haotian(Jeremy) Li
*
* Desc: This widget include user comment block and Rating popUp window
*/

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CommentBlock extends StatefulWidget {
  const CommentBlock({Key? key}) : super(key: key);

  @override
  State<CommentBlock> createState() => _CommentBlockState();
}

class _CommentBlockState extends State<CommentBlock> {
  final commentsEditingController = TextEditingController();
  final editsEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Comments information
        const Padding(
          padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
          child: Text(
            "Tell us what you feel about this asset!",
            style: TextStyle(
              fontSize: 15,
              color: Colors.blue,
            ),
          ),
        ),

        Column(

          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 10,
                right: 20,
              ),
              child: TextField(
                autocorrect: true,
                controller: commentsEditingController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Comments",
                  icon: Icon(Icons.comment),
                  hintText: "You can evaluate in sanitation, service, efficiency, etc.",
                  border: OutlineInputBorder(),
                ),
              ),
            ),


            const SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('How do you feel about this asset?'),
                        content: const Text('Click the stars to rate. \n'),
                        actions: <Widget>[
                          const RatingBlock(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    "Rate the Asset",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final comments = commentsEditingController.text;
                    commentsEditingController.clear();
                    print(comments);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Submit Successfully!'),
                        content: const Text('Thanks for your information! \n'),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text("Submit Comments",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // // Edits information
        // const Padding(
        //   padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
        //   child: Text(
        //     "Suggest an edit of the asset!",
        //     style: TextStyle(
        //       fontSize: 15,
        //       color: Colors.blue,
        //     ),
        //   ),
        // ),
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(
        //         bottom: MediaQuery.of(context).viewInsets.bottom,
        //         left: 10,
        //         right: 20,
        //       ),
        //       child: TextField(
        //         autocorrect: true,
        //         controller: editsEditingController,
        //         maxLines: 2,
        //         decoration: const InputDecoration(
        //           labelText: "Edits",
        //           icon: Icon(Icons.comment),
        //           hintText: "Is the information of this asset correct?",
        //           border: OutlineInputBorder(),
        //         ),
        //       ),
        //     ),
        //     Center(
        //       child:
        //       TextButton(
        //         onPressed: () {
        //           final comments = editsEditingController.text;
        //           editsEditingController.clear();
        //           print(comments);
        //           showDialog<String>(
        //             context: context,
        //             builder: (BuildContext context) => AlertDialog(
        //               title: const Text('Submit Successfully!'),
        //               content: const Text('Thanks for your information! \n'),
        //               actions: <Widget>[
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.end,
        //                   children: [
        //                     TextButton(
        //                       onPressed: () => Navigator.pop(context, 'OK'),
        //                       child: const Text('OK'),
        //                     ),
        //                   ],
        //                 ),
        //               ],
        //             ),
        //           );
        //         },
        //         style: ButtonStyle(
        //           backgroundColor: MaterialStateProperty.all(Colors.blue),
        //         ),
        //         child: const Text("Submit Edits",
        //           style: TextStyle(
        //             fontSize: 15,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     )
        //   ],
        // ),
      ],
    );
  }
}

class RatingBlock extends StatefulWidget {
  const RatingBlock({Key? key}) : super(key: key);

  @override
  State<RatingBlock> createState() => _RatingBlockState();
}

class _RatingBlockState extends State<RatingBlock> {
  // late double _rating;
  final bool _isVertical = false;
  double _rating = 2.5;
  List<String> ratingTagList = [];
  List<String> selectedRatingTagList = [];

  void _openRatingTagsFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Select Rating Tags',
      height: 500,
      listData: ratingTagList,
      selectedListData: selectedRatingTagList,
      choiceChipLabel: (item) => item!,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ContolButtonType.All, ContolButtonType.Reset],
      onItemSearch: (user, query) {
        // When search query change in search bar then this method will be called
        // Check if items contains query
        return user.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedRatingTagList = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ratingBar(),
        TextButton(
          onPressed: _openRatingTagsFilterDialog,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: const Text(
            "Please Select Rating Tags",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          'Your Rating: $_rating',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _ratingBar() {
    return FittedBox(
      child: RatingBar.builder(
        initialRating: _rating,
        minRating: 1,
        direction: _isVertical ? Axis.vertical : Axis.horizontal,
        allowHalfRating: true,
        unratedColor: Colors.amber.withAlpha(50),
        itemCount: 5,
        itemSize: 50.0,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          setState(() {
            _rating = rating;
            if (rating > 3) {
              ratingTagList = ["Entertaining/fun", "Fond memories", "Good for community spirit", "Good for family/kids", "Great services provided", "Great services provided", "Visually pleasing or beautiful"];
            } else {
              ratingTagList = ["Harmful for the community", "Needs maintenance/clean-up", "Needs renovation", "Physical space should be used differently", "Services need improvement"];
            }
          });
        },
        updateOnDrag: true,
      ),
    );
  }
}


