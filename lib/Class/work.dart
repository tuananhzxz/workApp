// To parse this JSON data, do
//
//     final work = workFromMap(jsonString);

import 'dart:convert';

Work workFromMap(String str) => Work.fromMap(json.decode(str));

String workToMap(Work data) => json.encode(data.toMap());

class Work {
    final int? workId;
    final String title;
    final String content;

    Work({
        this.workId,
        required this.title,
        required this.content,
    });

    factory Work.fromMap(Map<String, dynamic> json) => Work(
        workId: json["workId"],
        title: json["title"],
        content: json["content"],
    );

    Map<String, dynamic> toMap() => {
        "workId": workId,
        "title": title,
        "content": content,
    };

}
List<Work> allData = [];