import 'package:quiz/Models/OPtionModel.dart';
import 'package:quiz/Models/ReadingMaterialModel.dart';

class Questions {
  int? id;
  String? description;
  Null? difficultyLevel;
  String? topic;
  bool? isPublished;
  String? createdAt;
  String? updatedAt;
  String? detailedSolution;
  String? type;
  bool? isMandatory;
  bool? showInFeed;
  String? pyqLabel;
  int? topicId;
  int? readingMaterialId;
  String? fixedAt;
  String? fixSummary;
  Null? createdBy;
  String? updatedBy;
  Null? quizLevel;
  String? questionFrom;
  Null? language;
  Null? photoUrl;
  Null? photoSolutionUrl;
  bool? isSaved;
  String? tag;
  List<Options>? options;
  ReadingMaterial? readingMaterial;

  Questions(
      {this.id,
      this.description,
      this.difficultyLevel,
      this.topic,
      this.isPublished,
      this.createdAt,
      this.updatedAt,
      this.detailedSolution,
      this.type,
      this.isMandatory,
      this.showInFeed,
      this.pyqLabel,
      this.topicId,
      this.readingMaterialId,
      this.fixedAt,
      this.fixSummary,
      this.createdBy,
      this.updatedBy,
      this.quizLevel,
      this.questionFrom,
      this.language,
      this.photoUrl,
      this.photoSolutionUrl,
      this.isSaved,
      this.tag,
      this.options,
      this.readingMaterial});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    difficultyLevel = json['difficulty_level'];
    topic = json['topic'];
    isPublished = json['is_published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    detailedSolution = json['detailed_solution'];
    type = json['type'];
    isMandatory = json['is_mandatory'];
    showInFeed = json['show_in_feed'];
    pyqLabel = json['pyq_label'];
    topicId = json['topic_id'];
    readingMaterialId = json['reading_material_id'];
    fixedAt = json['fixed_at'];
    fixSummary = json['fix_summary'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    quizLevel = json['quiz_level'];
    questionFrom = json['question_from'];
    language = json['language'];
    photoUrl = json['photo_url'];
    photoSolutionUrl = json['photo_solution_url'];
    isSaved = json['is_saved'];
    tag = json['tag'];

    options = (json['options'] as List<dynamic>?)
            ?.map((v) => Options.fromJson(v as Map<String, dynamic>))
            .toList() ??
        [];

    readingMaterial = json['reading_material'] != null
        ? ReadingMaterial.fromJson(
            json['reading_material'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['difficulty_level'] = this.difficultyLevel;
    data['topic'] = this.topic;
    data['is_published'] = this.isPublished;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['detailed_solution'] = this.detailedSolution;
    data['type'] = this.type;
    data['is_mandatory'] = this.isMandatory;
    data['show_in_feed'] = this.showInFeed;
    data['pyq_label'] = this.pyqLabel;
    data['topic_id'] = this.topicId;
    data['reading_material_id'] = this.readingMaterialId;
    data['fixed_at'] = this.fixedAt;
    data['fix_summary'] = this.fixSummary;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['quiz_level'] = this.quizLevel;
    data['question_from'] = this.questionFrom;
    data['language'] = this.language;
    data['photo_url'] = this.photoUrl;
    data['photo_solution_url'] = this.photoSolutionUrl;
    data['is_saved'] = this.isSaved;
    data['tag'] = this.tag;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    if (this.readingMaterial != null) {
      data['reading_material'] = this.readingMaterial!.toJson();
    }
    return data;
  }
}
