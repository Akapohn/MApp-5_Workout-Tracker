import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  Exercise({
    required this.title,
    required this.type,
    required this.duration,
    this.index
  });

  String? title;
  String? type;
  int? duration;
  int? index;

  factory Exercise.fromJson(Map<String, dynamic> json, int index) => Exercise(
    title: json["title"],
    type: json["type"],
    duration: json["duration"],
    index: index
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "type": type,
    "duration": duration,
  };

  @override
  List<Object?> get props => [title, type, duration];

  @override
  bool get stringify => true;
}