import 'dart:ui';

import 'package:flameTest/src/components/base/spritable.dart';
import 'package:flameTest/src/game/main_game_controller.dart';

mixin HitAble on Spritable{

  bool wasHit(Offset shotPos){
    return spriteRect.contains(shotPos);
  }

}