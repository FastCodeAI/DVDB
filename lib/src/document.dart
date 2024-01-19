import 'dart:math';
import 'package:uuid/uuid.dart';

class Document {
  Document({String? id, required this.text, required this.embedding, Map<String, String>? metadata})
      : id = id ?? _generateUuid(),
        magnitude = _calculateMagnitude(embedding),
        metadata = metadata ?? Map<String, String>();
  
  final String id;
  final String text;
  final List<double> embedding;
  final double magnitude;
  final Map<String, String> metadata;

  static String _generateUuid() {
    return Uuid().v1();
  }

  static double _calculateMagnitude(List<double> embedding) {
    return sqrt(embedding.fold(0, (num sum, double element) => sum + element * element));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'embedding': embedding,
      'magnitude': magnitude,
      'metadata': metadata,
    };
  }

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      text: json['text'],
      embedding: List<double>.from(json['embedding']),
      metadata: Map<String, String>.from(json['metadata'])
    );
  }
}
