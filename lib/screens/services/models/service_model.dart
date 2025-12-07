import 'package:flutter/material.dart';

/// نموذج بيانات الخدمة
class ServiceModel {
  final String id;
  final String nameKey;
  final String descriptionKey;
  final String iconPath;
  final Color? color;
  final bool isActive;
  final bool isPopular;
  final ServiceCategory category;
  final VoidCallback? onTap;

  const ServiceModel({
    required this.id,
    required this.nameKey,
    required this.descriptionKey,
    required this.iconPath,
    this.color,
    this.isActive = true,
    this.isPopular = false,
    required this.category,
    this.onTap,
  });

  ServiceModel copyWith({
    String? id,
    String? nameKey,
    String? descriptionKey,
    String? iconPath,
    Color? color,
    bool? isActive,
    bool? isPopular,
    ServiceCategory? category,
    VoidCallback? onTap,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      nameKey: nameKey ?? this.nameKey,
      descriptionKey: descriptionKey ?? this.descriptionKey,
      iconPath: iconPath ?? this.iconPath,
      color: color ?? this.color,
      isActive: isActive ?? this.isActive,
      isPopular: isPopular ?? this.isPopular,
      category: category ?? this.category,
      onTap: onTap ?? this.onTap,
    );
  }
}

/// فئات الخدمات
enum ServiceCategory { banking, digital, payment, finance }

extension ServiceCategoryExtension on ServiceCategory {
  String get nameKey {
    switch (this) {
      case ServiceCategory.banking:
        return 'bankingServices';
      case ServiceCategory.digital:
        return 'digitalServices';
      case ServiceCategory.payment:
        return 'bankingServices';
      case ServiceCategory.finance:
        return 'bankingServices';
    }
  }

  IconData get icon {
    switch (this) {
      case ServiceCategory.banking:
        return Icons.account_balance;
      case ServiceCategory.digital:
        return Icons.smartphone;
      case ServiceCategory.payment:
        return Icons.payment;
      case ServiceCategory.finance:
        return Icons.attach_money;
    }
  }
}
