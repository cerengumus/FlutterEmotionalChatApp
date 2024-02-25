import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextWithFirebase extends StatefulWidget {
  final String _textPath;

  TextWithFirebase(this._textPath);

  @override
  _TextWithFirebase createState() => _TextWithFirebase();
}

class _TextWithFirebase extends State<TextWithFirebase> {
  Future<String> _fetchText() async {
    final docSnapshot = await FirebaseFirestore.instance.doc(widget._textPath)
        .get();
    return docSnapshot.data()!['text'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _fetchText(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return const Text('Error loading text');
          } else {
            return Text(snapshot.data!);
          }
        });
  }
}