import 'dart:io';

void main() {
  var path = '8Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<String> instructions = file[0].split('');
  file.removeAt(0);
  file.removeAt(0);

  List<Node> nodes = file.map(Node.fromString).toList();

  Node current = nodes.firstWhere((element) => element.name == 'AAA');
  Node finish = nodes.firstWhere((element) => element.name == 'ZZZ');
  int currentInstruction = 0;
  int step = 0;

  while (current != finish) {
    current = nodes.firstWhere((element) =>
        element.name ==
        (instructions[currentInstruction] == 'R'
            ? current.right
            : current.left));
    currentInstruction++;
    step++;
    currentInstruction %= instructions.length;
  }
  print(step);
}

class Node {
  final String name;
  final String left;
  final String right;

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
