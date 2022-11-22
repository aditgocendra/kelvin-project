import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kelvin_project/app/modules/home/controllers/dashboard_controller.dart';
import 'package:unicons/unicons.dart';

import '../../../../utils/constant.dart';

class Dashboard extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    double aspectRatio = screenSize / 2300; // X Large
    int axisCount = 3;

    if (screenSize < 1350) {
      // Large
      aspectRatio = screenSize / 1540;
      axisCount = 2;
    }

    if (screenSize < 1065) {
      // Medium
      aspectRatio = screenSize / 1320;
      axisCount = 2;
    }

    if (screenSize < 880) {
      // Small
      aspectRatio = screenSize / 700;
      axisCount = 1;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ItemHorizontalTop(
            screenSize: screenSize,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            shrinkWrap: true,
            primary: false,
            crossAxisCount: axisCount,
            childAspectRatio: aspectRatio,
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Produk Terlaris',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        UniconsLine.arrow_growth,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    GetBuilder(
                      init: dashboardController,
                      builder: (_) {
                        if (dashboardController.listSoldProduct.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Belum ada satupun produk.',
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }
                        return Column(
                          children: dashboardController.listSoldProduct
                              .asMap()
                              .map(
                                (index, value) => MapEntry(
                                  index,
                                  ItemProductList(
                                    title: value.productName,
                                    index: index + 1,
                                    subtitle: NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0,
                                    ).format(value.price),
                                    trailing:
                                        'Terjual (${value.sold.toString()})',
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        );
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Produk Stok',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        UniconsLine.layer_group,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    GetBuilder(
                      init: dashboardController,
                      builder: (_) {
                        if (dashboardController.listStockProduct.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Belum ada satupun produk.',
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }
                        return Column(
                          children: dashboardController.listStockProduct
                              .asMap()
                              .map(
                                (index, value) => MapEntry(
                                  index,
                                  ItemProductList(
                                    title: value.productName,
                                    index: index + 1,
                                    subtitle: NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0,
                                    ).format(value.price),
                                    // trailing: 'Stok (${value.allStock})',
                                    trailing: 'asdsada',
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        );
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Column(
                  children: [
                    // Header
                    const ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Produk Terbaru',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        UniconsLine.truck_loading,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    GetBuilder(
                      init: dashboardController,
                      builder: (_) {
                        if (dashboardController.listStockProduct.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Belum ada satupun produk.',
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        }
                        return Column(
                          children: dashboardController.listNewProduct
                              .asMap()
                              .map(
                                (index, value) => MapEntry(
                                  index,
                                  ItemProductList(
                                    title: value.productName,
                                    index: index + 1,
                                    subtitle: NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp. ',
                                      decimalDigits: 0,
                                    ).format(value.price),
                                    trailing: 'Tersedia',
                                  ),
                                ),
                              )
                              .values
                              .toList(),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class ItemHorizontalTop extends StatelessWidget {
  final dashboardController = Get.find<DashboardController>();
  double screenSize;

  ItemHorizontalTop({
    Key? key,
    required this.screenSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double aspectRatio = screenSize / 872;
    int axisCount = 4;

    if (screenSize < 950) {
      // Medium
      aspectRatio = screenSize / 380;
      axisCount = 2;
    }

    if (screenSize < 550) {
      // Medium
      aspectRatio = screenSize / 220;
      axisCount = 1;
    }

    return GetBuilder(
      init: dashboardController,
      builder: (_) => GridView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: dashboardController.listDashboardMenu.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: axisCount,
          childAspectRatio: aspectRatio,
        ),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dashboardController.listDashboardMenu[index]
                                ['title'],
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            dashboardController.listDashboardMenu[index]
                                    ['value']
                                .toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Icon(
                          dashboardController.listDashboardMenu[index]['icon'],
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Terakhir Diupdate : ${dashboardController.listDashboardMenu[index]['last_update']}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ItemProductList extends StatelessWidget {
  final title;
  final index;
  final subtitle;
  final trailing;

  const ItemProductList({
    Key? key,
    required this.title,
    required this.index,
    required this.subtitle,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: index == 1
            ? CircleAvatar(
                backgroundColor: primaryColor,
                child: Center(
                  child: Text(
                    index.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              )
            : CircleAvatar(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
          ),
        ),
        trailing: Text(
          trailing,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
