import 'package:hive_ce/hive.dart';

part 'search_request_model.g.dart';

@HiveType(typeId: 1)
class SearchRequestModel {
  @HiveField(0)
  final String username;

  SearchRequestModel({required this.username});

  Map<String, dynamic> toMap() {
    return {'username': username};
  }

  factory SearchRequestModel.fromMap(Map<String, dynamic> map) {
    return SearchRequestModel(username: map['username'] as String);
  }
}
