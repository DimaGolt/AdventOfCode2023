import 'dart:io';

void main() async {
  var path = '3Dec/input.txt';
  List<String> file = await File(path).readAsLines();
  List<Part> parts = [];
  List<Symbol> symbols = [];

  for (var line in file) {
    var regNum = RegExp('\\d+');
    var regSym = RegExp(r'((?!\d)(?!\.).)');

    var matches = regNum.allMatches(line).toList();
    parts.addAll(matches.map((e) => Part(
        wholeNumber: int.parse(e[0]!),
        row: file.indexOf(line),
        start: e.start,
        end: e.end)));
    matches = regSym.allMatches(line).toList();
    symbols.addAll(matches.map((e) => Symbol(
        symbol: e[0]!, row: file.indexOf(line), start: e.start, end: e.end)));
  }

  parts.retainWhere((part) => symbols.any((symbol) {
        if (symbol.row == part.row)
          return symbol.start == part.start - 1 || symbol.start == part.end;

        if (symbol.row == part.row - 1 || symbol.row == part.row + 1)
          return symbol.start >= part.start - 1 && symbol.end <= part.end + 1;

        return false;
      }));

  print(parts.fold<int>(
      0, (previousValue, element) => previousValue += element.wholeNumber));
}

class Part {
  int wholeNumber;
  int row;
  int start;
  int end;

  Part(
      {required this.wholeNumber,
      required this.row,
      required this.start,
      required this.end});
}

class Symbol {
  late String symbol;
  late int row;
  late int start;
  late int end;

  Symbol(
      {required this.symbol,
      required this.row,
      required this.start,
      required this.end});
}
