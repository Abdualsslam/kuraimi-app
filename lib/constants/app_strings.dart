// Placeholder content

import 'package:flutter/widgets.dart';

class AppStrings {
  final String _locale;
  AppStrings._(this._locale);

  static AppStrings of(BuildContext context) {
    try {
      final code = Localizations.localeOf(context).languageCode;
      return AppStrings._(code);
    } catch (_) {
      final code = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
      return AppStrings._(code);
    }
  }

  static const Map<String, Map<String, String>> _localized = {
    'ar': {
      'appTitle': 'بنك الكريمي',
      'bankName': 'بنك الكريمي للتمويل الأصغر الإسلامي',
      'bankNameEn': 'ALKURAIMI ISLAMIC MICROFINANCE BANK',
      'welcomeTitle': 'تسوّق من كل العالم عبر بطاقة إيدي',
      'welcomeSubtitle': 'استمتع بالتسوق الآمن والمريح',
      'userIdLabel': 'رقم المميز',
      'userIdHint': 'ادخل رقم المميز',
      'passwordLabel': 'كلمة المرور',
      'passwordHint': 'ادخل كلمة المرور',
      'loginButton': 'تسجيل دخول',
      'biometricLogin': 'دخول باستخدام البصمة',
      'forgotPassword': 'نسيت كلمة المرور؟!',
      'offlineLogin': 'الدخول بدون إنترنت',
      'loginSuccess': 'تم تسجيل الدخول بنجاح',
      'loginError': 'خطأ في بيانات تسجيل الدخول',
      'biometricFallback': 'استخدم كلمة المرور',
      'userIdRequired': 'يرجى إدخال رقم المميز',
      'passwordRequired': 'يرجى إدخال كلمة المرور',
      'supportComputer': 'الدفع عبر حاسب',
      'whatsapp': 'تواصل معنا!',
      'rateApp': 'تقييم التطبيق',
      'version': 'الإصدار V1.6.344',
      'forgotPasswordContent': 'يرجى التواصل مع خدمة العملاء لإعادة تعيين كلمة المرور الخاصة بك.',
      'close': 'إغلاق',
      'contactSupport': 'اتصال بالدعم',
      'offlineLoginTitle': 'الدخول بدون إنترنت',
      'offlineLoginContent': 'يمكنك الدخول بدون اتصال إنترنت باستخدام آخر بيانات محفوظة على الجهاز.',
      'cancel': 'إلغاء',
      'supportTitle': 'الدعم الفني',
      'contactMethodsText': 'يمكنك التواصل معنا عبر:',
      'phoneLabel': 'الهاتف: 800-123-456',
      'emailLabel': 'البريد: support@alkuraimi.com',
      'chatLabel': 'الدردشة المباشرة',
      'moreOptionsTitle': 'خيارات إضافية',
      'changeLanguage': 'تغيير اللغة',
      'securitySettings': 'إعدادات الأمان',
      'aboutApp': 'حول التطبيق',
      'aboutBankLine1': 'بنك الكريمي للتمويل الأصغر الإسلامي',
      'aboutBankLine2': 'تطبيق آمن ومريح للخدمات المصرفية',
      'callingCustomerService': 'جاري الاتصال بخدمة العملاء...',
      'attemptingOfflineLogin': 'جاري المحاولة للدخول بدون إنترنت...',
      'rateAppSnackbar': 'شكراً لك! تم فتح صفحة التقييم',
      'biometricPrompt': 'سجّل دخولك باستخدام البصمة',
      'biometricFailed': 'فشل التحقق بالبصمة. حاول مرة أخرى أو استخدم كلمة المرور',
      'userIdTooShort': 'رقم المميز يجب أن يكون أكثر من 3 أرقام',
      'passwordTooShort': 'كلمة المرور يجب أن تكون أكثر من 4 أحرف',
      'phoneRequired': 'يرجى إدخال رقم الهاتف',
      'phoneInvalid': 'رقم الهاتف غير صحيح',
      'emailRequired': 'يرجى إدخال البريد الإلكتروني',
      'emailInvalid': 'البريد الإلكتروني غير صحيح',
      'more': 'المزيد',

      // New navigation labels
      'navHome': 'الرئيسية',
      'navTransactions': 'المعاملات',
      'navServices': 'الخدمات',
      'navSettings': 'الإعدادات',
      'navProfile': 'بياناتي',
      // Theme dialog
      'themeTitle': 'اختيار الثيم',
      'themeLightTitle': 'الوضع الفاتح',
      'themeLightSubtitle': 'خلفية فاتحة ونص داكن',
      'themeDarkTitle': 'الوضع الداكن',
      'themeDarkSubtitle': 'خلفية داكنة ونص فاتح',
      'themeSystemTitle': 'وضع النظام',
      'themeSystemSubtitle': 'يتبع إعدادات الجهاز',
      // Greetings
      'hello': 'مرحباً،',
      'welcomeToBank': 'أهلاً بك في بنك الكريمي',
      // Balance/actions
      'availableBalance': 'الرصيد المتاح',
      'transfer': 'تحويل',
      'deposit': 'إيداع',
      'currencySuffix': 'ريال',
      // Transaction list
      'recentTransactions': 'المعاملات الأخيرة',
      'allTransactions': 'جميع المعاملات',
      'seeAll': 'عرض الكل',
      'transaction': 'معاملة',
      // Account info
      'accountNumberLabel': 'رقم الحساب:',
      'qrCode': 'رمز QR',
      // Services
      'svcAccounts': 'الحسابات',
      'svcTransfer': 'تحويل',
      'svcPayBills': 'دفع فواتير',
      'svcTopUp': 'شحن رصيد',
      'svcCards': 'بطاقات',
      'svcQRCode': 'QR كود',
      'svcBranches': 'الفروع',
      'svcSupport': 'الدعم',
      // Settings
      'stProfile': 'الملف الشخصي',
      'stSecurity': 'الأمان والحماية',
      'stNotifications': 'الإشعارات',
      'stLanguage': 'اللغة',
      'stSupport': 'الدعم والمساعدة',
      'stAbout': 'حول التطبيق',
      'theme': 'السمة',
      'language': 'اللغة',
      'aboutUs': 'حول التطبيق',
      'aboutUsContent': 'هذا تطبيق بنك الكريمي للخدمات المصرفية.',
      // Quick actions
      'quickActionsTitle': 'الإجراءات السريعة',
      'quickInstantTransfer': 'تحويل فوري',
      'quickBillPayment': 'دفع الفواتير',
      'quickTopUp': 'شحن الرصيد',
      'quickStatement': 'كشف الحساب',
      // Common
      'transactions': 'المعاملات',
      'services': 'الخدمات',
      'settings': 'الإعدادات',
      'loadingData': 'جاري تحميل البيانات...',
      'errorTitle': 'خطأ',
      'retry': 'حاول مرة أخرى',
      'notificationsTitle': 'الإشعارات',
      // Languages
      'arabicLanguage': 'العربية',
      'englishLanguage': 'English',
      // Profile Screen
      'personalInfo': 'بياناتي الشخصية',
      'goldenMember': 'حرااف',
      'accountInfo': 'معلومات الحساب',
      'accountNumber': 'رقم الحساب',
      'cardNumber': 'رقم البطاقة',
      'accountStatus': 'حالة الحساب',
      'accountActive': 'مفعل ✓',
      'joiningDate': 'تاريخ الانضمام',
      'contactInfo': 'معلومات الاتصال',
      'phoneNumber': 'رقم الهاتف',
      'email': 'البريد الإلكتروني',
      'address': 'العنوان',
      'quickServices': 'خدمات سريعة',
      'accountStatement': 'كشف الحساب',
      'technicalSupport': 'الدعم الفني',
      'security': 'الأمان',
      // Exchange Rates
      'exchangeRates': 'أسعار الصرف',
      'currency': 'العملة',
      'sell': 'بيع',
      'buy': 'شراء',
      'usd': 'دولار أمريكي',
      'sar': 'ريال سعودي',
      'euro': 'يورو',
      'gold': 'ذهب',
      // Services Screen
      'servicesTitle': 'الخدمات',
      'servicesSubtitle': 'جميع خدمات بنك الكريمي في مكان واحد',
      'bankingServices': 'الخدمات المصرفية',
      'digitalServices': 'الخدمات الرقمية',
      'popularServices': 'الخدمات الشائعة',
      'allServices': 'جميع الخدمات',
      // Service names
      'serviceEDCard': 'إيدي كارد',
      'serviceEDCardDesc': 'بطاقة الدفع الإلكتروني للتسوق المحلي والدولي',
      'serviceHasseb': 'حاسب',
      'serviceHassebDesc': 'نظام إدارة الحسابات والمحاسبة',
      'serviceKuraimiExpress': 'كريمي إكسبرس',
      'serviceKuraimiExpressDesc': 'التحويلات السريعة والفورية',
      'serviceKuraimiTasdeed': 'كريمي تسديد',
      'serviceKuraimiTasdeedDesc': 'دفع الفواتير والخدمات',
      'serviceMFloos': 'م-فلوس',
      'serviceMFloosDesc': 'المحفظة الإلكترونية والدفع السريع',
      'serviceMashroaeeFinance': 'مشروعي للتمويل',
      'serviceMashroaeeFinanceDesc': 'التمويل الأصغر للمشاريع',
      'learnMore': 'معرفة المزيد',
      'activate': 'تفعيل',
      'activated': 'مفعّل',
      'comingSoon': 'قريباً',
    },
    'en': {
      'appTitle': 'Alkuraimi Bank',
      'bankName': 'ALKURAIMI ISLAMIC MICROFINANCE BANK',
      'bankNameEn': 'ALKURAIMI ISLAMIC MICROFINANCE BANK',
      'welcomeTitle': 'Shop the world with Eidi card',
      'welcomeSubtitle': 'Enjoy safe and convenient shopping',
      'userIdLabel': 'Unique ID',
      'userIdHint': 'Enter unique ID',
      'passwordLabel': 'Password',
      'passwordHint': 'Enter password',
      'loginButton': 'Login',
      'biometricLogin': 'Login with biometrics',
      'forgotPassword': 'Forgot password?',
      'offlineLogin': 'Offline login',
      'loginSuccess': 'Logged in successfully',
      'loginError': 'Invalid login credentials',
      'biometricFallback': 'Use password',
      'userIdRequired': 'Please enter unique ID',
      'passwordRequired': 'Please enter password',
      'supportComputer': 'Support (web)',
      'more': 'More',
      'rateApp': 'Rate app',
      'version': 'Version V1.6.344',
      'forgotPasswordContent': 'Please contact customer support to reset your password.',
      'close': 'Close',
      'contactSupport': 'Contact support',
      'offlineLoginTitle': 'Offline login',
      'offlineLoginContent': 'You can login offline using the last saved credentials on this device.',
      'cancel': 'Cancel',
      'supportTitle': 'Customer support',
      'contactMethodsText': 'You can reach us via:',
      'phoneLabel': 'Phone: 800-123-456',
      'emailLabel': 'Email: support@alkuraimi.com',
      'chatLabel': 'Live chat',
      'moreOptionsTitle': 'Additional options',
      'changeLanguage': 'Change language',
      'securitySettings': 'Security settings',
      'aboutApp': 'About app',
      'aboutBankLine1': 'ALKURAIMI ISLAMIC MICROFINANCE BANK',
      'aboutBankLine2': 'A secure and convenient banking app',
      'callingCustomerService': 'Calling customer service...',
      'attemptingOfflineLogin': 'Attempting offline login...',
      'rateAppSnackbar': 'Thanks! Rating page opened',
      'biometricPrompt': 'Please authenticate to login',
      'biometricFailed': 'Biometric authentication failed. Try again or use password',
      'userIdTooShort': 'Unique ID must be more than 3 digits',
      'passwordTooShort': 'Password must be more than 4 characters',
      'phoneRequired': 'Please enter phone number',
      'phoneInvalid': 'Phone number is invalid',
      'emailRequired': 'Please enter email address',
      'emailInvalid': 'Email address is invalid',
      // New navigation labels
      'navHome': 'Home',
      'navTransactions': 'Transactions',
      'navServices': 'Services',
      'navSettings': 'Settings',
      'navProfile': 'Profile',
      // Theme dialog
      'themeTitle': 'Choose theme',
      'themeLightTitle': 'Light mode',
      'themeLightSubtitle': 'Light background, dark text',
      'themeDarkTitle': 'Dark mode',
      'themeDarkSubtitle': 'Dark background, light text',
      'themeSystemTitle': 'System',
      'themeSystemSubtitle': 'Follow system settings',
      // Greetings
      'hello': 'Hello,',
      'welcomeToBank': 'Welcome to Alkuraimi Bank',
      // Balance/actions
      'availableBalance': 'Available balance',
      'transfer': 'Transfer',
      'deposit': 'Deposit',
      'currencySuffix': 'Rial',
      // Transaction list
      'recentTransactions': 'Recent transactions',
      'allTransactions': 'All transactions',
      'seeAll': 'See all',
      'transaction': 'Transaction',
      // Account info
      'accountNumberLabel': 'Account #:',
      'qrCode': 'QR code',
      // Services
      'svcAccounts': 'Accounts',
      'svcTransfer': 'Transfer',
      'svcPayBills': 'Pay bills',
      'svcTopUp': 'Top-up',
      'svcCards': 'Cards',
      'svcQRCode': 'QR code',
      'svcBranches': 'Branches',
      'svcSupport': 'Support',
      // Settings
      'stProfile': 'Profile',
      'stSecurity': 'Security',
      'stNotifications': 'Notifications',
      'stLanguage': 'Language',
      'stSupport': 'Support',
      'stAbout': 'About',
      // Quick actions
      'quickActionsTitle': 'Quick actions',
      'quickInstantTransfer': 'Instant transfer',
      'quickBillPayment': 'Bill payment',
      'quickTopUp': 'Top up',
      'quickStatement': 'Statement',
      // Common
      'transactions': 'Transactions',
      'services': 'Services',
      'settings': 'Settings',
      'loadingData': 'Loading data...',
      'errorTitle': 'Error',
      'retry': 'Retry',
      'notificationsTitle': 'Notifications',
      // Languages
      'arabicLanguage': 'Arabic',
      'englishLanguage': 'English',
      // Profile Screen
      'personalInfo': 'Personal Info',
      'goldenMember': 'Golden Member',
      'accountInfo': 'Account Info',
      'accountNumber': 'Account Number',
      'cardNumber': 'Card Number',
      'accountStatus': 'Account Status',
      'accountActive': 'Active ✓',
      'joiningDate': 'Joining Date',
      'contactInfo': 'Contact Info',
      'phoneNumber': 'Phone Number',
      'email': 'Email',
      'address': 'Address',
      'quickServices': 'Quick Services',
      'accountStatement': 'Account Statement',
      'technicalSupport': 'Technical Support',
      'security': 'Security',
      // Exchange Rates
      'exchangeRates': 'Exchange Rates',
      'currency': 'Currency',
      'sell': 'Sell',
      'buy': 'Buy',
      'usd': 'USD',
      'sar': 'SAR',
      'euro': 'EURO',
      'gold': 'GOLD',
      // Services Screen
      'servicesTitle': 'Services',
      'servicesSubtitle': 'All Alkuraimi Bank services in one place',
      'bankingServices': 'Banking Services',
      'digitalServices': 'Digital Services',
      'popularServices': 'Popular Services',
      'allServices': 'All Services',
      // Service names
      'serviceEDCard': 'ED Card',
      'serviceEDCardDesc': 'Electronic payment card for local and international shopping',
      'serviceHasseb': 'Hasseb',
      'serviceHassebDesc': 'Account and accounting management system',
      'serviceKuraimiExpress': 'Kuraimi Express',
      'serviceKuraimiExpressDesc': 'Fast and instant transfers',
      'serviceKuraimiTasdeed': 'Kuraimi Tasdeed',
      'serviceKuraimiTasdeedDesc': 'Bill and service payments',
      'serviceMFloos': 'M-Floos',
      'serviceMFloosDesc': 'Digital wallet and quick payment',
      'serviceMashroaeeFinance': 'Mashroaee Finance',
      'serviceMashroaeeFinanceDesc': 'Microfinance for projects',
      'learnMore': 'Learn More',
      'activate': 'Activate',
      'activated': 'Activated',
      'comingSoon': 'Coming Soon',
    },
  };

