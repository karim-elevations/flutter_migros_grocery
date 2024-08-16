import 'package:flutter/material.dart';
import '/models/product_model.dart';
import '/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ModifyDeleteProductSheet extends StatefulWidget {
  final ProductModel product;

  ModifyDeleteProductSheet({required this.product});

  @override
  _ModifyDeleteProductSheetState createState() => _ModifyDeleteProductSheetState();
}

class _ModifyDeleteProductSheetState extends State<ModifyDeleteProductSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late double _price;
  late String _brand;

  @override
  void initState() {
    super.initState();
    _name = widget.product.name;
    _description = widget.product.description;
    _price = widget.product.price;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _name,
              decoration: InputDecoration(labelText: 'Product Name'),
              onSaved: (value) {
                _name = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product name';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _description,
              decoration: InputDecoration(labelText: 'Product Description'),
              onSaved: (value) {
                _description = value!;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product description';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: _price.toString(),
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
              onSaved: (value) {
                _price = double.parse(value!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a product price';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  // Update the product in the database
                  final productProvider = context.read<ProductProvider>();
                  await productProvider.updateProduct(
                    name: _name,
                    brand: _brand,
                    price: _price,
                    description: _description,
                  );

                  Navigator.pop(context); // Close the sheet
                }
              },
              child: Text('Update Product'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                // Delete the product from the database
                final productProvider = context.read<ProductProvider>();
                await productProvider.deleteProduct(widget.product.id.toString());

                Navigator.pop(context); // Close the sheet
              },
              child: Text('Delete Product'),
              
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
               // Debugging
                print('Product ID: ${widget.product.id}');
                print('Product Name: $_name');
                print('Product Description: $_description');
                print('Product Price: $_price');
              },
              child: Text('debug'),
            ),
          ],
        ),
      ),
    );
  }
}
