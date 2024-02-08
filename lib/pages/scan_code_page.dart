import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
            child: const Text('Scan QR Code',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/generate");
            },
            icon: const Icon(
              Icons.qr_code,
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "/land");
            },
            icon: const Icon(
              Icons.arrow_back,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            )),
        margin: EdgeInsets.only(top: 140.0, left: 40, right: 40, bottom: 140),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.teal,
                    border: Border.all(color: Colors.teal, width: 6.0),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                width: 300,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: MobileScanner(
                    controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.noDuplicates,
                      returnImage: true,
                    ),
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      final Uint8List? image = capture.image;
                      for (final barcode in barcodes) {
                        print('Barcode Found ${barcode.rawValue}');
                      }
                      if (image != null) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  barcodes.first.rawValue ?? "",
                                ),
                                content: Image(
                                  image: MemoryImage(image),
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
              ),
              Text(
                'You Can Scan The QR Here.',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.teal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
