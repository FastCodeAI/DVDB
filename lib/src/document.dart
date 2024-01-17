import 'dart:math';

class Document {
  Document({String? id, required this.text, required this.embedding})
      : id = id ?? _generateUuid(),
        magnitude = _calculateMagnitude(embedding);
  
  final String id;
  final String text;
  final List<double> embedding;
  final double magnitude;

  static String _generateUuid() {
    // Implement UUID generation logic or use a third-party package
    return "generated-uuid"; // Placeholder
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
    };
  }

  // Implement fromJson if JSON deserialization is needed
  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      text: json['text'],
      embedding: List<double>.from(json['embedding']),
    );
  }
}
