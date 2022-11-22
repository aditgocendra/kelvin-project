class Month {
  String nameMonth;
  int month;

  Month({
    required this.nameMonth,
    required this.month,
  });

  String AsString() {
    return nameMonth;
  }

  bool isEqual(Month model) {
    return month == model.month;
  }
}

final monthData = [
  Month(nameMonth: 'Januari', month: 1),
  Month(nameMonth: 'Februari', month: 2),
  Month(nameMonth: 'Maret', month: 3),
  Month(nameMonth: 'April', month: 4),
  Month(nameMonth: 'Mei', month: 5),
  Month(nameMonth: 'Juni', month: 6),
  Month(nameMonth: 'Juli', month: 7),
  Month(nameMonth: 'Agustus', month: 8),
  Month(nameMonth: 'September', month: 9),
  Month(nameMonth: 'Oktober', month: 10),
  Month(nameMonth: 'November', month: 11),
  Month(nameMonth: 'Desember', month: 12),
];
