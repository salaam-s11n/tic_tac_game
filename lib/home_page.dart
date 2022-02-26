import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_game/game_logic.dart';
import 'package:tic_tac_game/provider_theme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String activePlayer = "X";
  bool gameOver = false;
  int turn = 0;
  String result = " ";
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    var th = Theme.of(context);
    return Scaffold(
      backgroundColor: th.primaryColor,
      body: SafeArea(
        child: isPortrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  themeWidget(th),
                  // Expanded(
                  //   child: Slider(
                  //       min: 5,
                  //       max: 50,
                  //       divisions: 10,
                  //       thumbColor: Colors.lightBlueAccent,
                  //       activeColor: Colors.lightBlueAccent,
                  //       inactiveColor: Colors.grey[200],
                  //       value: slide,
                  //       onChanged: (val) {
                  //         setState(() {
                  //           slide = val;
                  //         });
                  //       }),
                  // ),
                  topSide(th),
                  centerSide(th, 3),
                  bottomSide(th)
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        themeWidget(th),
                        topSide(th),
                        bottomSide(th),
                      ],
                    ),
                  ),
                  centerSide(th, 1),
                ],
              ),
      ),
    );
  }

  Expanded themeWidget(ThemeData th) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraint) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: Text(
                "Dark",
                style: th.textTheme.headline2,
              ),
            ),
            Switch.adaptive(
              activeColor: const Color(0xff4169e8),
              activeTrackColor: Colors.grey,
              inactiveTrackColor: Colors.grey,
              inactiveThumbColor: Colors.white,
              value: Provider.of<ThemeProvider>(context).value,
              onChanged: (val) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .checkTheme(val);
              },
            ),
            FittedBox(
              child: Text(
                "Light",
                style: th.textTheme.headline2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded topSide(ThemeData th) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraint) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: constraint.maxWidth * 0.05,
                right: constraint.maxWidth * 0.05,
                // top: constraint.maxHeight ,
                // bottom: constraint.maxHeight,
              ),
              child: SwitchListTile.adaptive(
                activeColor: Colors.blue.shade900,
                subtitle: const FittedBox(
                  child: Text(
                    "This action is make you play with your mobile or with real person",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                activeTrackColor: Colors.grey,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.white,
                title: FittedBox(
                  child: Text(
                    "Turn On/Off Two Player",
                    style: th.textTheme.headline2,
                  ),
                ),
                value: isSwitched,
                onChanged: (val) {
                  setState(() {
                    isSwitched = val;
                  });
                },
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.5,
              child: FittedBox(
                child: Text(
                  "It's $activePlayer turn".toUpperCase(),
                  style: th.textTheme.bodyText1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded centerSide(ThemeData th, int flex) {
    return Expanded(
      flex: flex,
      child: LayoutBuilder(
        builder: (context, constraint) => GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          mainAxisSpacing: constraint.maxHeight * 0.02,
          crossAxisSpacing: constraint.maxWidth * 0.02,
          childAspectRatio: (constraint.maxWidth) / (constraint.maxHeight),
          padding: EdgeInsets.symmetric(
            horizontal: constraint.maxWidth * 0.04,
            vertical: constraint.maxHeight * 0.04,
          ),
          children: List.generate(
              9,
              (index) => InkWell(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      child: FittedBox(
                        child: Text(
                          Player.playerX.contains(index)
                              ? "X"
                              : Player.playerO.contains(index)
                                  ? "O"
                                  : " ",
                          style: Player.playerX.contains(index)
                              ? th.textTheme.headline1
                              : th.textTheme.headline3,
                        ),
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: th.shadowColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onTap: gameOver
                        ? null
                        : () {
                            onTAP(index);
                          },
                  )),
        ),
      ),
    );
  }

  Expanded bottomSide(ThemeData th) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            result,
            style: th.textTheme.bodyText2,
          ),
          ElevatedButton.icon(
              onPressed: () {
                reset();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(th.splashColor)),
              icon: const Icon(Icons.replay_rounded),
              label: FittedBox(
                child: Text(
                  "Play Again",
                  style: th.textTheme.headline4,
                ),
              )),
        ],
      ),
    );
  }

  void onTAP(int index) async {
    if ((!Player.playerX.contains(index) || Player.playerX.isEmpty) &&
        (!Player.playerO.contains(index) || Player.playerO.isEmpty)) {
      game.playGame(index, activePlayer);
      updateState(index);
      if (!isSwitched && !gameOver && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState(index);
      }
    }
  }

  void updateState(index) {
    setState(() {
      activePlayer = (activePlayer == "X") ? "O" : "X";
      turn++;
      String winnerPlayer = game.checkWinner();
      if (winnerPlayer != '') {
        result = "$winnerPlayer is Winner";
        gameOver = true;
      } else if (!gameOver && turn == 9) {
        result = "It's Draw!";
      }
    });
  }

  void reset() {
    setState(() {
      activePlayer = "X";
      gameOver = false;
      turn = 0;
      result = "";
      Player.playerX = [];
      Player.playerO = [];
    });
  }
}
