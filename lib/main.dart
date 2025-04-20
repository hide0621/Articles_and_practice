String getGreetingByTime(String timeOfDay) {
  return switch (timeOfDay) {
    'morning' => 'おはようございます',
    'afternoon' => 'こんにちは',
    'evening' => 'こんばんは',
    _ => 'こんにちは（時間帯不明）',
  };
}

void main() {
  print(getGreetingByTime('morning')); // おはようございます
  print(getGreetingByTime('evening')); // こんばんは
  print(getGreetingByTime('night')); // こんにちは（時間帯不明）
}
