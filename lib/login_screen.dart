import 'package:flutter/material.dart';
import 'nfc_reader_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  String _errorText = '';

  void _onLoginPressed() {
    String enteredId = _idController.text.trim();
    if (enteredId == '1111') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NfcReaderScreen()),
      );
    } else {
      setState(() {
        _errorText = 'Неверный ID. Попробуйте еще раз.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Введите ID терминала',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID терминала',
                errorText: _errorText.isNotEmpty ? _errorText : null,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onLoginPressed,
              child: Text('Войти'),
            ),
          ],
        ),
      ),
    );
  }
}