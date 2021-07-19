import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //to add icon image
  var cross = Icon(
    Icons.cancel_outlined,
    size: 80,
  );
  var circle = Icon(
    Icons.circle_outlined,
    size: 80,
  );
  var edit = Icon(
    Icons.hourglass_empty,
    size: 20,
  );

  bool isCross = true;
  late String message;
  late List<String> gameState;

  //initialize box with empty value
  @override
  void initState() {
    gameState = List.filled(9, "empty");
    this.message = "";
    super.initState();
  }

  //to play game
  playGame(int index) {
    if (this.gameState[index] == "empty") {
      setState(() {
        if (this.isCross) {
          this.gameState[index] = "cross";
        } else {
          this.gameState[index] = "circle";
        }
        isCross = !isCross;

        checkWin();
      });
    }
  }

//to reset
  resetGame() {
    setState(() {
      gameState = List.filled(9, "empty");
      this.message = "";
    });
  }

  //to get icon image
  Icon? getIcon(String title) {
    switch (title) {
      case ('empty'):
        return edit;
        break;

      case ('cross'):
        return cross;
        break;

      case ('circle'):
        return circle;
        break;
    }
  }

  //to check all the winning possibilities
  checkWin() {
    checker(0, 1, 2);
    checker(3, 4, 5);
    checker(6, 7, 8);
    checker(0, 3, 6);
    checker(1, 4, 7);
    checker(2, 5, 8);
    checker(0, 4, 8); //diagonal check
    checker(2, 4, 7); //diagonal check
    // if (!gameState.contains("empty")) {
    //   setState(() {
    //     message = "Game draw";
    //   });
    // }
  }

  //to compare
  checker(int i, int j, int k) {
    if ((gameState[i] != "empty") &&
        (gameState[i] == gameState[j]) &&
        (gameState[j] == gameState[k])) {
      setState(() {
        this.message = this.gameState[i] + 'Won';
        gameState = List.filled(9, "empty");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Katta Zero"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: gameState.length,
                itemBuilder: (context, i) => SizedBox(
                      width: 100,
                      height: 100,
                      child: MaterialButton(
                          onPressed: () {
                            this.playGame(i);
                          },
                          child: getIcon(this.gameState[i])),
                    )),
          ),
          Text(
            message,
            style: TextStyle(
                fontSize: 40, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          Container(
            child: MaterialButton(
              color: Colors.blue,
              onPressed: () {
                resetGame();
              },
              child: Text("Reset Game"),
            ),
          )
        ],
      ),
    );
  }
}
