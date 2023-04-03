class Exercise {
  final String name;
  final String type;
  final String time;
  final String weight;
  final String reps;
  final String sets;
  bool isCompleted;

  Exercise(
      {required this.name,
      required this.type,
      this.time = '',
      this.weight = '',
      this.reps = '',
      this.sets = '',
      this.isCompleted = false});
}
