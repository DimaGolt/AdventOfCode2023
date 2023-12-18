import 'dart:io';

void main() {
  var path = '10Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<List<Tile>> tilesMap = file
      .map((e) => e.split('').map((e) => Tile.fromString(e)).toList())
      .toList();

  for (var i = 0; i < tilesMap.length; i++) {
    for (var j = 0; j < tilesMap[i].length; j++) {
      if (j != 0) tilesMap[i][j].W = tilesMap[i][j - 1];
      if (j != tilesMap[i].length - 1) tilesMap[i][j].E = tilesMap[i][j + 1];
      if (i != 0) tilesMap[i][j].N = tilesMap[i - 1][j];
      if (i != tilesMap.length - 1) tilesMap[i][j].S = tilesMap[i + 1][j];
    }
  }

  List<Tile> tiles =
      tilesMap.fold([], (previousValue, element) => previousValue + element);
  tiles.removeWhere((element) => element.pipe == Pipe.G);
  tiles.forEach((element) => element.removeUnused());

  List<bool> visited = List.generate(tiles.length, (index) => false);
  visited[0] = true;
  int finalCost = 0;
  Tile trueStart = tiles.firstWhere((element) => element.pipe == Pipe.S);
  trueStart.removeUnusedStart();

  _examineLoop(Tile start) {
    Tile next = start.next(trueStart);
    Tile prev = start;
    int cost = 0;
    while (next.pipe != Pipe.S) {
      cost++;
      var foo = next;
      next = next.next(prev);
      prev = foo;
    }
    if (cost > finalCost) finalCost = cost;
  }

  if (trueStart.N != null) _examineLoop(trueStart.N!);
  if (trueStart.E != null) _examineLoop(trueStart.E!);
  if (trueStart.S != null) _examineLoop(trueStart.S!);
  if (trueStart.W != null) _examineLoop(trueStart.W!);

  finalCost += 2;
  print(finalCost ~/ 2);
}

enum Pipe {
  V,
  H,
  NE,
  NW,
  SW,
  SE,
  G,
  S;
}

class Tile {
  Tile? N;
  Tile? E;
  Tile? S;
  Tile? W;
  Pipe pipe;

  Tile({this.N, this.E, this.S, this.W, required this.pipe});

  factory Tile.fromString(String string) {
    switch (string) {
      case '|':
        return Tile(pipe: Pipe.V);
      case '-':
        return Tile(pipe: Pipe.H);
      case 'L':
        return Tile(pipe: Pipe.NE);
      case 'J':
        return Tile(pipe: Pipe.NW);
      case '7':
        return Tile(pipe: Pipe.SW);
      case 'F':
        return Tile(pipe: Pipe.SE);
      case 'S':
        return Tile(pipe: Pipe.S);
      default:
        return Tile(pipe: Pipe.G);
    }
  }

  removeUnused() {
    switch (pipe) {
      case Pipe.V:
        E = null;
        W = null;
        break;
      case Pipe.H:
        N = null;
        S = null;
        break;
      case Pipe.NE:
        S = null;
        W = null;
        break;
      case Pipe.NW:
        S = null;
        E = null;
        break;
      case Pipe.SW:
        N = null;
        E = null;
        break;
      case Pipe.SE:
        N = null;
        W = null;
        break;
      case Pipe.G:
        N = null;
        E = null;
        S = null;
        W = null;
        break;
      case Pipe.S:
        break;
    }
  }

  removeUnusedStart() {
    if (N != null && (N?.S != this || N?.pipe == Pipe.G)) N = null;
    if (E != null && (E?.W != this || E?.pipe == Pipe.G)) E = null;
    if (S != null && (S?.N != this || S?.pipe == Pipe.G)) S = null;
    if (W != null && (W?.E != this || W?.pipe == Pipe.G)) W = null;
  }

  Tile next(Tile? prev) {
    if (N != null && N != prev) return N!;
    if (E != null && E != prev) return E!;
    if (S != null && S != prev) return S!;
    if (W != null && W != prev) return W!;
    return N!;
  }

  @override
  String toString() {
    return '${pipe.name}';
  }
}
