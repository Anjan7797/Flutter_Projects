
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final MobileScannerController _controller = MobileScannerController();
  final ImagePicker _picker = ImagePicker();
  bool _isDialogOpen = false;
  bool _isFlashOn = false;
  final LinearGradient appBarGradient = const LinearGradient(
    colors: [
      Color(0xFFF8C1C3),
      Color(0xFFB2204B),
      Color(0xFF4B0B2C),
    ],
    stops: [0.2, 0.5, 0.8],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  final LinearGradient backgroundGradient = const LinearGradient(
    colors: [
      Color(0xFFF8C1C3),
      Color(0xFFB2204B),
      Color(0xFF4B0B2C),
    ],
    stops: [0.2, 0.6, 0.9],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  @override
  void initState() {
    super.initState();
    // Make status bar transparent and icons white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isDialogOpen) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;

      if (code != null) {
        _isDialogOpen = true;
        await _controller.stop();

        if (!mounted) return;

        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("QR Code Result"),
            content: Text(code),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Scan Again"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Done"),
              ),
            ],
          ),
        );

        _isDialogOpen = false;
        await _controller.start();
      }
    }
  }

  void _toggleFlash() {
    _controller.toggleTorch();
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  Future<void> _pickImageFromGallery() async {
    final permissionStatus = await Permission.photos.request();

    if (permissionStatus.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        try {
          final BarcodeCapture? result = await _controller.analyzeImage(image.path);
          if (result != null &&
              result.barcodes.isNotEmpty &&
              result.barcodes.first.rawValue != null) {
            _showBarcodeResult(result.barcodes.first.rawValue!);
          } else {
            _showBarcodeResult("No QR code found in the image.");
          }
        } catch (e) {
          _showBarcodeResult("Error reading image: $e");
        }
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission to access gallery denied')),
      );
    }
  }

  void _showBarcodeResult(String result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("QR Code Result"),
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(gradient: appBarGradient),
          child: AppBar(
            title: const Text('Scan QR Code'),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 15,
            iconTheme: const IconThemeData(color:Color(0xFF4B0B2C)),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QR Scanner Box
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: MobileScanner(
                  controller: _controller,
                  onDetect: _onDetect,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Flashlight + Gallery buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.flash_on_sharp,
                    color: _isFlashOn ? Colors.amber : Colors.white,
                  ),
                  onPressed: _toggleFlash,
                  tooltip: 'Flash On',
                  iconSize: 30,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(
                    Icons.flash_off_sharp,
                    color: !_isFlashOn ? Colors.amber : Colors.white,
                  ),
                  onPressed: _toggleFlash,
                  tooltip: 'Flash Off',
                  iconSize: 30,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.white),
                  onPressed: _pickImageFromGallery,
                  tooltip: 'Pick Image from Gallery',
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
