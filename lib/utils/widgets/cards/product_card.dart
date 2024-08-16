// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  final String imagePath;
  final String brand;
  final String name;
  final String description;
  final double price;
  final String measurement;
  final double pricePerUnit;

  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.brand,
    required this.name,
    required this.description,
    required this.price,
    required this.measurement,
    required this.pricePerUnit,
  }) : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: Color(0xFFEE4F4E), width: 1.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // First column: Image
          Expanded(
            flex: 2,
            child: Image.network(
              widget.imagePath,
              fit: BoxFit.contain,
              height: 100,
            ),
          ),
          // Second column: Product details
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(19.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${widget.brand} - ${widget.name}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.description,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 35.0),
                  Text('\CHF ${widget.price.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                      '${widget.pricePerUnit.toStringAsFixed(2)} per ${widget.measurement}'),
                ],
              ),
            ),
          ),
          // Third column: Quantity controls
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Color(0xFF1A0502).withOpacity(0.4),
                        width: 4.5),
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                color: Color(0xFFFFE6E6),
                child: Text(
                  '$quantity',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Color(0xFFEE4F4E), width: 4.5)),
                ),
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (quantity > 0)
                        quantity--;
                      //else show snackbar
                      else
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            content: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFFEE4F4E),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                'La quantité ne peut pas être inférieur à 0',
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
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
