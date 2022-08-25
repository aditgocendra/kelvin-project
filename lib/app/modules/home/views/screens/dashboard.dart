import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../../globals/constant.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    double aspectRatio = screenSize / 2021;
    int axisCount = 3;

    if (screenSize < 1280) {
      // Medium
      aspectRatio = screenSize / 1347;
      axisCount = 2;
    }

    if (screenSize < 700) {
      // Medium
      aspectRatio = screenSize / 580;
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
                    ListView(
                      primary: false,
                      shrinkWrap: true,
                      children: const [
                        ItemProductList(
                          title: '3 Seconds Bundle',
                          index: 1,
                          subtitle: 'Rp. 30.000',
                          trailing: 'Terjual (22)',
                        ),
                        ItemProductList(
                          title: 'Baju Daster',
                          index: 2,
                          subtitle: 'Rp. 130.000',
                          trailing: 'Terjual (22)',
                        ),
                        ItemProductList(
                          title: 'Penting Original',
                          index: 3,
                          subtitle: 'Rp. 125.000',
                          trailing: 'Terjual (20)',
                        ),
                        ItemProductList(
                          title: 'Black Original',
                          index: 4,
                          subtitle: 'Rp. 170.000',
                          trailing: 'Terjual (31)',
                        ),
                      ],
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
                  children: const [
                    // Header
                    ListTile(
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
                    ItemProductList(
                      title: 'Baju Daster Original',
                      index: 1,
                      subtitle: 'Rp. 30.000',
                      trailing: 'Stok (130)',
                    ),
                    ItemProductList(
                      title: 'Baju Tidur',
                      index: 2,
                      subtitle: 'Rp. 30.000',
                      trailing: 'Stok (120)',
                    ),
                    ItemProductList(
                      title: 'Baju Daster Original',
                      index: 3,
                      subtitle: 'Rp. 30.000',
                      trailing: 'Stok (146)',
                    ),
                    ItemProductList(
                      title: 'Baju Ibu Ibu',
                      index: 4,
                      subtitle: 'Rp. 30.000',
                      trailing: 'Stok (146)',
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
                  children: const [
                    // Header
                    ListTile(
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
                    ItemProductList(
                      title: 'Baju Daster Original',
                      index: 1,
                      subtitle: 'Rp. 30.000',
                      trailing: 'Tersedia',
                    ),
                    ItemProductList(
                      title: 'Timoty X Kernel',
                      index: 2,
                      subtitle: 'Rp. 130.000',
                      trailing: 'Tersedia',
                    ),
                    ItemProductList(
                      title: 'Timoty X Kernel',
                      index: 3,
                      subtitle: 'Rp. 130.000',
                      trailing: 'Tersedia',
                    ),
                    ItemProductList(
                      title: 'Baju Anak 3D Design',
                      index: 4,
                      subtitle: 'Rp. 130.000',
                      trailing: 'Tersedia',
                    ),
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

    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: 4,
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
                          listDashboardMenu[index]['title'],
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          listDashboardMenu[index]['value'],
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
                        listDashboardMenu[index]['icon'],
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Terakhir diupdate : 23 Mar 2022',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black38,
                ),
              ),
            ],
          ),
        );
      },
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
