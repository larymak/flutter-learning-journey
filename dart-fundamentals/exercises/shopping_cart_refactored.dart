int calculateCartTotal(List<int> prices) {
  int total = 0;
  for (final price in prices) {
    total += price;
  }
  return total;
}

int countExpensiveItems(List<int> prices) {
  int count = 0;
  for (final price in prices) {
    if (price >= 1000) {
      count++;
    }
  }
  return count;
}

void printCartReport(List<int> prices) {
  print('=== SHOPPING CART REPORT ===');
  for (int i = 0; i < prices.length; i++) {
    final price = prices[i];
    print('Item ${i + 1}: KES $price');
  }
  final cartTotal = calculateCartTotal(prices);
  final expensiveCount = countExpensiveItems(prices);
  print('');
  print('Total shopping cost: KES $cartTotal');
  print('Expensive items: $expensiveCount');
  print('============================');
}

void main() {
  final prices = [500, 1200, 300, 2500, 800];
  printCartReport(prices);
}
