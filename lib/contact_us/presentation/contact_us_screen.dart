import 'package:flutter/material.dart';
class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Get in touch with us!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}