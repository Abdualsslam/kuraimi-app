
// class MockAuthService {
//   static final LocalAuthentication _auth = LocalAuthentication();

//   // محاكاة تسجيل الدخول (تبقى كما كانت)
//   static Future<bool> loginWithCredentials(String userId, String password) async {
//     await Future.delayed(const Duration(seconds: 2));
//     return userId.isNotEmpty && password.isNotEmpty;
//   }

//   // تحقق من توفر البصمة أو المستشعرات البيومترية على الجهاز
//   static Future<bool> isBiometricAvailable() async {
//     try {
//       final bool canCheck = await _auth.canCheckBiometrics;
//       final bool isSupported = await _auth.isDeviceSupported();
//       if (!canCheck || !isSupported) return false;
//       final List<BiometricType> available = await _auth.getAvailableBiometrics();
//       return available.isNotEmpty;
//     } catch (e) {
//       // ignore: avoid_print
//       print('isBiometricAvailable error: $e');
//       return false;
//     }
//   }

//   // اطلب المصادقة البيومترية من النظام
//   static Future<bool> loginWithBiometric({String? localizedReason}) async {
//     // Demo shortcut: in debug mode, simulate successful biometric authentication
//     if (kDebugMode) {
//       await Future.delayed(const Duration(milliseconds: 300));
//       // ignore: avoid_print
//       print('MockAuthService: debug mode - biometric authentication simulated success');
//       return true;
//     }
//     try {
//       final adapter = BiometricSignatureAdapter();

//       final available = await adapter.available();
//       if (available == null || available.startsWith('none,')) {
//         return false;
//       }

//       // Ensure keys exist (creates if missing)
//       final pub = await adapter.ensureKeys(useDeviceCredentials: true);
//       if (pub == null) return false;

//       // Create a signature for a demo payload and perform local simulated verification
//       final payload = 'demo-payload';
//       final sig = await adapter.createSignature(payload: payload, promptMessage: localizedReason ?? 'Authenticate');
//       if (sig == null) return false;

//       // For demo, verify locally using the generated public key
//       final publicKey = await adapter.ensureKeys(useDeviceCredentials: true);
//       if (publicKey == null) return false;

//       final verified = await adapter.verifySignatureLocally(publicKeyBase64: publicKey, payload: payload, signatureBase64: sig);
//       return verified;
//     } catch (e) {
//       // ignore: avoid_print
//       print('loginWithBiometric error: $e');
//       return false;
//     }
//   }
// }

class MockDataService {
  // بيانات وهمية للعرض
  static const Map<String, dynamic> mockUserData = {
    'name': 'عبدالسلام',
    'accountNumber': '1234567890',
    'balance': 15750.50,
    'accountType': 'حساب جاري',
  };

  static const List<Map<String, dynamic>> mockTransactions = [
    {'id': '1', 'type': 'إيداع', 'amount': 1500.0, 'date': '2024-01-15', 'description': 'إيداع نقدي'},
    {'id': '2', 'type': 'سحب', 'amount': -500.0, 'date': '2024-01-14', 'description': 'سحب من الصراف'},
    {'id': '3', 'type': 'تحويل', 'amount': -250.0, 'date': '2024-01-13', 'description': 'تحويل لحساب آخر'},
  ];

  // محاكاة جلب البيانات
  static Future<Map<String, dynamic>> getUserData() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockUserData;
  }

  static Future<List<Map<String, dynamic>>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return mockTransactions;
  }
}

class MockAuthService {
  static Future<bool> loginWithCredentials(String userId, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return userId.isNotEmpty && password.isNotEmpty;
  }

  static Future<bool> isBiometricAvailable() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  static Future<bool> loginWithBiometric({String? localizedReason}) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}
