import 'dart:math';

import 'package:russian_words/russian_words.dart';
// ignore: implementation_imports
import 'package:flutter/material.dart';

// This file has a number of platform-agnostic non-Widget utility functions.

const _myListOfRandomColors = [
  Colors.red,
  Colors.blue,
  Colors.teal,
  Colors.yellow,
  Colors.amber,
  Colors.deepOrange,
  Colors.green,
  Colors.indigo,
  Colors.lime,
  Colors.pink,
  Colors.orange,
];

final _random = Random();

// Avoid customizing the word generator, which can be slow.
// https://github.com/filiph/english_words/issues/9
final wordPairIterator = generateWordPairs();

String generateRandomHeadline() {
  final speaker = capitalizePair(wordPairIterator.first);

  switch (_random.nextInt(10)) {
    case 0:
      return '$speaker говорит ${nouns[_random.nextInt(nouns.length)]}';
    case 1:
      return '$speaker отрпавляет ${wordPairIterator.first.join(' ')}';
    case 2:
      return '$speaker публикует ${capitalizePair(wordPairIterator.first)}';
    case 3:
      return '$speaker говорит им ${nouns[_random.nextInt(nouns.length)]}';
    case 4:
      return '$speaker говорит о ${nouns[_random.nextInt(nouns.length)]}';
    case 5:
      return '$speaker говорит об ${nouns[_random.nextInt(nouns.length)]}';
    case 6:
      return '$speaker говорит в своей книге ${wordPairIterator.first.join(' ')}';
    case 7:
      return '$speaker говорит, что миру нужно ${nouns[_random.nextInt(nouns.length)]}';
    case 8:
      return '$speaker зовет свою команду ${adjectives[_random.nextInt(adjectives.length)]}';
    case 9:
      return '$speaker наконец он говорит ${nouns[_random.nextInt(nouns.length)]}';
  }

  assert(false, 'Проблема с генерацией цитаты');
  return 'Проблема создания новой строки';
}

List<MaterialColor> getRandomColors(int amount) {
  return List<MaterialColor>.generate(amount, (index) {
    return _myListOfRandomColors[_random.nextInt(_myListOfRandomColors.length)];
  });
}

List<String> getRandomNames(int amount) {
  return wordPairIterator
      .take(amount)
      .map((pair) => capitalizePair(pair))
      .toList();
}

String capitalize(String word) {
  return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
}

String capitalizePair(WordPair pair) {
  return '${capitalize(pair.first)} ${capitalize(pair.second)}';
}
