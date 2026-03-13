import 'package:mobile_scanner/mobile_scanner.dart';

class CameraService {
  final MobileScannerController controller = MobileScannerController();

  Future<void> dispose() async {
    controller.dispose();
  }
}


