void main() {
  final completedLessons = [10, 25, 35, 5, 40];

  int advancedLearners = 0;
  int totalCompleted = 0;

  print('=== LEARNER PROGRESS REPORT ===');

  for (int i = 0; i < completedLessons.length; i++) {
    final completed = completedLessons[i];
    String learnerLevel;

    if (completed >= 30) {
      learnerLevel = 'Advanced';
      advancedLearners++;
    } else if (completed >= 15) {
      learnerLevel = 'Intermediate';
    } else {
      learnerLevel = 'Beginner';
    }

    totalCompleted += completed;

    print('Learner ${i + 1}: $completed lessons - $learnerLevel');
  }

  print('');
  print('Advanced learners: $advancedLearners');
  print('Total completed lessons: $totalCompleted');
  print('===============================');
}
