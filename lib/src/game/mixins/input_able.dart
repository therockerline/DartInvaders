import 'dart:async';

import 'package:box2d_flame/box2d.dart';
import 'package:flame/game/game.dart';
import 'package:flame/gestures.dart';
import 'package:flameTest/src/game/main_game_controller.dart';
import 'package:flutter/cupertino.dart';

class InputEvent{
  bool isOnTap = false;
  Offset currentPosition = Offset.zero;
  InputEvent(this.isOnTap, this.currentPosition);
}
mixin InputAble on Game implements HorizontalDragDetector,VerticalDragDetector, TapDetector{


  InputEvent currentEvent = InputEvent(false, Offset.zero);
  @override
  void onTap() {
    // TODO: implement onTap
    currentEvent.isOnTap = true;
    GameController.tapEvent.add(GameEvent(GameEvent.TAP,currentEvent));
  }

  @override
  void onTapCancel() {
    // TODO: implement onTapCancel
    currentEvent.isOnTap = false;
    GameController.tapEvent.add(GameEvent(GameEvent.TAP,currentEvent));
  }

  @override
  void onTapDown(TapDownDetails details) {
    // TODO: implement onTapDown
    currentEvent.isOnTap = true;
    currentEvent.currentPosition = details.globalPosition;
    GameController.tapEvent.add(GameEvent(GameEvent.TAP,currentEvent));
  }

  @override
  void onTapUp(TapUpDetails details) {
    // TODO: implement onTapUp
    currentEvent.isOnTap = false;
    currentEvent.currentPosition = details.globalPosition;
    GameController.tapEvent.add(GameEvent(GameEvent.TAP,currentEvent));
  }

  @override
  void onVerticalDragDown(DragDownDetails details) {
    //print('onVerticalDragDown');
  }

  @override
  void onVerticalDragStart(DragStartDetails details) {
    //print('onVerticalDragStart');
  }

  @override
  void onVerticalDragUpdate(DragUpdateDetails details) {
    //print('onVerticalDragUpdate');
    currentEvent.currentPosition = details.globalPosition;
    GameController.tapEvent.add(GameEvent(GameEvent.TAP,currentEvent));
  }

  @override
  void onVerticalDragEnd(DragEndDetails details) {
    //print('onVerticalDragEnd');
  }

  @override
  void onVerticalDragCancel() {
    //print('onVerticalDragCancel');
  }

  @override
  void onHorizontalDragDown(DragDownDetails details) {
    //print('onHorizontalDragDown');
  }

  @override
  void onHorizontalDragStart(DragStartDetails details) {
    //print('onHorizontalDragStart');
  }

  @override
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    //print('onHorizontalDragUpdate');
    currentEvent.currentPosition = details.globalPosition;
    GameController.tapEvent.add(GameEvent(GameEvent.TAP,currentEvent));
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    //print('onHorizontalDragEnd');
  }

  @override
  void onHorizontalDragCancel() {
    //print('onHorizontalDragCancel');
  }
}