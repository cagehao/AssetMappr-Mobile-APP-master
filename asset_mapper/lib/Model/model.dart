/*
* Author: Haotian(Jeremy) Li
*
* Desc: This is the eventModel for transmit global events
*/
class ButtonViewChange {
  bool showNameBlock;
  bool showCommentBlock;

  ButtonViewChange(this.showNameBlock, this.showCommentBlock);
}

class AddressInfo {
  String address;
  double lat;
  double long;

  AddressInfo(this.address, this.lat, this.long);
}

class CategoryInfo {
  List<String> categoryList;

  CategoryInfo(this.categoryList);
}

class UploadCategory {
  Map<int, bool> checkBoxState;

  UploadCategory(this.checkBoxState);
}