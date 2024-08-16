import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';


class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
 final ImagePicker _picker = ImagePicker();
  String? _uploadedFileUrl;

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final file = File(image.path);
    final fileName = image.name;

    final response = await Supabase.instance.client
        .storage
        .from('product-images-bucket') // Replace with your bucket name
        .upload(fileName, file);


    final publicUrl = Supabase.instance.client.storage
        .from('product-images-bucket')
        .getPublicUrl(fileName);

    setState(() {
      _uploadedFileUrl = publicUrl;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Upload successful!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
            if (_uploadedFileUrl != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(_uploadedFileUrl!),
              ),
          ],
        ),
      ),
    );
  }
}