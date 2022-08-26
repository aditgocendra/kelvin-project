class TransactionReport {
  String codeTransaction;
  String product;
  String variant;
  String price;
  String totalBuy;
  String dateTransaction;
  String totalPay;

  TransactionReport({
    required this.codeTransaction,
    required this.product,
    required this.variant,
    required this.price,
    required this.totalBuy,
    required this.dateTransaction,
    required this.totalPay,
  });

  String getIndex(int index) {
    switch (index) {
      case 0:
        return codeTransaction;
      case 1:
        return product;
      case 2:
        return variant;
      case 3:
        return price;
      case 4:
        return totalBuy;
      case 5:
        return dateTransaction;
      case 6:
        return totalPay;
      default:
        return '';
    }
  }
}

final transactionReport = [
  TransactionReport(
    codeTransaction: 'TR-NM-SR-2022-08-19-RASDSADAS',
    product: '3 Seconds Bundle\n--------\nBaju Tidur',
    variant: 'Merah | XL\nPink | M\n--------\niru | XL\n Kuning | L',
    price: 'Rp. 50.000',
    totalBuy: '4 Unit',
    dateTransaction: '27 Mar 2022',
    totalPay: 'Rp. 200.000',
  ),
];
