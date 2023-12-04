import 'dart:io';
import 'dart:math';

void main() async {
  var path = '4Dec/input.txt';
  List<String> file = await File(path).readAsLines();

  List<Card> cards = file.map((e) => Card.fromLine(e)).toList();

  print(cards.fold<int>(
      0, (previousValue, element) => previousValue += element.worth));
}

class Card {
  Set<int> winningNumbers;
  Set<int> cardNumbers;

  Card({required this.winningNumbers, required this.cardNumbers});

  int get worth => cardNumbers.intersection(winningNumbers).length == 0
      ? 0
      : (pow(2, cardNumbers.intersection(winningNumbers).length - 1) as int);

  factory Card.fromLine(String line) {
    String numbers = line.split(':').last;
    List<String> splitNumbers = numbers.split('|');
    Set<int?> winningNumbers =
        splitNumbers.first.split(' ').map((e) => int.tryParse(e)).toSet();
    Set<int?> cardNumbers =
        splitNumbers.last.split(' ').map((e) => int.tryParse(e)).toSet();
    winningNumbers.removeWhere((element) => element == null);
    cardNumbers.removeWhere((element) => element == null);
    return Card(
      winningNumbers: winningNumbers.map((e) => e!).toSet(),
      cardNumbers: cardNumbers.map((e) => e!).toSet(),
    );
  }
}
