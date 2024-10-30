import 'package:flutter/material.dart';

class HomeController extends ChangeNotifier {
  String? selectedItem;
  String selectedExchangeDirection = 'kyatToBaht';
  TextEditingController amountController = TextEditingController();
  int amount = 0;
  double calculatedResult = 0.0;

  Map<String, Map<String, double>> itemPrices = {
    "ဒေါ်လာ": {"buy": 4580, "sell": 4680},
    "ဘတ်": {"buy": 133.51, "sell": 136.99},
    "စင်္ကာပူ": {"buy": 3390, "sell": 3480},
  };

  void calculateResult() {
    if (selectedItem != null && selectedExchangeDirection != null) {
      if (selectedExchangeDirection == 'kyatTo${selectedItem?.toLowerCase()}') {
        calculatedResult = amount / itemPrices[selectedItem]!['buy']!;
      } else if (selectedExchangeDirection ==
          '${selectedItem?.toLowerCase()}ToKyat') {
        calculatedResult = amount * itemPrices[selectedItem]!['sell']!;
      }
    } else {
      calculatedResult = 0.0;
    }
    notifyListeners();
  }

  void updateSelectedItem(String? newItem) {
    selectedItem = newItem;
    selectedExchangeDirection = '';
    calculateResult();
  }

  void updateExchangeDirection(String newDirection) {
    selectedExchangeDirection = newDirection;
    calculateResult();
  }

  void updateAmount(String value) {
    amount = int.tryParse(value) ?? 0;
    calculateResult();
  }
}
