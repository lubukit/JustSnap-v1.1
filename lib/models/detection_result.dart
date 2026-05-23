class DetectionResult {
  const DetectionResult({
    required this.label,
    required this.confidence,
    required this.suggestedBag,
  });

  final String label;
  final double confidence;
  final String suggestedBag;
}
