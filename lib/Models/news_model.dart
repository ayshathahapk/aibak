class NewsModel {
  final String newsTitle;
  final String newsContent;

//<editor-fold desc="Data Methods">
  const NewsModel({
    required this.newsTitle,
    required this.newsContent,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewsModel &&
          runtimeType == other.runtimeType &&
          newsTitle == other.newsTitle &&
          newsContent == other.newsContent);

  @override
  int get hashCode => newsTitle.hashCode ^ newsContent.hashCode;

  @override
  String toString() {
    return 'NewsModel{ newsTitle: $newsTitle, newsContent: $newsContent,}';
  }

  NewsModel copyWith({
    String? newsTitle,
    String? newsContent,
  }) {
    return NewsModel(
      newsTitle: newsTitle ?? this.newsTitle,
      newsContent: newsContent ?? this.newsContent,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'newsTitle': newsTitle,
      'newsContent': newsContent,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      newsTitle: map['newsTitle'] ?? "",
      newsContent: map['newsContent'] ?? "",
    );
  }

//</editor-fold>
}
