// class NewsModel {
//   final String newsTitle;
//   final String newsContent;
//   const NewsModel({
//     required this.newsTitle,
//     required this.newsContent,
//   });
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is NewsModel &&
//           runtimeType == other.runtimeType &&
//           newsTitle == other.newsTitle &&
//           newsContent == other.newsContent);
//
//   @override
//   int get hashCode => newsTitle.hashCode ^ newsContent.hashCode;
//
//   @override
//   String toString() {
//     return 'NewsModel{ newsTitle: $newsTitle, newsContent: $newsContent,}';
//   }
//
//   NewsModel copyWith({
//     String? newsTitle,
//     String? newsContent,
//   }) {
//     return NewsModel(
//       newsTitle: newsTitle ?? this.newsTitle,
//       newsContent: newsContent ?? this.newsContent,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'newsTitle': newsTitle,
//       'newsContent': newsContent,
//     };
//   }
//
//   factory NewsModel.fromMap(Map<String, dynamic> map) {
//     return NewsModel(
//       newsTitle: map['newsTitle'] ?? "",
//       newsContent: map['newsContent'] ?? "",
//     );
//   }
//
// //</editor-fold>
// }
// To parse this JSON data, do
//
//     final newsModel = newsModelFromMap(jsonString);

import 'dart:convert';

NewsModel newsModelFromMap(String str) => NewsModel.fromMap(json.decode(str));

String newsModelToMap(NewsModel data) => json.encode(data.toMap());

class NewsModel {
  final bool success;
  final NewsModelNews news;
  final String message;

  NewsModel({
    required this.success,
    required this.news,
    required this.message,
  });

  NewsModel copyWith({
    bool? success,
    NewsModelNews? news,
    String? message,
  }) =>
      NewsModel(
        success: success ?? this.success,
        news: news ?? this.news,
        message: message ?? this.message,
      );

  factory NewsModel.fromMap(Map<String, dynamic> json) => NewsModel(
        success: json["success"],
        news: NewsModelNews.fromMap(json["news"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "news": news.toMap(),
        "message": message,
      };
}

class NewsModelNews {
  final String id;
  final List<NewsElement> news;
  final String createdBy;
  final int v;

  NewsModelNews({
    required this.id,
    required this.news,
    required this.createdBy,
    required this.v,
  });

  NewsModelNews copyWith({
    String? id,
    List<NewsElement>? news,
    String? createdBy,
    int? v,
  }) =>
      NewsModelNews(
        id: id ?? this.id,
        news: news ?? this.news,
        createdBy: createdBy ?? this.createdBy,
        v: v ?? this.v,
      );

  factory NewsModelNews.fromMap(Map<String, dynamic> json) => NewsModelNews(
        id: json["_id"],
        news: List<NewsElement>.from(
            json["news"].map((x) => NewsElement.fromMap(x))),
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "news": List<dynamic>.from(news.map((x) => x.toMap())),
        "createdBy": createdBy,
        "__v": v,
      };
}

class NewsElement {
  final String title;
  final String description;
  final String id;
  final DateTime createdAt;

  NewsElement({
    required this.title,
    required this.description,
    required this.id,
    required this.createdAt,
  });

  NewsElement copyWith({
    String? title,
    String? description,
    String? id,
    DateTime? createdAt,
  }) =>
      NewsElement(
        title: title ?? this.title,
        description: description ?? this.description,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
      );

  factory NewsElement.fromMap(Map<String, dynamic> json) => NewsElement(
        title: json["title"],
        description: json["description"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
