import 'dart:async';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';

class ScrappyButton {
  Rect rect;
  Paint paint;
  Vector2 _pivot = Vector2(.5,.5);
  Vector2 position;
  Size _tileSize;
  Function onClick;
  StreamSubscription listener;
  ScrappyButton(double x, double y, Size tileSize, {Vector2 pivot, Function onClick}){
    _pivot = pivot ?? _pivot;
    _tileSize = tileSize;
    position = Vector2(x-(_tileSize.width*_pivot.x),y-(_tileSize.height*_pivot.y));
    paint = Paint();
    paint.color = Color(0xff6ab04c);
    rect = Rect.fromLTWH(position.x,position.y,_tileSize.width,_tileSize.height);
  }

  void render(Canvas c) {
    c.drawRect(rect, paint);
  }

  void update(double t) {

  }

  bool isPressed(Offset tapPos){
    return rect.contains(tapPos);
  }

  void destroy(){
    listener.cancel();
  }
}