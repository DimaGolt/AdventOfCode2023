import 'dart:io';
import 'dart:math';

void main() {
  var path = '11Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<List<String>> rows = file.map((e) => e.split('').toList()).toList();

  List<int> rowsAdd = [];
  for (var i = 0; i < rows.length; i++) {
    if (!rows[i].contains('#')) rowsAdd.add(i);
  }

  for (var i = 0; i < rowsAdd.length; i++) {
    rows.insert(
        rowsAdd[i] + i, List.generate(rows.first.length, (index) => '.'));
  }

  List<int> columnsAdd = [];
  for (var i = 0; i < rows.first.length; i++) {
    if (rows.every((element) => element[i] == '.')) columnsAdd.add(i);
  }

  for (var i = 0; i < columnsAdd.length; i++) {
    rows.forEach((element) {
      element.insert(columnsAdd[i] + i, '.');
    });
  }

  List<Galaxy> galaxies = [];

  for (var i = 0; i < rows.length; i++) {
    for (var j = 0; j < rows.first.length; j++) {
      if (rows[i][j] == '#') galaxies.add(Galaxy(i, j));
    }
  }
  int sum = 0;
  for (var i = 0; i < galaxies.length; i++) {
    for (var j = i + 1; j < galaxies.length; j++) {
      sum += galaxies[i].calculatePath(galaxies[j]);
    }
  }

  print(sum);
}

class Galaxy {
  int row;
  int column;

  Galaxy(this.row, this.column);

  int calculatePath(Galaxy other) {
    int x = (row - other.row).abs();
    int y = (column - other.column).abs();
    return x + y;
  }
}
