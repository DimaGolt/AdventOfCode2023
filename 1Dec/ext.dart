import 'dart:io';

void main() async {
  var path = '1Dec/input.txt';

  String replaceStringNumbers(String line) {
    line = line.replaceAll('one', 'o1e');
    line = line.replaceAll('two', 't2o');
    line = line.replaceAll('three', 't3e');
    line = line.replaceAll('four', 'f4r');
    line = line.replaceAll('five', 'f5e');
    line = line.replaceAll('six', 's6x');
    line = line.replaceAll('seven', 's7n');
    line = line.replaceAll('eight', 'e8t');
    line = line.replaceAll('nine', 'n9e');
    return line;
  }

  File file = await File(path);
  int sum = 0;

  for (String line in file.readAsLinesSync()) {
    String foo = replaceStringNumbers(line);
    foo = foo.replaceAll(RegExp('[a-zA-Z]'), '');
    int numberToAdd = int.parse(
        foo.substring(0, 1) + foo.substring(foo.length - 1, foo.length));
    sum += numberToAdd;
  }
  print(sum);
}
