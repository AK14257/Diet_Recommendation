import 'package:flutter/material.dart';
import 'package:ubereats/utils/textStyles.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Basket Screen',
          style: AppTextStyles.body16Bold,
        ),
      ),
    );
  }
}
