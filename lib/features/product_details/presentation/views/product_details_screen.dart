import 'package:eshop/config/routes/route_args.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDetailsScreenArgs args;
  const ProductDetailsScreen({
    super.key,
    required this.args,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
