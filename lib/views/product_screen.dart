import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:migros_small_app_debug/utils/widgets/cards/product_card.dart';
import 'package:migros_small_app_debug/utils/widgets/indicator/custom_refresh_indicator.dart';
import 'package:migros_small_app_debug/utils/widgets/sheet/modify_delete_product_sheet.dart';
import '../utils/widgets/sheet/login_bottom_sheet.dart';
import '../utils/widgets/buttons/primary_button.dart';
import '../utils/widgets/custom_app_bar.dart';
import '../utils/widgets/cards/custom_gradient_card.dart';
import '../utils/widgets/sheet/add_product_sheet.dart';
import '../provider/user_provider.dart';
import '../provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final auth = UserAuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        rightSide: Container(
          alignment: Alignment.centerRight,
          width: 100,
          child: IconButton(
            onPressed: () async {
              await auth.signOut();
              GoRouter.of(context).go('/login');
            },
            icon: Icon(
              Icons.logout,
              size: 30.0,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Ajouter un produit', style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(children: [AddProductSheet()]);
            },
            isScrollControlled: true,
          );
        },
        backgroundColor: Colors.black,
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return CustomRefreshIndicator(
            backgroundColor: Colors.black,
            color: Colors.white,
            onRefresh: () async {
              await productProvider.fetchAllProducts(context);
            },
            child: ListView.builder(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return InkWell(
                  onLongPress: () => showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ModifyDeleteProductSheet(
                        product: product,
                      );
                    },
                  ),
                  child: ProductCard(
                    imagePath: product.image_path,
                    brand: product.brand,
                    name: product.name,
                    description: product.description,
                    price: product.price,
                    measurement: 'not available',
                    pricePerUnit: 0.00,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
