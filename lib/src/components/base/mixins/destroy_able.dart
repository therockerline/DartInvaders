import 'dart:ui';

import 'package:flameTest/src/components/base/spritable.dart';

mixin DestroyAble on Spritable{
  bool isAlive = true;
  bool isOnDie = false;

  void destroy(){
    isAlive = false;
    spriteRect = Rect.fromLTWH(0,-100,0,0);
  }

  double count = 0;
  void update(double t){
    if(isOnDie){
      count += t * 2;
      spriteRect = spriteRect.deflate(t * 5);
      spritePaint.color = Color(0xff0000).withAlpha((255 / count).round());
      if(count > 1){
        spritePaint.color = Color(0x00ff0000);
        count = 0;
        destroy();
      }
    }
    super.update(t);
  }
}