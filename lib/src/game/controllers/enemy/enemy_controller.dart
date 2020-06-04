import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/actors/bullet/bullet.dart';
import 'package:flameTest/src/game/controllers/base/base_controller.dart';
import 'package:flameTest/src/game/controllers/enemy/enemy.dart';
import 'package:flameTest/src/game/main_game_controller.dart';

class EnemyController extends BaseController{
  List<Enemy> enemies = [];
  EnemyController(){
    listeners.add(GameController.tapEvent.stream.listen((GameEvent event) {
      if(event.type == GameEvent.BULLET_UPDATE)
        checkCollision(event.value);
    }));
  }

  void spawnEnemies(){
    int qnt = 15; //GameController.rand.nextInt(10);
    int row = 3; //GameController.rand.nextInt(5);
    double x = (GameController.screenSize.width - 30) / qnt;
    for(int y = 1; y<row+1; y++) {
      List.generate( qnt, (index) => spawnEnemy(Vector2(15 + x / 2 + index * x, y * 30.0)));
    }
  }

  void render(Canvas canvas) {
    enemies.forEach((Enemy enemy) => enemy.render(canvas));
  }

  void update(double t) {
    enemies.removeWhere((element) => !element.isAlive);
    enemies.forEach((Enemy enemy) {
      if(enemy.isAlive)
        enemy.update(t);
    });
  }

  void spawnEnemy(Vector2 pos) {
    enemies.add(Enemy(pos, Size.square(16), scoreValue: (pos.y / 15).round()));
  }

  void checkCollision(Bullet bullet) {
    enemies.forEach((element) {
      if(element.isAlive) {
        if (element.wasHit(bullet.spriteRect.center)) {
          element.die();
          bullet.destroy();
          print(element.isAlive);
        }
      }
    });
  }
}