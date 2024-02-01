import 'dart:typed_data';

import 'package:test/test.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:core';

import 'package:dvdb/dvdb.dart';

void main() {
  group('Collection', () {
    late Collection collection;
    setUp(() {
      collection = Collection('test_collection');
    });

    test('addDocument adds a document', () {
      var document = Document(id: '1', text: 'Test', embedding: Float64List.fromList([1.0]), metadata: {});
      collection.addDocument(document.id, document.text, document.embedding, metadata: document.metadata);

      expect(collection.documents.containsKey(document.id), isTrue);
    });

    test('addDocuments adds multiple documents', () {
      var documents = [
        Document(id: '1', text: 'Test 1', embedding: Float64List.fromList([1.0]), metadata: {}),
        Document(id: '2', text: 'Test 2', embedding: Float64List.fromList([2.0]), metadata: {})
      ];
      collection.addDocuments(documents);

      expect(collection.documents.length, equals(2));
    });

    test('removeDocument removes a document', () {
      var document = Document(id: '1', text: 'Test', embedding: Float64List.fromList([1.0]), metadata: {});
      collection.addDocument(document.id, document.text, document.embedding, metadata: document.metadata);
      collection.removeDocument(document.id);

      expect(collection.documents.containsKey(document.id), isFalse);
    });

    test('search returns correct results', () {
      // Setup: Adding some documents
      var documents = [
        Document(id: '1', text: 'Dart programming', embedding: Float64List.fromList([1.0, 0.0]), metadata: {}),
        Document(id: '2', text: 'Flutter development', embedding: Float64List.fromList([0.0, 1.0]), metadata: {}),
        // Add more documents as needed
      ];
      collection.addDocuments(documents);

      // Perform a search
      var query = Float64List.fromList([0.5, 0.5]); // Define a query that matches your test case
      var searchResults = collection.search(query);

      // Assert: Check if the search results are as expected
      // This will depend on how your search logic is implemented
      expect(searchResults, isNotEmpty);
      // Additional checks based on expected results
    });

    test('load loads documents', () async {
      // Setup: Create a test file with predefined content
      var testFile = File('./test_collection.json');
      await testFile.writeAsString('${jsonEncode({
        'id': '1', 
        'text': 'Test Document', 
        'embedding': [1.0, 2.0], 
        'metadata': {'key': 'value'}
      })}\n');

      // Load documents
      collection.load();

      // Assert: Check if documents are loaded correctly
      expect(collection.documents, isNotEmpty);
      expect(collection.documents.containsKey('1'), isTrue);

      // Clean up: Delete the test file
      await testFile.delete();
    });


    test('clear clears all documents', () {
      collection.clear();
      expect(collection.documents.isEmpty, isTrue);
    });
  });
}
