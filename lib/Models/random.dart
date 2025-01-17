class ReadingMaterial {
  int? id;
  String? content;

  ReadingMaterial({this.id, this.content});

  factory ReadingMaterial.fromJson(Map<String, dynamic> json) {
    return ReadingMaterial(
      id: json['id'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'content': this.content,
    };
  }
}
