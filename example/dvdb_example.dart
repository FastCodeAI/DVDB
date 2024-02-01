import 'dart:typed_data';

import 'package:dvdb/dvdb.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String openaiApiKey = 'sk-your_api_key'; // Replace with your OpenAI API key
const String openaiUrl = 'https://api.openai.com/v1/embeddings';

void main() async {
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openaiApiKey'
  };

  var collection = DVDB().collection("Test");
   
  var texts = ['cat', 'dog', 'lion'];

  for (var text in texts) {
    try {
      var requestBody = jsonEncode({
        'input': text,
        'model': 'text-embedding-ada-002'
      });

      var response = await http.post(Uri.parse(openaiUrl), headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        Float64List embedding = jsonResponse['data'][0]['embedding'];
        print('Response from OpenAI: ${embedding.runtimeType}');
        collection.addDocument(null, text, embedding);
      } 
      else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response body: ${response.body}');
      }
    } 
    catch(e) {
      print('An error occurred: $e');
    }
  }

  try {
    var requestBody = jsonEncode({
      'input': 'tiger',
      'model': 'text-embedding-ada-002'
    });

    var response = await http.post(Uri.parse(openaiUrl), headers: headers, body: requestBody);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Float64List embedding = jsonResponse['data'][0]['embedding'];

      final query = collection.search(embedding, numResults: 1);

      query.forEach((element) {
      
        print("${element.score} || ${element.text}");
      });
    }
    else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
    }
  }
  catch(e){
    print(e);
  }
}
