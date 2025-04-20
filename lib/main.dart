String getGreetingByTime(String timeOfDay) {
  switch (timeOfDay) {
    case 'morning':
      return 'おはようございます';
    case 'afternoon':
      return 'こんにちは';
    case 'evening':
      return 'こんばんは';
    default:
      return 'こんにちは（時間帯不明）';
  }
}

void main() {
  print(getGreetingByTime('morning')); // おはようございます
  print(getGreetingByTime('evening')); // こんばんは
  print(getGreetingByTime('night')); // こんにちは（時間帯不明）
}
