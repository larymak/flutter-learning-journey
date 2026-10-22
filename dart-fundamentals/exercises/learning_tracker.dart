void main() {
  final developerName = 'Lary';
  const totalLessons = 40;
  var completedLessons = 25;
  bool passedAssessment = false;
  String learnerLevel = '';

  // Calculate remaining lessons and percentage progress.
  int remainingLessons = totalLessons - completedLessons;
  double progress = completedLessons / totalLessons * 100;

  // Classify the learner based on completed lessons.
  if (completedLessons >= 30) {
    learnerLevel = 'Advanced';
  } else if (completedLessons >= 15) {
    learnerLevel = 'Intermediate';
  } else {
    learnerLevel = 'Beginner learner';
  }

  // Both requirements must be met for certificate eligibility.
  bool eligible = completedLessons >= 30 && passedAssessment;

  print('=== FLUTTER LEARNING TRACKER ===');
  print('Developer: $developerName');
  print('Completed: $completedLessons/$totalLessons');
  print('Remaining: $remainingLessons');
  print('Progress: $progress%');
  print('Level: $learnerLevel');
  print('Certificate eligible: $eligible');
  print('================================');
}
