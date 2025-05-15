import 'package:esho_eman_shikhi/model/menu_item_model.dart';


class MenuItem{
  static List<MenuItemModel> itemList =[
    questionItem,
    //policyItem
  ];

  static final questionItem =MenuItemModel(text: 'কিছু প্রশ্ন ও উত্তর',
      iconPath: 'assets/icon/question_n_answer.png' );

  /*static final policyItem =MenuItemModel(text: 'Privacy Policy',
      iconPath: 'assets/icon/policy_icon.png' );*/
}