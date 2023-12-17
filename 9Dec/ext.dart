import 'dart:io';

void main() {
  var path = '9Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();

  List<List<int>> lines =
      file.map((e) => e.split(' ').map((e) => int.parse(e)).toList()).toList();

  for (var line in lines) {
    List<List<int>> additionalLines = []..add(line);
    while (!(additionalLines.last.toSet().length == 1 &&
        additionalLines.last.toSet().first == 0)) {
      List<int> newLine = [];
      for (var i = 1; i < additionalLines.last.length; i++) {
        newLine.add(additionalLines.last[i] - additionalLines.last[i - 1]);
      }
      additionalLines.add(newLine);
    }

    additionalLines = additionalLines.reversed.toList();
    additionalLines[0].add(0);

    for (var i = 1; i < additionalLines.length; i++) {
      additionalLines[i]
          .insert(0, additionalLines[i].first - additionalLines[i - 1].first);
    }
    line = additionalLines.last;
  }

  print(lines.fold<int>(
      0, (previousValue, element) => previousValue += element.first));
}
