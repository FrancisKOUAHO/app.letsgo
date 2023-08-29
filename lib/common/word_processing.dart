resumeWord(wordText) {
  var words = wordText;
  var word = words.substring(0, 35);
  var fusionWord = word + '...';
  return fusionWord;
}

resumeDesc(wordText) {
  var words = wordText;
  var word = words.substring(0, 28);
  var fusionWord = word + '...';
  return fusionWord;
}

splitsTheString(string) {
  final splitted = string.split(' ');
  return splitted[0];
}

splitsTheMap(string) {
  final splitted = string.split(',');
  return '${splitted[0]} ${splitted[1]}';
}

resumeWordTitle(wordText) {
  var words = wordText;
  var word = words.substring(0, 24);
  var fusionWord = word;
  return fusionWord;
}

currentAddressOk(wordText) {
  var words = wordText;
  var splitted = words.split(',');
  return words.length > 20 ? '${splitted[0]} ${splitted[1]}' : words;
}

addressOk(wordText) {
  var words = wordText;
  var splitted = words.split(',');
  return splitted[0] + '' + splitted[1];
}
