import 'package:flameTest/src/game/controllers/enemy/enemy.dart';
import 'package:flameTest/src/game/main_game_controller.dart';

class ScoreController{
  int score=0;
  ScoreController(){
   GameController.tapEvent.stream.listen((event) {
     if(event.type == GameEvent.DESTROYED){
       score += (event.value as Enemy).scoreValue;
     }
   });
  }

  void reset(){
    score = 0;
  }
}