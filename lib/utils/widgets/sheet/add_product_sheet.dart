// file add_product_sheet.dart
import 'package:flutter/material.dart';
import 'package:migros_small_app_debug/provider/user_provider.dart';
import '/models/product_model.dart';
import 'package:migros_small_app_debug/provider/product_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddProductSheet extends StatefulWidget {
  const AddProductSheet({super.key});

  @override
  State<AddProductSheet> createState() => _AddProductSheetState();
}

class _AddProductSheetState extends State<AddProductSheet> {
  //
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nom du produit'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrez le nom du produit';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _brandController,
              decoration: InputDecoration(labelText: 'Marque du produit'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entre la marque du produit';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Prix du produit'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Entrez le prix du produit';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    height: 150,
                  )
                : ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Choisir une image'),
                  ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    _selectedImage != null) {
                  final product = ProductModel(
                     // Generate a unique ID
                    createdAt: DateTime.now(),
                    name: _nameController.text,
                    brand: _brandController.text,
                    description: _descriptionController.text,
                    price: double.parse(_priceController.text),
                    image_path: '', // Will be updated in the provider
                  );

                  await context
                      .read<ProductProvider>()
                      .addProduct(product, _selectedImage!);

                  // Navigate to another screen or show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            content: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'Produit ajouté avec succès',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                  Navigator.pop(context);
                } else {
                  // Handle validation errors or missing image with snackbars
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Veuillez remplir tous les champs'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text('Ajouter le produit'),
            ),
          ],
        ),
      ),
    );
  }
}
