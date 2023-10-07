import 'package:fluttertoast/fluttertoast.dart';
import 'package:onye_aghana_nwanne_ya/utils/colors.dart';

customToast(String text) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: appColor,
      textColor: whiteColor);
}
