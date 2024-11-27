import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRScannerScreen(),
    );
  }
}

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  // Store scanned QR data and timestamps
  final List<Map<String, dynamic>> scannedDataList = [];

  /// Open the QR scanner
  void _startQRScanner() async {
    final String? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScannerPage(),
      ),
    );

    if (result != null) {
      setState(() {
        scannedDataList.add({
          'data': result,
          'dateTime': DateTime.now(),
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: _startQRScanner,
          ),
        ],
      ),
      body: scannedDataList.isEmpty
          ? const Center(
              child: Text(
                'No data',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
              itemCount: scannedDataList.length,
              itemBuilder: (context, index) {
                final scan = scannedDataList[index];
                return Card(
                  margin: const EdgeInsets.all(16.0),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Scanned Data:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          scan['data'],
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Scanned On: ${DateFormat.yMMMd().add_jm().format(scan['dateTime'])}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool isScanCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) {
          if (!isScanCompleted) {
            isScanCompleted = true;
            final String? code = capture.barcodes.first.rawValue;

            if (code != null) {
              Navigator.pop(context, code);
            } else {
              isScanCompleted = false;
            }
          }
        },
      ),
    );
  }
}
