import 'dart:io';

void main() async {
  var path = '2Dec/input.txt';
  List<String> file = await File(path).readAsLines();
  List<Game> games = file.map((e) => Game.FromLine(e)).toList();
  List<GameSet> minimumSets = games.map((e) => e.minimumSet()).toList();
  print(minimumSets.fold<int>(
      0, (previousValue, element) => previousValue + element.power));
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

  GameSet minimumSet() {
    int red = 0, green = 0, blue = 0;
    for (var set in sets) {
      if (set.red > red) red = set.red;
      if (set.green > green) green = set.green;
      if (set.blue > blue) blue = set.blue;
    }
    return GameSet(red: red, green: green, blue: blue);
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

  int get power => red * green * blue;

  @override
  String toString() {
    return '${blue != 0 ? 'blue $blue,' : ''}${red != 0 ? 'red $red,' : ''}${green != 0 ? 'green $green,' : ''};';
  }
}
