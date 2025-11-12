// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
    List<Question> questions;

    QuestionsModel({
        required this.questions,
    });

    factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
    };
}

class Question {
    int id;
    String questionText;
    int questionOrder;
    DateTime createdAt;
    DateTime updatedAt;
    List<SurveyOption> surveyOptions;

    Question({
        required this.id,
        required this.questionText,
        required this.questionOrder,
        required this.createdAt,
        required this.updatedAt,
        required this.surveyOptions,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questionText: json["question_text"],
        questionOrder: json["question_order"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        surveyOptions: List<SurveyOption>.from(json["SurveyOptions"].map((x) => SurveyOption.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question_text": questionText,
        "question_order": questionOrder,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "SurveyOptions": List<dynamic>.from(surveyOptions.map((x) => x.toJson())),
    };
}

class SurveyOption {
    int id;
    String optionText;
    DateTime createdAt;
    DateTime updatedAt;
    int questionId;

    SurveyOption({
        required this.id,
        required this.optionText,
        required this.createdAt,
        required this.updatedAt,
        required this.questionId,
    });

    factory SurveyOption.fromJson(Map<String, dynamic> json) => SurveyOption(
        id: json["id"],
        optionText: json["option_text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        questionId: json["question_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "option_text": optionText,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "question_id": questionId,
    };
}
