class PracticeMaterial {
  List<String>? content;
  List<String>? keywords;

  PracticeMaterial({this.content, this.keywords});

  PracticeMaterial.fromJson(Map<String, dynamic> json) {
    content = json['content'].cast<String>();
    keywords = json['keywords'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['keywords'] = this.keywords;
    return data;
  }
}
