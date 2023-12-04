import 'dart:io';
import 'dart:math';

void main() async {
  var path = '4Dec/input.txt';
  List<String> file = await File(path).readAsLines();

  List<Card> cards = file.map((e) => Card.fromLine(e)).toList();

  for (var i = 0; i < cards.length; i++) {
    int cardsToAdd = cards[i].wonCards();
    for (var j = 0; j < cardsToAdd; j++) {
      cards[i + j + 1].quantity += cards[i].quantity;
    }
  }

  print(cards.fold<int>(
      0, (previousValue, element) => previousValue += element.quantity));
}

class Card {
  int quantity = 1;
  Set<int> winningNumbers;
  Set<int> cardNumbers;

  Card({required this.winningNumbers, required this.cardNumbers});

  int wonCards() => cardNumbers.intersection(winningNumbers).length;

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
