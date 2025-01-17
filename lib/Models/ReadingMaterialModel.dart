import 'package:quiz/Models/PracticeMaterialModel.dart';

class ReadingMaterial {
  int? id;
  String? keywords;
  Null? content;
  String? createdAt;
  String? updatedAt;
  List<String>? contentSections;
  PracticeMaterial? practiceMaterial;

  ReadingMaterial(
      {this.id,
      this.keywords,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.contentSections,
      this.practiceMaterial});

  ReadingMaterial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keywords = json['keywords'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    contentSections = json['content_sections'].cast<String>();
    practiceMaterial = json['practice_material'] != null
        ? new PracticeMaterial.fromJson(json['practice_material'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keywords'] = this.keywords;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['content_sections'] = this.contentSections;
    if (this.practiceMaterial != null) {
      data['practice_material'] = this.practiceMaterial!.toJson();
    }
    return data;
  }
}