  String _t(String key) => _localized[_locale]?[key] ?? _localized['ar']![key] ?? '';

  String get appTitle => _t('appTitle');
  String get bankName => _t('bankName');
  String get bankNameEn => _t('bankNameEn');
  String get welcomeTitle => _t('welcomeTitle');
  String get welcomeSubtitle => _t('welcomeSubtitle');
  String get userIdLabel => _t('userIdLabel');
  String get userIdHint => _t('userIdHint');
  String get passwordLabel => _t('passwordLabel');
  String get passwordHint => _t('passwordHint');
  String get loginButton => _t('loginButton');
  String get biometricLogin => _t('biometricLogin');
  String get forgotPassword => _t('forgotPassword');
  String get offlineLogin => _t('offlineLogin');
  String get loginSuccess => _t('loginSuccess');
  String get loginError => _t('loginError');
  String get biometricFallback => _t('biometricFallback');
  String get userIdRequired => _t('userIdRequired');
  String get passwordRequired => _t('passwordRequired');
  String get supportComputer => _t('supportComputer');
  String get whatsapp => _t('whatsapp');
  String get rateApp => _t('rateApp');
  String get version => _t('version');
  String get forgotPasswordTitle => _t('forgotPasswordTitle');
  String get forgotPasswordContent => _t('forgotPasswordContent');
  String get close => _t('close');
  String get contactSupport => _t('contactSupport');
  String get offlineLoginTitle => _t('offlineLoginTitle');
  String get offlineLoginContent => _t('offlineLoginContent');
  String get cancel => _t('cancel');
  String get supportTitle => _t('supportTitle');
  String get contactMethodsText => _t('contactMethodsText');
  String get phoneLabel => _t('phoneLabel');
  String get emailLabel => _t('emailLabel');
  String get chatLabel => _t('chatLabel');
  String get moreOptionsTitle => _t('moreOptionsTitle');
  String get changeLanguage => _t('changeLanguage');
  String get securitySettings => _t('securitySettings');
  String get aboutApp => _t('aboutApp');
  String get aboutBankLine1 => _t('aboutBankLine1');
  String get aboutBankLine2 => _t('aboutBankLine2');
  String get callingCustomerService => _t('callingCustomerService');
  String get attemptingOfflineLogin => _t('attemptingOfflineLogin');
  String get rateAppSnackbar => _t('rateAppSnackbar');
  String get biometricPrompt => _t('biometricPrompt');
  String get biometricFailed => _t('biometricFailed');
  String get userIdTooShort => _t('userIdTooShort');
  String get passwordTooShort => _t('passwordTooShort');
  String get phoneRequired => _t('phoneRequired');
  String get phoneInvalid => _t('phoneInvalid');
  String get emailRequired => _t('emailRequired');
  String get emailInvalid => _t('emailInvalid');
  String get more => _t('more');
  // New getters
  String get navHome => _t('navHome');
  String get navTransactions => _t('navTransactions');
  String get navServices => _t('navServices');
  String get navSettings => _t('navSettings');
  String get navProfile => _t('navProfile');
  String get themeTitle => _t('themeTitle');
  String get themeLightTitle => _t('themeLightTitle');
  String get themeLightSubtitle => _t('themeLightSubtitle');
  String get themeDarkTitle => _t('themeDarkTitle');
  String get themeDarkSubtitle => _t('themeDarkSubtitle');
  String get themeSystemTitle => _t('themeSystemTitle');
  String get themeSystemSubtitle => _t('themeSystemSubtitle');
  String get hello => _t('hello');
  String get welcomeToBank => _t('welcomeToBank');
  String get availableBalance => _t('availableBalance');
  String get transfer => _t('transfer');
  String get deposit => _t('deposit');
  String get currencySuffix => _t('currencySuffix');
  String get recentTransactions => _t('recentTransactions');
  String get allTransactions => _t('allTransactions');
  String get seeAll => _t('seeAll');
  String get transaction => _t('transaction');
  String get accountNumberLabel => _t('accountNumberLabel');
  String get qrCode => _t('qrCode');
  String get svcAccounts => _t('svcAccounts');
  String get svcTransfer => _t('svcTransfer');
  String get svcPayBills => _t('svcPayBills');
  String get svcTopUp => _t('svcTopUp');
  String get svcCards => _t('svcCards');
  String get svcQRCode => _t('svcQRCode');
  String get svcBranches => _t('svcBranches');
  String get svcSupport => _t('svcSupport');
  String get stProfile => _t('stProfile');
  String get stSecurity => _t('stSecurity');
  String get stNotifications => _t('stNotifications');
  String get stLanguage => _t('stLanguage');
  String get stSupport => _t('stSupport');
  String get stAbout => _t('stAbout');
  String get quickActionsTitle => _t('quickActionsTitle');
  String get quickInstantTransfer => _t('quickInstantTransfer');
  String get quickBillPayment => _t('quickBillPayment');
  String get quickTopUp => _t('quickTopUp');
  String get quickStatement => _t('quickStatement');
  String get transactions => _t('transactions');
  String get services => _t('services');
  String get settings => _t('settings');
  String get loadingData => _t('loadingData');
  String get errorTitle => _t('errorTitle');
  String get retry => _t('retry');
  String get notificationsTitle => _t('notificationsTitle');
  String get arabicLanguage => _t('arabicLanguage');
  String get englishLanguage => _t('englishLanguage');
  // Profile Screen
  String get personalInfo => _t('personalInfo');
  String get goldenMember => _t('goldenMember');
  String get accountInfo => _t('accountInfo');
  String get accountNumber => _t('accountNumber');
  String get cardNumber => _t('cardNumber');
  String get accountStatus => _t('accountStatus');
  String get accountActive => _t('accountActive');
  String get joiningDate => _t('joiningDate');
  String get contactInfo => _t('contactInfo');
  String get phoneNumber => _t('phoneNumber');
  String get email => _t('email');
  String get address => _t('address');
  String get quickServices => _t('quickServices');
  String get accountStatement => _t('accountStatement');
  String get technicalSupport => _t('technicalSupport');
  String get security => _t('security');
  String get theme => _t('theme');
  String get language => _t('language');
  String get aboutUs => _t('aboutUs');
  String get aboutUsContent => _t('aboutUsContent');

