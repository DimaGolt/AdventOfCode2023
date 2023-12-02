import 'dart:io';

void main() async {
  var path = '2Dec/input.txt';
  List<String> file = await File(path).readAsLines();
  List<Game> games = file.map((e) => Game.FromLine(e)).toList();

  int _checkPossible(GameSet checkSet) {
    int sum = 0;
    for (Game game in games) {
      bool possible = true;
      for (GameSet set in game.sets) {
        if (set.red > checkSet.red ||
            set.green > checkSet.green ||
            set.blue > checkSet.blue) possible = false;
      }
      possible ? sum += game.num : null;
    }
    return sum;
  }

  print(_checkPossible(GameSet(red: 12, green: 13, blue: 14)));
}

class Game {
  final int num;
  final List<GameSet> sets;

  Game({required this.num, required this.sets});

  factory Game.FromLine(String line) {
    int number =
        int.parse(line.split(':').first.replaceAll(RegExp('[a-zA-Z]'), ''));
    List<GameSet> sets = line
        .split(':')
        .last
        .split(';')
        .map((e) => GameSet.FromString(e))
        .toList();

    return Game(num: number, sets: sets);
  }

  @override
  String toString() {
    return 'Game $num: $sets';
  }
}

class GameSet {
  final int red;
  final int green;
  final int blue;

  GameSet({required this.red, required this.green, required this.blue});

  factory GameSet.FromString(String string) {
    List<String> colors = string.split(',');
    int? red, green, blue;

    for (String color in colors) {
      if (color.contains('red'))
        red = int.parse(
            color.split(':').first.replaceAll(RegExp('[a-zA-Z]'), ''));
      if (color.contains('green'))
        green = int.parse(
            color.split(':').first.replaceAll(RegExp('[a-zA-Z]'), ''));
      if (color.contains('blue'))
        blue = int.parse(
            color.split(':').first.replaceAll(RegExp('[a-zA-Z]'), ''));
    }

    return GameSet(red: red ?? 0, green: green ?? 0, blue: blue ?? 0);
  }

  @override
  String toString() {
    return '${blue != 0 ? 'blue $blue,' : ''}${red != 0 ? 'red $red,' : ''}${green != 0 ? 'green $green,' : ''};';
  }
}
