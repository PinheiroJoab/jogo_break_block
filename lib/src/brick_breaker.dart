import 'dart:async';
import 'dart:math' as math; 

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';  
import 'package:flutter/services.dart';

import 'components/components.dart';
import 'config.dart';

enum PlayState { bemVindo, jogando, fimDeJogo, venceu } 

class BrickBreaker extends FlameGame with HasCollisionDetection, KeyboardEvents, TapDetector{
  BrickBreaker()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );
  
  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random(); 
  double get width => size.x;
  double get height => size.y;
  late PlayState _playState;                                  
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.bemVindo:
      case PlayState.fimDeJogo:
      case PlayState.venceu:
        overlays.add(playState.name);
      case PlayState.jogando:
        overlays.remove(PlayState.bemVindo.name);
        overlays.remove(PlayState.fimDeJogo.name);
        overlays.remove(PlayState.venceu.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());
    playState = PlayState.bemVindo;      
  }

  void startGame() {
    if (playState == PlayState.jogando) return;

    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());

    playState = PlayState.jogando;
    score.value = 0; 
    
    world.add(
      Ball(
        difficultyModifier: difficultyModifier,                                                   
        radius: ballRadius,
        position: size / 2,
        velocity: Vector2(
          (rand.nextDouble() - 0.5) * width,
          height * 0.2,
        ).normalized()..scale(height / 4),
      ),
    );

      world.add(                                                  
      Bat(
        size: Vector2(batWidth, batHeight),
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95),
      ),
    ); 
     world.addAll([                               
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 1; j <= 5; j++)
          Brick(
            position: Vector2(
              (i + 0.5) * brickWidth + (i + 1) * brickGutter,
              (j + 2.0) * brickHeight + j * brickGutter,
            ),
            color: brickColors[i],
          ),
    ]);

    //debugMode = true; // Add this line to enable debug mode
  }

  @override                  
  void onTap() {
    super.onTap();
    startGame();
  } 
   @override                                                     
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
        case LogicalKeyboardKey.space:                      
        startGame();
    }
    return KeyEventResult.handled;
  }
   @override
  Color backgroundColor() => const Color(0xfff2e8cf); 
}