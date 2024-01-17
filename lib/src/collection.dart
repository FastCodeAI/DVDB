import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:math';
// ignore: unused_import
import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

import 'document.dart';
import 'search_result.dart';

class Collection {
  Collection(this.name){
    load();
  }

  final String name;
  final Map<String, Document> documents = {};

  void addDocument(String? id, String text, List<double> embedding) {
    var uuid = Uuid();
    final Document document = Document(
      id: id ?? uuid.v1(),
      text: text,
      embedding: embedding,
    );

    documents[document.id] = document;
    save();
  }

  void addDocuments(List<Document> docs) {
    for (final Document doc in docs) {
      documents[doc.id] = doc;
    }
    save();
  }

  void removeDocument(String id) {
    documents.remove(id);
    save();
  }

  List<SearchResult> search(List<double> query, {int numResults = 10, double? threshold}) {
    final double queryMagnitude = _calculateMagnitude(query);

    final List<SearchResult> similarities = <SearchResult>[];
    for (var document in documents.values) {
      // print(document);
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

  void save() async {
    final Directory tempDir =  await getTemporaryDirectory();
    final File file = File('${tempDir.path}/$name.json');
    final String encodedDocuments = json.encode(documents);
    file.writeAsString(encodedDocuments);
  }

  void load() async {
    final Directory tempDir =  await getTemporaryDirectory();
    final File file = File('${tempDir.path}/$name.json');

    if (!file.existsSync()) {
      print('File does not exist for collection $name, initializing with empty documents.');
      documents.clear();
      return;
    }

    final String data = await file.readAsString();
    final Map<String, dynamic> decodedData = json.decode(data) as Map<String, dynamic>;
    // ignore: always_specify_types
    decodedData.forEach((key, value) {
      documents[key] = Document.fromJson(value);
    });

    print('Successfully loaded collection: $name');
  }

  void clear({String? id}) {
    if (id == null)
    {
    documents.clear();
    }
    else {
      documents.remove(id);
    }
    save();
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
