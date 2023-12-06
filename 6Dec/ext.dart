import 'dart:io';

void main() {
  var path = '6Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();

  Race race = Race(
      bestDistance: int.parse(file.last.replaceAll(' ', '').split(':').last),
      duration: int.parse(file.first.replaceAll(' ', '').split(':').last));

  for (var i = 1; i < race.duration; i++) {
    if (i * (race.duration - i) > race.bestDistance) {
      race.numberOfWaysToWin++;
    }
  }

  print(race.numberOfWaysToWin);
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
