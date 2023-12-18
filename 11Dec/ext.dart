import 'dart:io';
import 'dart:math';

void main() {
  var path = '11Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<List<String>> rows = file.map((e) => e.split('').toList()).toList();

  int mult = 999999;

  List<int> rowsAdd = [];
  for (var i = 0; i < rows.length; i++) {
    if (!rows[i].contains('#')) rowsAdd.add(i);
  }

  List<int> columnsAdd = [];
  for (var i = 0; i < rows.first.length; i++) {
    if (rows.every((element) => element[i] == '.')) columnsAdd.add(i);
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
      int x = (galaxies[i].row - galaxies[j].row).abs();
      int y = (galaxies[i].column - galaxies[j].column).abs();

      int xMult = rowsAdd
          .where((element) =>
              element < max(galaxies[i].row, galaxies[j].row) &&
              element > min(galaxies[i].row, galaxies[j].row))
          .length;

      int yMult = columnsAdd
          .where((element) =>
              element < max(galaxies[i].column, galaxies[j].column) &&
              element > min(galaxies[i].column, galaxies[j].column))
          .length;
      sum += x + y + (xMult * mult) + (yMult * mult);
    }
  }

  print(sum);
}

class Galaxy {
  int row;
  int column;

  Galaxy(this.row, this.column);
}
