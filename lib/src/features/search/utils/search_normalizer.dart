String normalize(String input) {
  return input
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9 ]'), '') // remove symbols
      .replaceAll(RegExp(r'\s+'), ' ')       // normalize spaces
      .trim();
}

String singular(String word) {
  if (word.endsWith('s')) return word.substring(0, word.length - 1);
  return word;
}

String mergeNoSpace(String input) {
  return input.replaceAll(' ', '');
}
