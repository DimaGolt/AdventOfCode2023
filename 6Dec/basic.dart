import 'dart:io';

void main() {
  var path = '6Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<List<String>> racesStr = file
      .map((str) => RegExp('([0-9])+')
          .allMatches(str)
          .map((e) => str.substring(e.start, e.end))
          .toList())
      .toList();

  List<Race> races = [];

  for (var i = 0; i < racesStr.first.length; i++) {
    races.add(Race(
        duration: int.parse(racesStr.first[i]),
        bestDistance: int.parse(racesStr.last[i])));
  }

  for (var race in races) {
    for (var i = 1; i < race.duration; i++) {
      if (i * (race.duration - i) > race.bestDistance) {
        race.numberOfWaysToWin++;
      }
    }
  }

  print(races.fold<int>(1,
      (previousValue, element) => previousValue *= element.numberOfWaysToWin));
}

class Race {
  int bestDistance;
  int duration;
  int numberOfWaysToWin = 0;

  Race({required this.bestDistance, required this.duration});

  @override
  String toString() {
    return 'Best: $bestDistance, duration: $duration, ways to win: $numberOfWaysToWin';
  }
}
