import 'package:nepali_utils/nepali_utils.dart';

class NewsModel {
  final int id;
  final String title;
  final NepaliDateTime publishedAt;
  final String publishedMonth;
  final int publishedYear;
  final int numberOfQuestions;
  final int status;
  NewsModel({
    required this.id,
    required this.title,
    required this.publishedAt,
    required this.publishedMonth,
    required this.publishedYear,
    required this.numberOfQuestions,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'published_at': NepaliDateFormat("yyyy-MM-dd").format(publishedAt),
      'published_month': publishedMonth,
      'published_year': publishedYear,
      'n_questions': numberOfQuestions,
      'status': status,
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? -1,
      title: json['title'] ?? '',
      publishedAt:
          NepaliDateTime.tryParse(json['published_at']) ?? NepaliDateTime.now(),
      publishedMonth: json['published_month'] ?? '',
      publishedYear: json['published_year'] ?? -1,
      numberOfQuestions: json['n_questions'] ?? -1,
      status: json['status'] ?? -1,
    );
  }
}
