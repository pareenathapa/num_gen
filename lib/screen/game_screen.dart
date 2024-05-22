import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int playCount = 0;
  static const int maxPlays = 10;
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  int number1 = 0;
  int number2 = 0;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  void generateNumbers() {
    setState(() {
      number1 = generateUniqueNumber(null);
      number2 = generateUniqueNumber(number1);
    });
  }

  int generateUniqueNumber(int? exclude) {
    int number;
    Random random = Random();
    do {
      number = random.nextInt(100) + 1;
    } while (number == exclude);
    return number;
  }

  void playGame(int selectedNumber) {
    if (playCount < maxPlays) {
      if (selectedNumber == max(number1, number2)) {
        correctAnswers++;
      } else {
        incorrectAnswers++;
      }
      playCount++;
      if (playCount >= maxPlays) {
        setState(() {
          isGameOver = true;
        });
      } else {
        generateNumbers();
      }
    }
  }

  void restartGame() {
    setState(() {
      playCount = 0;
      correctAnswers = 0;
      incorrectAnswers = 0;
      isGameOver = false;
      generateNumbers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Generator Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: isGameOver ? null : () => playGame(number1),
                  child: Text('$number1', style: TextStyle(fontSize: 24)),
                  style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      fixedSize: Size(100, 100),
                      backgroundColor: Colors.greenAccent.shade100),
                ),
                ElevatedButton(
                  onPressed: isGameOver ? null : () => playGame(number2),
                  child: Text('$number2', style: TextStyle(fontSize: 24)),
                  style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      fixedSize: Size(100, 100),
                      backgroundColor: Colors.greenAccent.shade100),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Text('Game Stats',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.purple[200],
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Correct answers: $correctAnswers',
                      style: TextStyle(fontSize: 18)),
                  Text('Incorrect answers: $incorrectAnswers',
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      fixedSize: Size(100, 100),
                      backgroundColor: Colors.greenAccent.shade100),
                  onPressed: restartGame,
                  child: Text(
                    'Restart Game',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}