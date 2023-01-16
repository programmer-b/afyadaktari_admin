import 'package:nb_utils/nb_utils.dart';

toastE(message) => toast(message, gravity: ToastGravity.TOP, bgColor: errorColor);
toastS(message) => toast(message, gravity: ToastGravity.TOP, bgColor: greenColor);