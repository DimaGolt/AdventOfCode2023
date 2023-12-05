import 'dart:io';

void main() {
  var path = '5Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<Range> seeds = [];
  List<Mapper> mappers = [];
  List<int> locations = [];

  Mapper? tempMapper;
  for (var i = 0; i < file.length; i++) {
    String line = file[i];
    if (i == 0) {
      List<int> values = line
          .split(':')
          .last
          .trim()
          .split(' ')
          .map((e) => int.parse(e))
          .toList();
      for (var i = 0; i < values.length; i += 2) {
        seeds.add(Range(start: values[i], stop: values[i] + values[i + 1]));
      }
      continue;
    }
    if (line == '' && i != 1) {
      mappers.add(tempMapper!);
      continue;
    }
    if (RegExp('[0-9]').hasMatch(line)) {
      List<int> values = line.split(' ').map((e) => int.parse(e)).toList();
      tempMapper!.addSpecial(values[0], values[1], values[2]);
    }
    if (line.contains('-')) {
      List<String> values = line.split(' ').first.split('-').toList();
      tempMapper = Mapper(source: values.first, dest: values.last);
    }
  }
  mappers.add(tempMapper!);

  for (var seed in seeds) {
    int lowest = double.maxFinite.toInt();
    for (var i = seed.start; i < seed.stop; i++) {
      int currVal = i;
      String currentForm = 'seed';
      while (currentForm != 'location') {
        Mapper currentMapper =
            mappers.firstWhere((element) => element.source == currentForm);
        currVal = currentMapper.mapValue(currVal);
        currentForm = currentMapper.dest;
      }
      if (currVal < lowest) lowest = currVal;
    }
    locations.add(lowest);
  }

  locations.sort();

  print(locations.first);
}

class Mapper {
  String source;
  String dest;
  List<Range> special = [];

  Mapper({required this.source, required this.dest});

  addSpecial(int dest, int source, int length) {
    special.add(
        Range(start: source, stop: source + length, change: dest - source));
  }

  int mapValue(int value) {
    for (var range in special) {
      if (range.start <= value && range.stop > value)
        return value += range.change;
    }
    return value;
  }
}

class Range {
  int start;
  int stop;
  int change;

  Range({required this.start, required this.stop, this.change = 0});
}
