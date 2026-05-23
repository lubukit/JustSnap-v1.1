import 'dart:async';

import '../models/detection_result.dart';

abstract class ObjectDetectionService {
  Future<List<DetectionResult>> detectObjects();
}

class MockObjectDetectionService implements ObjectDetectionService {
  const MockObjectDetectionService();

  @override
  Future<List<DetectionResult>> detectObjects() async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    return const [
      DetectionResult(label: 'Iphone 16 Pro Max', confidence: .98, suggestedBag: 'Beg Bagasi'),
      DetectionResult(label: 'Power bank', confidence: .94, suggestedBag: 'Beg sandang'),
      DetectionResult(label: 'Wallet', confidence: .96, suggestedBag: 'Beg Tangan'),
    ];
  }
}
