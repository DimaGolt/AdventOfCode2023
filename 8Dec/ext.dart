import 'dart:io';
import 'dart:core';

void main() {
  var path = '8Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<String> instructions = file[0].split('');
  file.removeAt(0);
  file.removeAt(0);

  List<Node> nodes = file.map(Node.fromString).toList();

  List<Node> current =
      nodes.where((element) => element.name[2] == 'A').toList();
  int currentInstruction = 0;
  int step = 0;

  _checkFinish() {
    for (var i = 0; i < current.length; i++) {
      if (current[i].name[2] == 'Z' && current[i].steps == null) {
        current[i].steps = step;
      }
    }
    return current.every((element) => element.name[2] == 'Z');
  }

  while (!_checkFinish()) {
    for (var i = 0; i < current.length; i++) {
      if (current[i].name[2] != 'Z')
        current[i] = nodes.firstWhere((element) =>
            element.name ==
            (instructions[currentInstruction] == 'R'
                ? current[i].right
                : current[i].left));
    }
    currentInstruction++;
    step++;
    currentInstruction %= instructions.length;
  }

  int leastCommonMultiple(int a, int b) {
    if ((a == 0) || (b == 0)) {
      return 0;
    }

    return ((a ~/ a.gcd(b)) * b).abs();
  }

  // stepsToZ.fold(1, (prev, curr) => leastCommonMultiple(prev, curr));
  print(current.fold<int>(
      1, (prev, curr) => leastCommonMultiple(prev, curr.steps!)));
}

class Node {
  final String name;
  final String left;
  final String right;
  int? steps;

  Node({
    required this.name,
    required this.left,
    required this.right,
  });

  factory Node.fromString(String string) {
    String name = string.split('=').first.trim();
    String lr = string.split('=').last.trim();
    lr = lr.substring(1, lr.length - 1);
    String left = lr.split(',').first.trim();
    String right = lr.split(',').last.trim();
    return Node(name: name, left: left, right: right);
  }

  @override
  String toString() {
    return '$name = ($left, $right)';
  }
}
