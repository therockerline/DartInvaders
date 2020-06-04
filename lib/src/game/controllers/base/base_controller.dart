import 'dart:async';

import 'package:flameTest/src/components/base/spritable.dart';

class BaseController{
  List<StreamSubscription<dynamic>> listeners = [];
  Spritable sprite;

  void clearAll(){
    listeners.forEach((l) {l.cancel();});
  }

}