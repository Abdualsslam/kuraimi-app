import 'package:kuraimi/constants/assets.dart';
import 'package:kuraimi/screens/services/models/service_model.dart';

/// بيانات الخدمات المتاحة
class ServicesData {
  static List<ServiceModel> getAllServices() {
    return [
      // ED Card
      ServiceModel(
        id: 'ed_card',
        nameKey: 'serviceEDCard',
        descriptionKey: 'serviceEDCardDesc',
        iconPath: Assets.serviceEDCard,
        isActive: true,
        isPopular: true,
        category: ServiceCategory.banking,
      ),

      // Hasseb
      ServiceModel(
        id: 'hasseb',
        nameKey: 'serviceHasseb',
        descriptionKey: 'serviceHassebDesc',
        iconPath: Assets.serviceHasseb,
        isActive: true,
        isPopular: true,
        category: ServiceCategory.digital,
      ),

      // Kuraimi Express
      ServiceModel(
        id: 'kuraimi_express',
        nameKey: 'serviceKuraimiExpress',
        descriptionKey: 'serviceKuraimiExpressDesc',
        iconPath: Assets.serviceKuraimiExpress,
        isActive: true,
        isPopular: true,
        category: ServiceCategory.payment,
      ),

      // Kuraimi Tasdeed
      ServiceModel(
        id: 'kuraimi_tasdeed',
        nameKey: 'serviceKuraimiTasdeed',
        descriptionKey: 'serviceKuraimiTasdeedDesc',
        iconPath: Assets.serviceKuraimiTasdeed,
        isActive: true,
        isPopular: false,
        category: ServiceCategory.payment,
      ),

      // M-Floos
      ServiceModel(
        id: 'm_floos',
        nameKey: 'serviceMFloos',
        descriptionKey: 'serviceMFloosDesc',
        iconPath: Assets.serviceMFloos,
        isActive: true,
        isPopular: true,
        category: ServiceCategory.digital,
      ),

      // Mashroaee Finance
      ServiceModel(
        id: 'mashroaee_finance',
        nameKey: 'serviceMashroaeeFinance',
        descriptionKey: 'serviceMashroaeeFinanceDesc',
        iconPath: Assets.serviceMashroaeeFinance,
        isActive: true,
        isPopular: false,
        category: ServiceCategory.finance,
      ),
    ];
  }

  static List<ServiceModel> getPopularServices() {
    return getAllServices().where((service) => service.isPopular).toList();
  }

  static List<ServiceModel> getServicesByCategory(ServiceCategory category) {
    return getAllServices().where((service) => service.category == category).toList();
  }
}
