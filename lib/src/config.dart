import 'package:flutter/material.dart';  

// Define a list of colors for the bricks
const brickColors = [ 
  Color(0xfff94144),
  Color(0xfff3722c),
  Color(0xfff8961e),
  Color(0xfff9844a),
  Color(0xfff9c74f),
  Color(0xff90be6d),
  Color(0xff43aa8b),
  Color(0xff4d908e),
  Color(0xff277da1),
  Color(0xff577590),
];


// Game configuration constants
const gameWidth = 820.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth * 0.02; // 2% of game width

const batWidth = gameWidth * 0.2; // Bat width is 20% of game width                     
const batHeight = ballRadius * 2;// Bat height is twice the ball radius
const batStep = gameWidth * 0.05; // 5% of game width
const brickGutter = gameWidth * 0.015; // Space between bricks
final brickWidth = (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length; // Calculate brick width based on number of colors and gutters
const brickHeight = gameHeight * 0.03; // Brick height is 3% of game height
const difficultyModifier = 1.03; // Speed increase factor on each brick hit