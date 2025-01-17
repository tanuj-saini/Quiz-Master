class Options {
  int? id;
  String? description;
  int? questionId;
  bool? isCorrect;
  String? createdAt;
  String? updatedAt;
  bool? unanswered;
  Null? photoUrl;

  Options(
      {this.id,
      this.description,
      this.questionId,
      this.isCorrect,
      this.createdAt,
      this.updatedAt,
      this.unanswered,
      this.photoUrl});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    questionId = json['question_id'];
    isCorrect = json['is_correct'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unanswered = json['unanswered'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['question_id'] = this.questionId;
    data['is_correct'] = this.isCorrect;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['unanswered'] = this.unanswered;
    data['photo_url'] = this.photoUrl;
    return data;
  }
}
