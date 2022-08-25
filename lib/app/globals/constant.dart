import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

const primaryColor = Color.fromARGB(255, 244, 51, 238);
const secondaryColor = Color.fromARGB(255, 238, 103, 233);
const canvasColor = Colors.white;

const List<Map<String, dynamic>> listNavItem = [
  {'title': 'Dashboard', 'icon': UniconsLine.dashboard},
  {'title': 'Produk', 'icon': UniconsLine.archive_alt},
  {'title': 'Kategori', 'icon': UniconsLine.clipboard_notes},
  {'title': 'Transaksi', 'icon': UniconsLine.transaction},
  {'title': 'Pengguna', 'icon': UniconsLine.users_alt},
  {'title': 'Keluar', 'icon': UniconsLine.sign_out_alt}
];

const List<Map<String, dynamic>> listDashboardMenu = [
  {
    'title': 'Total Produk',
    'icon': UniconsLine.archive_alt,
    'value': '84',
  },
  {
    'title': 'Total Kategori',
    'icon': UniconsLine.clipboard_notes,
    'value': '4'
  },
  {
    'title': 'Total Pengguna',
    'icon': UniconsLine.users_alt,
    'value': '3',
  },
  {
    'title': 'Total Transaksi',
    'icon': UniconsLine.transaction,
    'value': '1024',
  }
];
