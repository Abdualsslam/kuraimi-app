import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyBalance {
  final String code; // YER / SAR / USD
  final String labelAr; // عربي: ريال يمني / ريال سعودي / دولار أمريكي
  final String symbol; // ر.ي / ر.س / USD
  final String amountMasked; // 672,345.54
  final String iban; // 3002140108 (أو رقم الحساب)
  const CurrencyBalance({required this.code, required this.labelAr, required this.symbol, required this.amountMasked, required this.iban});
}

/// بطاقة رصيد حديثة، متوافقة مع متطلباتك
class ModernBalanceCard extends StatelessWidget {
  final CurrencyBalance item;
  final Color brandColor; // لون الهوية
  final bool obscureAmount; // إخفاء/إظهار الرصيد
  final VoidCallback? onToggleObscure;
  final VoidCallback? onTransfer;
  final VoidCallback? onQr;
  final String? patternAsset; // مثل: 'assets/icon/islamic_art.svg'
  final double height;
  final EdgeInsets padding;

  const ModernBalanceCard({
    super.key,
    required this.item,
    required this.brandColor,
    this.obscureAmount = false,
    this.onToggleObscure,
    this.onTransfer,
    this.onQr,
    this.patternAsset,
    this.height = 160,
    this.padding = const EdgeInsets.fromLTRB(18, 18, 18, 16),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);

    final light = _tint(brandColor, .18);
    final dark = _shade(brandColor, .14);

    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // خلفية متدرجة من لون الهوية
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [light, dark]),
                boxShadow: [BoxShadow(color: brandColor.withOpacity(.35), blurRadius: 24, offset: const Offset(0, 14))],
              ),
            ),

            // نقش SVG اختياري (خفيف)
            if (patternAsset != null)
              Positioned.fill(
                child: IgnorePointer(
                  child: Opacity(
                    opacity: 0.10,
                    child: SvgPicture.asset(
                      patternAsset!,
                      fit: BoxFit.cover,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),

            // أقواس زخرفية ناعمة
            CustomPaint(painter: _OrnamentPainter(color: Colors.white.withOpacity(.14))),

            // محتوى البطاقة
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // السطر العلوي: يسار (Balance/amount) — يمين (code/label/iban)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // يسار
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Balance', style: textTheme.labelLarge?.copyWith(color: Colors.white70, letterSpacing: .2)),
                            const SizedBox(height: 6),

                            // ✅ قيمة الرصيد مع إخفاء بالشكل المطلوب
                            SizedBox(
                              // نحدّ عرض الحقل حتى لا يأخذ عرض البطاقة كله عند الإخفاء
                              width: 180,
                              height: 28,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                child: obscureAmount
                                    ? Container(
                                        key: const ValueKey('hidden'),
                                        height: 22,
                                        width: double.infinity,
                                        color: theme.colorScheme.onSurface.withOpacity(0.10),
                                      )
                                    : Align(
                                        key: const ValueKey('visible'),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${item.amountMasked} ${item.symbol}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 4),

                            // زر إظهار/إخفاء على يسار القيمة (مصغّر)
                            if (onToggleObscure != null)
                              Row(
                                children: [
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints.tightFor(width: 28, height: 28),
                                    iconSize: 18,
                                    splashRadius: 20,
                                    color: Colors.white70,
                                    tooltip: obscureAmount ? 'إظهار' : 'إخفاء',
                                    onPressed: onToggleObscure,
                                    icon: Icon(obscureAmount ? Icons.visibility_off : Icons.visibility),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // يمين: بيانات العملة/الحساب
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(item.code, style: textTheme.labelLarge?.copyWith(color: Colors.white70, letterSpacing: .3)),
                          const SizedBox(height: 6),
                          Text(
                            item.labelAr,
                            style: textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 6),
                          // رقم الحساب (IBAN مبسط)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.10),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white.withOpacity(.18)),
                            ),
                            child: Text(item.iban, style: textTheme.labelLarge?.copyWith(color: Colors.white, letterSpacing: .6)),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const Spacer(),

                  // السطر السفلي: أزرار الإجراءات (تحويل + QR)
                  Row(
                    children: [
                      _ActionPill(
                        icon: Icons.sync_alt_rounded,
                        label: 'تحويل',
                        onTap: onTransfer,
                        bg: Colors.white.withOpacity(.14),
                        fg: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      _ActionPill(
                        icon: Icons.qr_code_2_rounded,
                        label: 'QR',
                        onTap: onQr,
                        bg: Colors.white.withOpacity(.14),
                        fg: Colors.white,
                      ),
                      const Spacer(),
                      // ممكن تضيف زر ثالث لاحقًا (إيداع/شحن) بنفس النمط
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _tint(Color c, double amount) {
    final hsl = HSLColor.fromColor(c);
    return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
  }

  Color _shade(Color c, double amount) {
    final hsl = HSLColor.fromColor(c);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }
}

class _ActionPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color bg;
  final Color fg;

  const _ActionPill({required this.icon, required this.label, required this.onTap, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(icon, size: 18, color: fg),
              const SizedBox(width: 8),
              Text(
                label,
                style: text.labelLarge?.copyWith(color: fg, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// زخارف الأقواس
class _OrnamentPainter extends CustomPainter {
  final Color color;
  _OrnamentPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = 18;

    final center1 = Offset(size.width * .82, size.height * .72);
    canvas.drawArc(Rect.fromCircle(center: center1, radius: size.height * .95), -math.pi * .15, math.pi * .85, false, paint);

    paint.strokeWidth = 12;
    final center2 = Offset(size.width * .88, size.height * .78);
    canvas.drawArc(Rect.fromCircle(center: center2, radius: size.height * .70), -math.pi * .2, math.pi * .9, false, paint);
  }

  @override
  bool shouldRepaint(covariant _OrnamentPainter oldDelegate) => oldDelegate.color != color;
}