  // Exchange Rates
  String get exchangeRates => _t('exchangeRates');
  String get currency => _t('currency');
  String get sell => _t('sell');
  String get buy => _t('buy');
  String get usd => _t('usd');
  String get rsa => _t('sar');
  String get euro => _t('euro');
  String get gold => _t('gold');

  // Services Screen
  String get servicesTitle => _t('servicesTitle');
  String get servicesSubtitle => _t('servicesSubtitle');
  String get bankingServices => _t('bankingServices');
  String get digitalServices => _t('digitalServices');
  String get popularServices => _t('popularServices');
  String get allServices => _t('allServices');
  String get serviceEDCard => _t('serviceEDCard');
  String get serviceEDCardDesc => _t('serviceEDCardDesc');
  String get serviceHasseb => _t('serviceHasseb');
  String get serviceHassebDesc => _t('serviceHassebDesc');
  String get serviceKuraimiExpress => _t('serviceKuraimiExpress');
  String get serviceKuraimiExpressDesc => _t('serviceKuraimiExpressDesc');
  String get serviceKuraimiTasdeed => _t('serviceKuraimiTasdeed');
  String get serviceKuraimiTasdeedDesc => _t('serviceKuraimiTasdeedDesc');
  String get serviceMFloos => _t('serviceMFloos');
  String get serviceMFloosDesc => _t('serviceMFloosDesc');
  String get serviceMashroaeeFinance => _t('serviceMashroaeeFinance');
  String get serviceMashroaeeFinanceDesc => _t('serviceMashroaeeFinanceDesc');
  String get learnMore => _t('learnMore');
  String get activate => _t('activate');
  String get activated => _t('activated');
  String get comingSoon => _t('comingSoon');
}
