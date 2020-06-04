import 'dart:async';
import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/actors/bullet/bullet.dart';
import 'package:flameTest/src/game/controllers/base/base_controller.dart';
import 'package:flameTest/src/game/controllers/player/player.dart';
import 'package:flameTest/src/game/main_game_controller.dart';
import 'package:flameTest/src/game/utils/utils.dart';

class PlayerController extends BaseController{
  Player player;
  List<Bullet> fired = [];

  double cadenzaDiFuoco = 10.0;
  double deltaTime = 0;

  bool isOnFire = false;

  Vector2 direction = Utils.ZERO;

  PlayerController(){
    listeners.add(GameController.tapEvent.stream.listen((event) {
      if(event.type == GameEvent.FIRE)
        isOnFire = event.value;
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
    fired.forEach((element) => element.render(canvas));
  }

  void update(double t) {
    player.update(t, direction);
    if(isOnFire){
      deltaTime+=t;
      if(deltaTime>1/cadenzaDiFuoco){
        deltaTime = 0;
        spawnBullet();
      }
    }else{
      deltaTime = 1/cadenzaDiFuoco;
    }
    fired.removeWhere((element) => !element.isAlive);
    fired.forEach((bullet) {
      bullet.update(t);
      GameController.tapEvent.add(GameEvent(GameEvent.BULLET_UPDATE, bullet));
      if (bullet.position.y <= 0) {
        bullet.destroy();
      }
    });
  }

  void spawnBullet() {
    fired.add(
        Bullet(
          Vector2(player.spriteRect.center.dx,player.spriteRect.center.dy),
          Vector2(0,-1),
          Size(4,4),
          velocity: 15.0,
        )
    );
  }
}