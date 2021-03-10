import 'package:json_annotation/json_annotation.dart';
part 'Data.g.dart';

@JsonSerializable()
class Data {
  int id;
  String username;
  String docId;
  String status;

  Data(this.id, this.username, this.docId, this.status);

  // Map<String, dynamic> toJson() {
  //   var json = <String, dynamic>{
  //     'idLevel': idLevel,
  //     'idReport': idReport,
  //   };

  //   return json;
  // }

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
