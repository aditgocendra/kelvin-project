import 'package:flutter/material.dart';
import 'package:kelvin_project/app/globals/constant.dart';
import 'package:unicons/unicons.dart';

class SearchProduct extends StatelessWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Text(
            'Pencarian Produk',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ProductResultItem(
                productName: '3 Seconds Bundle',
                price: 'Rp. 60.000',
                idProduct: 'asdasd',
              ),
              ProductResultItem(
                productName: 'Baju Tidur Anak',
                price: 'Rp. 60.000',
                idProduct: 'asdasd',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProductResultItem extends StatelessWidget {
  final productName;
  final price;
  final idProduct;

  ProductResultItem({
    required this.productName,
    required this.price,
    required this.idProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: ListTile(
        title: Text(
          productName,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: Text(
          price,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: const Icon(
                    UniconsLine.eye,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
