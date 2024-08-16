// file lib/provider/product_provider.dart
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../provider/user_provider.dart';
import 'dart:io';

class ProductProvider with ChangeNotifier {
  ProductModel? _product;
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  final SupabaseClient _supabaseClient = Supabase.instance.client;

  Future<void> fetchProducts() async {
    final response = await _supabaseClient.from('products').select();

    if (response.isNotEmpty) {
      _products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      debugPrint('response : $response');
      debugPrint('Products : $_products');

      notifyListeners();
    }
  }

  Future<void> addProduct(ProductModel product, File imageFile) async {
    try {
      // Upload image to Supabase Storage
      final user = _supabaseClient.auth.currentUser;
      if (user == null) {
        throw Exception('User is not authenticated');
      }
      final imageUploadResponse = await _supabaseClient.storage
          .from('product-images-bucket')
          .upload('public/${product.id}/${imageFile.path.split('/').last}',
              imageFile);

      final imagePath = _supabaseClient.storage
          .from('product-images-bucket')
          .getPublicUrl(
              'public/${product.id}/${imageFile.path.split('/').last}');

      final updatedProduct = ProductModel(
        createdAt: DateTime.now(),
        name: product.name,
        brand: product.brand,
        description: product.description,
        price: product.price,
        image_path: imagePath,
      );

      await _supabaseClient.from('products').insert({
        'created_at': updatedProduct.createdAt.toIso8601String(),
        'name': updatedProduct.name,
        'brand': updatedProduct.brand,
        'description': updatedProduct.description,
        'price': updatedProduct.price,
        'image_path': updatedProduct.image_path,
      });

      notifyListeners();
    } catch (error) {
      print('Failed to add product: $error');
      rethrow;
    }
  }

//Fetch product
  Future<void> fetchProduct(String productId) async {
    final response = await _supabaseClient
        .from('products')
        .select()
        .eq('id', productId)
        .single();

    if (response != null) {
      _product = ProductModel.fromJson(response);
      notifyListeners();
    }
  }

  ProductModel? get product => _product;

  Future<void> updateProduct({
    String? name,
    String? brand,
    String? description,
    double? price,
  }) async {
    try {
      await _supabaseClient.from('products').update({
        'name': product!.name,
        'brand': product!.brand,
        'description': product!.description,
        'price': product!.price,
      }).eq('id', product!.id!);

      notifyListeners();
    } catch (error) {
      print('Failed to update product: $error');
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _supabaseClient.from('products').delete().eq('id', productId);
      notifyListeners();
    } catch (error) {
      print('Failed to delete product: $error');
      rethrow;
    }
  }

  //fetch all products
  Future<void> fetchAllProducts(BuildContext context) async {
    try {
      final response = await _supabaseClient
          .from('products')
          .select()
          .order('created_at', ascending: false);

      // Handle the error if any
      if (response == null) {
        throw Exception('Failed to fetch products data');
      }

      _products = (response as List)
          .map((productData) => ProductModel.fromJson(productData))
          .toList();

      print(' response : $response');

      notifyListeners();
    } catch (error) {
      // Print the error to the console
      print('Error fetching products: $error');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur, impossible d\' afficher tous les produits.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
