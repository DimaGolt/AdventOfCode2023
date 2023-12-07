import 'dart:io';

void main() {
  var path = '7Dec/input.txt';
  List<String> file = File(path).readAsLinesSync();
  List<Hand> hands = [];

  for (var line in file) {
    hands.add(Hand(
        hand: line
            .split(' ')
            .first
            .trim()
            .split('')
            .map((e) => Card.parse(e))
            .toList(),
        bet: int.parse(line.split(' ').last)));
  }

  hands.sort((a, b) => a.compare(b));

  int sum = 0;

  for (var i = 0; i < hands.length; i++) {
    sum += hands[i].bet * (i + 1);
  }

  print(sum);
}

enum Type {
  FiveKind(6),
  FourKind(5),
  Full(4),
  ThreeKind(3),
  TwoPair(2),
  OnePair(1),
  HighCard(0);

  final int value;
  const Type(this.value);
}

enum Card {
  A(14, 'A'),
  K(13, 'K'),
  Q(12, 'Q'),
  J(11, 'J'),
  T(10, 'T'),
  Nine(9, '9'),
  Eight(8, '8'),
  Seven(7, '7'),
  Six(6, '6'),
  Five(5, '5'),
  Four(4, '4'),
  Three(3, '3'),
  Two(2, '2');

  final int value;
  final String str;
  const Card(this.value, this.str);

  factory Card.parse(String string) {
    switch (string) {
      case 'A':
        return A;
      case 'K':
        return K;
      case 'Q':
        return Q;
      case 'J':
        return J;
      case 'T':
        return T;
      case '9':
        return Nine;
      case '8':
        return Eight;
      case '7':
        return Seven;
      case '6':
        return Six;
      case '5':
        return Five;
      case '4':
        return Four;
      case '3':
        return Three;
      case '2':
        return Two;
      default:
        return Two;
    }
  }

  compareTo(Card other) {
    return value.compareTo(other.value);
  }

  @override
  toString() {
    return str;
  }
}

class Hand {
  List<Card> hand;
  int bet;
  Type? type;

  Hand({required this.hand, required this.bet}) {
    type = _checkType();
  }

  _checkType() {
    var sortedHand = (List.of(hand)..sort((a, b) => a.compareTo(b)))
        .fold('', (previousValue, value) => previousValue += value.str);

    if (RegExp(r'(.)\1{4}').hasMatch(sortedHand)) {
      return Type.FiveKind;
    }
    if (RegExp(r'(.)\1{3}').hasMatch(sortedHand)) {
      return Type.FourKind;
    }
    var foo = RegExp(r'(.)\1{2}').firstMatch(sortedHand);
    if (foo != null &&
        RegExp(r'([^' + foo.group(0)! + r'])\1{1}').hasMatch(sortedHand)) {
      return Type.Full;
    }
    if (RegExp(r'(.)\1{2}').hasMatch(sortedHand)) {
      return Type.ThreeKind;
    }
    if (RegExp(r'(.)\1{1}').allMatches(sortedHand).length == 2) {
      return Type.TwoPair;
    }
    if (RegExp(r'(.)\1{1}').allMatches(sortedHand).length == 1) {
      return Type.OnePair;
    }
    return Type.HighCard;
  }

  int compare(Hand other) {
    if (type!.value < other.type!.value) {
      return -1;
    }
    if (type!.value > other.type!.value) {
      return 1;
    }
    if (type! == other.type!) {
      int compareRes = 0;
      for (var i = 0; i < hand.length; i++) {
        compareRes = hand[i].value.compareTo(other.hand[i].value);
        if (compareRes != 0) {
          return compareRes;
        }
      }
    }
    return 0;
  }

  static int _findHighest(List<Card> hand) {
    List<Card> cards = hand;
    if (cards.contains('A')) return 14;
    if (cards.contains('K')) return 13;
    if (cards.contains('Q')) return 12;
    if (cards.contains('J')) return 11;
    if (cards.contains('T')) return 10;
    if (cards.contains('9')) return 9;
    if (cards.contains('8')) return 8;
    if (cards.contains('7')) return 7;
    if (cards.contains('6')) return 6;
    if (cards.contains('5')) return 5;
    if (cards.contains('4')) return 4;
    if (cards.contains('3')) return 3;
    if (cards.contains('2')) return 2;
    return 0;
  }

  @override
  String toString() {
    return '$hand $bet';
  }
}
