import 'dart:io';

void main() async {
  var path = '1Dec/input.txt';

  File file = await File(path);
  int sum = 0;

  for (String line in file.readAsLinesSync()) {
    String foo = line.replaceAll(RegExp('[a-zA-Z]'), '');
    sum += int.parse(
        foo.substring(0, 1) + foo.substring(foo.length - 1, foo.length));
  }
  print(sum);
}
