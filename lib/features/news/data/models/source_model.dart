import 'package:news_app/features/news/domain/entities/source_entity.dart';

class SourceModel extends SourceEntity {
  const SourceModel({required super.id, required super.name});

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json["id"],
      name: json["name"],
    );
  }
}
