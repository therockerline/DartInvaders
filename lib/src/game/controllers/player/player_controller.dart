import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/actors/bullet/bullet.dart';
import 'package:flameTest/src/game/controllers/base/base_controller.dart';
import 'package:flameTest/src/game/controllers/player/player.dart';
import 'package:flameTest/src/game/main_game_controller.dart';
import 'package:flameTest/src/game/mixins/input_able.dart';
import 'package:flameTest/src/game/utils/utils.dart';

class PlayerController extends BaseController{
  Player player;


  Vector2 direction = Utils.ZERO;

  PlayerController(){
    listeners.add(GameController.tapEvent.stream.listen((event) {
      if(event.type == GameEvent.ENEMY_BULLET_UPDATE)
        checkCollision(event.value);
      if(event.type == GameEvent.FIRE)
        player.isOnFire = event.value;
      if(event.type == GameEvent.TAP)
        player.isOnFire = (event.value as InputEvent).isOnTap;
      if(event.type == GameEvent.KEY){
        KeyEvent ke = event.value;
        if(ke.key == 'Key A'){
          direction = ke.isDown ? Utils.LEFT : Utils.ZERO;
        }
        if(ke.key == 'Key D'){
          direction = ke.isDown ? Utils.RIGHT : Utils.ZERO;
        }
      }
    }));
  }

  void spawnPlayer(){
    double x = GameController.screenSize.width/2;
    double y = GameController.screenSize.height - 100;
    player = Player(Vector2(x,y), Size(32,32));
  }

  void render(Canvas canvas) {
    player.render(canvas);
  }

  void update(double t) {
    player.move(t, direction);
  }

  void checkCollision(Bullet bullet) {
    if(player.isAlive) {
      if (player.wasHit(bullet.spriteRect.center)) {
        bullet.destroy();
        player.currentLife--;
        if(player.currentLife == 0) {
          player.die();
          Future.delayed(Duration(seconds: 2),(){
            spawnPlayer();
          });
        }
      }
    }
  }
}