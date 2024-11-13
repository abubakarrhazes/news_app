// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  const SourceEntity({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
