import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/actors/bullet/bullet.dart';
import 'package:flameTest/src/components/base/spritable.dart';
import 'package:flameTest/src/game/utils/utils.dart';

import '../../../game/main_game_controller.dart';

mixin GunAble on Spritable{
  List<Bullet> fired = [];
  Vector2 gunDirection = Utils.ZERO;
  double cadenzaDiFuoco = 10.0;
  double deltaTime = 0;
  String gameEventOnBulletUpdate;
  bool isOnFire = false;
  double bulletVelocity = 1;
  Size bulletSize = Size(2,8);

  void spawnBullet() {
    fired.add(
        Bullet(
          Vector2(spriteRect.center.dx,spriteRect.center.dy),
          gunDirection,
          bulletSize,
          velocity: bulletVelocity,
        )
    );
  }

  @override
  void render(Canvas c){
    fired.forEach((element) => element.render(c));
    super.render(c);
  }

  void update(double t){
    if(gameEventOnBulletUpdate != GameEvent.ENEMY_BULLET_UPDATE) {
      if (isOnFire) {
        deltaTime += t;
        if (deltaTime > 1 / cadenzaDiFuoco) {
          deltaTime = 0;
          spawnBullet();
        }
      } else {
        deltaTime = 1 / cadenzaDiFuoco;
      }
    }
    fired.removeWhere((element) => !element.isAlive);
    fired.forEach((bullet) {
      bullet.update(t);
      //print(gameEventOnBulletUpdate);
      GameController.tapEvent.add(GameEvent(gameEventOnBulletUpdate, bullet));
      if (!GameController.screenSize.contains(bullet.spriteRect.center)) {
        bullet.destroy();
      }
    });
    super.update(t);
  }

}