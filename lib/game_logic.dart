import 'dart:math';

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainsAll on List {
  bool containsAll(int x, int y, [z]) {
    if (z == null) {
      return contains(x) && contains(y);
    }
    return contains(x) && contains(y) && contains(z);
  }
}

class Game {
  int i = 0;
  List<int> emptyCells = [];
  int index = 0;
  int randomIndex = 0;
  bool getIndex = false;
  var x = Player.playerX;
  var o = Player.playerO;
  void playGame(int index, String activePlayer) {
    if (activePlayer == Player.x) {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  String checkWinner() {
    String winner = "";
    if (Player.playerX.containsAll(0, 1, 2) ||
        Player.playerX.containsAll(3, 4, 5) ||
        Player.playerX.containsAll(6, 7, 8) ||
        Player.playerX.containsAll(0, 3, 6) ||
        Player.playerX.containsAll(1, 4, 7) ||
        Player.playerX.containsAll(2, 4, 6) ||
        Player.playerX.containsAll(0, 4, 8) ||
        Player.playerX.containsAll(2, 5, 8)) {
      winner = "X";
    }
    if (Player.playerO.containsAll(0, 1, 2) ||
        Player.playerO.containsAll(3, 4, 5) ||
        Player.playerO.containsAll(6, 7, 8) ||
        Player.playerO.containsAll(0, 3, 6) ||
        Player.playerO.containsAll(1, 4, 7) ||
        Player.playerO.containsAll(2, 4, 6) ||
        Player.playerO.containsAll(0, 4, 8) ||
        Player.playerO.containsAll(2, 5, 8)) {
      winner = "O";
    }

    return winner;
  }

  Future<void> autoPlay(activePlayer) async {
    var x = Player.playerX;
    var o = Player.playerO;
    emptyCells = [];
    checkEmpty();

    if (checkend(0, 1, 2, o)) {
      index = 2;
    } else if (checkend(3, 4, 5, o)) {
      index = 5;
    } else if (checkend(6, 7, 8, o)) {
      index = 8;
    } else if (checkend(0, 3, 6, o)) {
      index = 6;
    } else if (checkend(1, 4, 7, o)) {
      index = 7;
    } else if (checkend(2, 4, 6, o)) {
      index = 6;
    } else if (checkend(0, 4, 8, o)) {
      index = 8;
    } else if (checkend(2, 5, 8, o)) {
      index = 8;
    } else if (checkend(0, 1, 2, o)) {
      index = 0;
    } else if (checkstart(3, 4, 5, o)) {
      index = 3;
    } else if (checkstart(6, 7, 8, o)) {
      index = 6;
    } else if (checkstart(0, 3, 6, o)) {
      index = 0;
    } else if (checkstart(1, 4, 7, o)) {
      index = 1;
    } else if (checkstart(2, 4, 6, o)) {
      index = 2;
    } else if (checkstart(0, 4, 8, o)) {
      index = 0;
    } else if (checkstart(2, 5, 8, o)) {
      index = 2;
    } else if (checkCenter(3, 4, 5, o)) {
      index = 4;
    } else if (checkCenter(6, 7, 8, o)) {
      index = 7;
    } else if (checkCenter(0, 3, 6, o)) {
      index = 3;
    } else if (checkCenter(1, 4, 7, o)) {
      index = 4;
    } else if (checkCenter(2, 4, 6, o)) {
      index = 4;
    } else if (checkCenter(0, 4, 8, o)) {
      index = 4;
    } else if (checkCenter(2, 5, 8, o)) {
      index = 5;
    } else if (checkend(0, 1, 2, x)) {
      index = 2;
    } else if (checkend(3, 4, 5, x)) {
      index = 5;
    } else if (checkend(6, 7, 8, x)) {
      index = 8;
    } else if (checkend(0, 3, 6, x)) {
      index = 6;
    } else if (checkend(1, 4, 7, x)) {
      index = 7;
    } else if (checkend(2, 4, 6, x)) {
      index = 6;
    } else if (checkend(0, 4, 8, x)) {
      index = 8;
    } else if (checkend(2, 5, 8, x)) {
      index = 8;
    } else if (checkend(0, 1, 2, x)) {
      index = 0;
    } else if (checkstart(3, 4, 5, x)) {
      index = 3;
    } else if (checkstart(6, 7, 8, x)) {
      index = 6;
    } else if (checkstart(0, 3, 6, x)) {
      index = 0;
    } else if (checkstart(1, 4, 7, x)) {
      index = 1;
    } else if (checkstart(2, 4, 6, x)) {
      index = 2;
    } else if (checkstart(0, 4, 8, x)) {
      index = 0;
    } else if (checkstart(2, 5, 8, x)) {
      index = 2;
    } else if (checkCenter(3, 4, 5, x)) {
      index = 4;
    } else if (checkCenter(6, 7, 8, x)) {
      index = 7;
    } else if (checkCenter(0, 3, 6, x)) {
      index = 3;
    } else if (checkCenter(1, 4, 7, x)) {
      index = 4;
    } else if (checkCenter(2, 4, 6, x)) {
      index = 4;
    } else if (checkCenter(0, 4, 8, x)) {
      index = 4;
    } else if (checkCenter(2, 5, 8, x)) {
      index = 5;
    } else {
      setRandom();
    }

    playGame(index, activePlayer);
    checkEmpty();
  }

  void checkEmpty() {
    emptyCells = [];
    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || (Player.playerO.contains(i)))) {
        emptyCells.add(i);
      }
    }
  }

  void setRandom() {
    checkEmpty();
    do {
      Random random = Random();
      randomIndex = random.nextInt(emptyCells.length);
      checkEmpty();
      index = randomIndex;
    } while ((Player.playerX.contains(randomIndex) ||
        (Player.playerO.contains(randomIndex))));
  }

  bool checkend(int x, int y, int z, List<int> list) {
    if (list.containsAll(x, y) && emptyCells.contains(z)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkstart(int x, int y, int z, List<int> list) {
    if (list.containsAll(y, z) && emptyCells.contains(x)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkCenter(int x, int y, int z, List<int> list) {
    if (list.containsAll(x, z) && emptyCells.contains(y)) {
      return true;
    } else {
      return false;
    }
  }
}
