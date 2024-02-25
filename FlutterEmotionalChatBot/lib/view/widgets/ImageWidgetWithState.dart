import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


class ImageWithStates extends StatefulWidget {
  final String _imagePath;

  ImageWithStates(this._imagePath);

  @override
  _ImageWithStates createState() => _ImageWithStates();
}

 class _ImageWithStates extends State<ImageWithStates> {
  Future<String> _fetchImageUrl() async {
    final ref = FirebaseStorage.instance.ref().child(widget._imagePath);
    return await ref.getDownloadURL();
  }

   @override
   Widget build(BuildContext context) {
     return FutureBuilder<String>(future: _fetchImageUrl(), builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
       if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error loading image');
        } else {
          return Image.network(snapshot.data!);
        }
     });
   }
 }