class Exercise {
  final String name;
  final String type;
  bool isCompleted;

  Exercise({
    required this.name,
    required this.type,
    this.isCompleted = false
  });
}