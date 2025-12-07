class HomeDataCache {
  static bool initialized = false;
  static Map<String, dynamic>? userData;
  static List<Map<String, dynamic>>? transactions;

  static void setData({required Map<String, dynamic> user, required List<Map<String, dynamic>> txs}) {
    userData = user;
    transactions = txs;
    initialized = true;
  }

  static void clear() {
    initialized = false;
    userData = null;
    transactions = null;
  }
}
