import 'dart:math';

var _333Notation = ['R', "R'", 'R2', 'U', "U'", 'U2', 'L', "L'", 'L2', 'F', "F'", 'F2', 'B', "B'", 'B2', 'D', "D'", 'D2'];

String newScramble(event) {
  if (event == "3x3") {
    return generateRandom333();
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