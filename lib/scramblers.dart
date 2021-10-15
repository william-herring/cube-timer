import 'dart:math';

var _333Notation = ['R', "R'", 'R2', 'U', "U'", 'U2', 'L', "L'", 'L2', 'F', "F'", 'F2', 'B', "B'", 'B2', 'D', "D'", 'D2'];
var _222Notation = ['R', "R'", 'R2', 'U', "U'", 'U2', 'F', "F'", 'F2'];

String newScramble(event) {
  if (event == "3x3") {
    return generateRandom333();
  } else if (event == "2x2") {
    return generateRandom222();
  }

  return "";
}

String generateRandom333() {
  String moves = "";
  Random r = new Random();
  var length = 20 + r.nextInt(23 - 20);
  
  var lastMove = "n";
  var m;

  for (var i = 0; i < length; i++) {
    m = _333Notation[r.nextInt(18)];

    while (m[0] == lastMove[0]) {
      m = _333Notation[r.nextInt(18)];
    }

    lastMove = m;
    moves += m + " ";
  }

  return moves;
}

String generateRandom222() {
  String moves = "";
  Random r = new Random();
  var length = 8 + r.nextInt(11 - 8);

  var lastMove = "n";
  var m;

  for (var i = 0; i < length; i++) {
    m = _222Notation[r.nextInt(9)];

    while (m[0] == lastMove[0]) {
      m = _222Notation[r.nextInt(9)];
    }

    lastMove = m;
    moves += m + " ";
  }

  return moves;
}