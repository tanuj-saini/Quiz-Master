import 'package:quiz/Models/QuestionsModels.dart';

class QuestionModel {
  int? id;
  Null? name;
  String? title;
  String? description;
  Null? difficultyLevel;
  String? topic;
  String? time;
  bool? isPublished;
  String? createdAt;
  String? updatedAt;
  int? duration;
  String? endTime;
  String? negativeMarks;
  String? correctAnswerMarks;
  bool? shuffle;
  bool? showAnswers;
  bool? lockSolutions;
  bool? isForm;
  bool? showMasteryOption;
  Null? readingMaterial;
  Null? quizType;
  bool? isCustom;
  Null? bannerId;
  Null? examId;
  bool? showUnanswered;
  String? endsAt;
  Null? lives;
  String? liveCount;
  int? coinCount;
  int? questionsCount;
  String? dailyDate;
  int? maxMistakeCount;
  List<ReadingMaterial> readingMaterials = [];
  List<Questions>? questions;
  int? progress;

  QuestionModel(
      {this.id,
      this.name,
      this.title,
      this.description,
      this.difficultyLevel,
      this.topic,
      this.time,
      this.isPublished,
      this.createdAt,
      this.updatedAt,
      this.duration,
      this.endTime,
      this.negativeMarks,
      this.correctAnswerMarks,
      this.shuffle,
      this.showAnswers,
      this.lockSolutions,
      this.isForm,
      this.showMasteryOption,
      this.readingMaterial,
      this.quizType,
      this.isCustom,
      this.bannerId,
      this.examId,
      this.showUnanswered,
      this.endsAt,
      this.lives,
      this.liveCount,
      this.coinCount,
      this.questionsCount,
      this.dailyDate,
      this.maxMistakeCount,
      this.questions,
      this.progress});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    description = json['description'];
    difficultyLevel = json['difficulty_level'];
    topic = json['topic'];
    time = json['time'];
    isPublished = json['is_published'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    duration = json['duration'];
    endTime = json['end_time'];
    negativeMarks = json['negative_marks'];
    correctAnswerMarks = json['correct_answer_marks'];
    shuffle = json['shuffle'];
    showAnswers = json['show_answers'];
    lockSolutions = json['lock_solutions'];
    isForm = json['is_form'];
    showMasteryOption = json['show_mastery_option'];
    readingMaterial = json['reading_material'];
    quizType = json['quiz_type'];
    isCustom = json['is_custom'];
    bannerId = json['banner_id'];
    examId = json['exam_id'];
    showUnanswered = json['show_unanswered'];
    endsAt = json['ends_at'];
    lives = json['lives'];
    liveCount = json['live_count'];
    coinCount = json['coin_count'];
    questionsCount = json['questions_count'];
    dailyDate = json['daily_date'];
    maxMistakeCount = json['max_mistake_count'];
    readingMaterials = [];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['description'] = this.description;
    data['difficulty_level'] = this.difficultyLevel;
    data['topic'] = this.topic;
    data['time'] = this.time;
    data['is_published'] = this.isPublished;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['duration'] = this.duration;
    data['end_time'] = this.endTime;
    data['negative_marks'] = this.negativeMarks;
    data['correct_answer_marks'] = this.correctAnswerMarks;
    data['shuffle'] = this.shuffle;
    data['show_answers'] = this.showAnswers;
    data['lock_solutions'] = this.lockSolutions;
    data['is_form'] = this.isForm;
    data['show_mastery_option'] = this.showMasteryOption;
    data['reading_material'] = this.readingMaterial;
    data['quiz_type'] = this.quizType;
    data['is_custom'] = this.isCustom;
    data['banner_id'] = this.bannerId;
    data['exam_id'] = this.examId;
    data['show_unanswered'] = this.showUnanswered;
    data['ends_at'] = this.endsAt;
    data['lives'] = this.lives;
    data['live_count'] = this.liveCount;
    data['coin_count'] = this.coinCount;
    data['questions_count'] = this.questionsCount;
    data['daily_date'] = this.dailyDate;
    data['max_mistake_count'] = this.maxMistakeCount;
    data['reading_materials'] =
        readingMaterials.map((v) => v.toJson()).toList();

    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['progress'] = this.progress;
    return data;
  }
}

class ReadingMaterial {
  int? id;
  String? name;
  String? description;
  String? content;

  ReadingMaterial({
    this.id,
    this.name,
    this.description,
    this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'content': content,
    };
  }

  ReadingMaterial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    content = json['content'];
  }
}
