
import 'dart:convert';

List<News> newsFromJson(String str) => List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
    News({
        this.postId,
        this.id,
        this.name,
        this.email,
        this.body,
    });

    int? postId;
    int? id;
    String? name;
    String? email;
    String? body;

    factory News.fromJson(Map<String, dynamic> json) => News(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };
}
