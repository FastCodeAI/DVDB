import 'dart:math';

class MathFunctions {
  static double cosineSimilarity(List<double> a, List<double> b, double magnitudeA, double magnitudeB) {
    final double dotProduct = _dotProduct(a, b);
    return dotProduct / (magnitudeA * magnitudeB);
  }

  static double euclideanDistance(List<double> a, List<double> b) {
    final List<double> differences = _elementWiseSubtract(a, b);
    final List<double> squaredDifferences = _elementWiseSquare(differences);
    final double sumOfSquaredDifferences = squaredDifferences.reduce((double sum, double element) => sum + element);
    return sqrt(sumOfSquaredDifferences);
  }

  static List<double> _elementWiseSubtract(List<double> a, List<double> b) {
    final List<double> result = List<double>.generate(a.length, (int index) => a[index] - b[index]);
    return result;
  }

  static List<double> _elementWiseSquare(List<double> a) {
    final List<double> result = List<double>.generate(a.length, (int index) => a[index] * a[index]);
    return result;
  }

  static double _dotProduct(List<double> a, List<double> b) {
    double result = 0.0;
    for (int i = 0; i < a.length; i++) {
      result += a[i] * b[i];
    }
    return result;
  }
}
