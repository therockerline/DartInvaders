import 'dart:ui';

import 'package:box2d_flame/box2d.dart';
import 'package:flameTest/src/components/actors/bullet/bullet.dart';
import 'package:flameTest/src/game/controllers/base/base_controller.dart';
import 'package:flameTest/src/game/controllers/enemy/enemy.dart';
import 'package:flameTest/src/game/main_game_controller.dart';

class EnemyController extends BaseController{
  List<Enemy> enemies = [];
  int qnt = 0;
  bool isOnSpawn = false;
  EnemyController(){
    listeners.add(GameController.tapEvent.stream.listen((GameEvent event) {
      if(event.type == GameEvent.PLAYER_BULLET_UPDATE)
        checkCollision(event.value);
    }));
  }

  void spawnEnemies(){
     //GameController.rand.nextInt(10);
    int row = 3; //GameController.rand.nextInt(5);
    double x = (GameController.screenSize.width - 30) / qnt;
    for(int y = 0; y<row; y++) {
      List.generate( qnt, (index) => spawnEnemy(Vector2(15 + x / 2 + index * x, 30 + (y * 30.0))));
    }
    isOnSpawn = false;
  }

  void render(Canvas canvas) {
    enemies.forEach((Enemy enemy) => enemy.render(canvas));
  }

  void update(double t) {
    enemies.removeWhere((element) => !element.isAlive);
    if(enemies.length==0 && !isOnSpawn) {
      isOnSpawn = true;
      Future.delayed(Duration(seconds: 2), () {
        qnt++;
        spawnEnemies();
      });
    }
    enemies.forEach((Enemy enemy) {
      if(enemy.isAlive) {
        enemy.update(t);
        int fire = GameController.rand.nextInt(10000);
        if(fire >= 9890){
          enemy.spawnBullet();
        }
      }
    });
  }

  void spawnEnemy(Vector2 pos) {
    Enemy enemy = Enemy(pos, Size.square(16), scoreValue: (pos.y).round());
    enemy.bulletVelocity *=qnt;
    enemies.add(enemy);
  }

  void checkCollision(Bullet bullet) {
    enemies.forEach((element) {
      if(element.isAlive) {
        if (element.wasHit(bullet.spriteRect.center)) {
          element.die();
          bullet.destroy();
        }
      }
    });
  }
}