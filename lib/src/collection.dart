import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'document.dart';
import 'search_result.dart';

class Collection {
  Collection(this.name);

  final String name;
  final Map<String, Document> documents = {};

  void addDocument(String? id, String text, List<double> embedding, Map<String, String>? metadata) {
    var uuid = Uuid();
    final Document document = Document(
      id: id ?? uuid.v1(),
      text: text,
      embedding: embedding,
      metadata: metadata,
    );

    documents[document.id] = document;
    _writeDocument(document);
  }

  void addDocuments(List<Document> docs) {
    for (final Document doc in docs) {
      documents[doc.id] = doc;
      _writeDocument(doc);
    }
  }

  void removeDocument(String id) {
    if (documents.containsKey(id)) {
      documents.remove(id);
      _saveAllDocuments(); // Re-saving all documents after removal
    }
  }

  List<SearchResult> search(List<double> query, {int numResults = 10, double? threshold}) {
    final double queryMagnitude = _calculateMagnitude(query);

    final List<SearchResult> similarities = <SearchResult>[];
    for (var document in documents.values) {
      final double magnitude = _calculateMagnitude(document.embedding);
      final double similarity = _cosineSimilarity(query, document.embedding, queryMagnitude, magnitude);

      if (threshold != null && similarity < threshold) {
        continue;
      }

      similarities.add(SearchResult(id:document.id, text:document.text, score:similarity));
    }

    similarities.sort((SearchResult a, SearchResult b) => b.score.compareTo(a.score));
    return similarities.take(numResults).toList();
  }

  void _writeDocument(Document document) {
    final File file = File('./$name.json');
    
    var encodedDocument = json.encode(document.toJson());
    file.writeAsStringSync('$encodedDocument\n', mode: FileMode.append);
  }

  void _saveAllDocuments() {
    final File file = File('./$name.json');

    file.writeAsStringSync(''); // Clearing the file
    for (var document in documents.values) {
      _writeDocument(document);
    }
  }

  void load() {
    final File file = File('./$name.json');
    
    if (!file.existsSync()) {
      print('File does not exist for collection $name, initializing with empty documents.');
      documents.clear();
      return;
    }

    final lines = file.readAsLinesSync();

    for (var line in lines) {
      var decodedDocument = json.decode(line) as Map<String, dynamic>;
      var document = Document.fromJson(decodedDocument);
      documents[document.id] = document;
    }

    print('Successfully loaded collection: $name');
  }


  void clear() {
    documents.clear();
    _saveAllDocuments();
  }

  double _calculateMagnitude(List<double> vector) {
    return sqrt(vector.fold(0, (sum, element) => sum + element * element));
  }

  double _cosineSimilarity(List<double> a, List<double> b, double magnitudeA, double magnitudeB) {
    double dotProduct = 0.0;
    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
    }
    return dotProduct / (magnitudeA * magnitudeB);
  }
}
