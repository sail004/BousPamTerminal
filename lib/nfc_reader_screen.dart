import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';

class NfcReaderScreen extends StatefulWidget {
  @override
  _NfcReaderScreenState createState() => _NfcReaderScreenState();
}

class _NfcReaderScreenState extends State<NfcReaderScreen> {
  String _nfcTagData = 'Waiting for NFC tag...';

  @override
  void initState() {
    super.initState();
    initNfc();
  }

  Future<void> initNfc() async {
    try {
      bool isAvailable = await NfcManager.instance.isAvailable();
      if (!isAvailable) {
        setState(() {
          _nfcTagData = 'NFC is not available on this device.';
        });
        return;
      }
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        setState(() {
          Ndef? ndef = Ndef.from(tag);
          final payload = tag.data['ndef']['cachedMessage']['records'][0]['payload'];
          final text = utf8.decode(payload.sublist(1));
          _nfcTagData = 'NFC Tag detected: ${text}';
        });
        NfcManager.instance.stopSession();
      });
    } catch (e) {
      setState(() {
        _nfcTagData = 'Error initializing NFC: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NFC Reader'),
      ),
      body: Center(
        child: Text(_nfcTagData),
      ),
    );
  }

  @override
  void dispose() {
    NfcManager.instance.stopSession();
    super.dispose();
  }
}
