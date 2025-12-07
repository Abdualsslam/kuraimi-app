import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StackedBalanceCard extends StatelessWidget {
  final CurrencyBalance item;
  final bool isTop;

  const StackedBalanceCard({super.key, required this.item, required this.isTop});

  @override
  Widget build(BuildContext context) {
    const cardH = 190.0;

    return SizedBox(
      height: cardH,
      child: GlassLayer(
        borderRadius: BorderRadius.circular(20),
        blurSigma: 20,
        glossTint: item.barColor, // يضبط التينت حسب لون البطاقة
        tintOpacity: .10,
        borderOpacity: .22,
        borderWidth: 1.4,
        shadows: [BoxShadow(color: item.barColor.withOpacity(.25), blurRadius: 30, offset: const Offset(0, 16))],
        highlightOrigin: const Offset(-60, -48),
        highlightRadius: 180,
        child: Stack(
          children: [
            // الحزام الزخرفي (download.svg) في الثلث العلوي
            Positioned(
              left: 0,
              right: 0,
              top: cardH / 3,
              child: Opacity(
                opacity: 0.15,
                child: SvgPicture.asset(
                  'assets/icon/download.svg',
                  width: double.infinity,
                  height: 60,
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(item.barColor.withOpacity(.9), BlendMode.srcIn),
                ),
              ),
            ),

            // المحتوى
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // شريط علوي بلون البطاقة
                  Container(
                    height: 4,
                    decoration: BoxDecoration(color: item.barColor, borderRadius: BorderRadius.circular(14)),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              item.iban,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: .5),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Image.asset('assets/icon/copy.png', color: Colors.white, height: 27),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),
                      Text(item.symbol, style: const TextStyle(color: Colors.white70, fontSize: 22)),
                    ],
                  ),
                  BalanceRow(amount: item.amountMasked, labelAr: item.labelAr),

                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // الصورة السابقة title2.png بدلاً من أيقونة البطاقة - مُلوّنة بنفس اللون
                      Container(
                        width: 250,
                        height: 55,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/icon/title.png',
                          fit: BoxFit.cover,
                          color: item.barColor, // نفس لون البطاقة
                          colorBlendMode: BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Image.asset('assets/icon/qrcode.png', color: Colors.white, height: 27),
                      ),
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
}

class CurrencyBalance {
  final String code; // YER / SAR / USD
  final String labelAr; // عربي
  final String symbol; // ر.ي / ر.س / USD
  final String amountMasked;
  final String iban;
  final Color barColor; // ✅ لون الشريط الخاص بهذه البطاقة فقط
  const CurrencyBalance({
    required this.code,
    required this.labelAr,
    required this.symbol,
    required this.amountMasked,
    required this.iban,
    required this.barColor,
  });
}

class GlassLayer extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final BorderRadius borderRadius;
  final Color? glossTint; // تينت زجاجي خفيف (يميل للون البطاقة)
  final double tintOpacity; // شفافيتها
  final double borderOpacity; // شفافية الحد الزجاجي
  final double borderWidth; // سمك الحد
  final List<BoxShadow> shadows;
  final bool showHighlight; // لمعة دائرية خفيفة
  final Offset highlightOrigin;
  final double highlightRadius;

  const GlassLayer({
    super.key,
    required this.child,
    this.blurSigma = 18,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.glossTint,
    this.tintOpacity = .10,
    this.borderOpacity = .22,
    this.borderWidth = 1.4,
    this.shadows = const [],
    this.showHighlight = true,
    this.highlightOrigin = const Offset(-40, -40),
    this.highlightRadius = 160,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: borderRadius, boxShadow: shadows),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(
          children: [
            // Blur خلفي
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: const SizedBox.expand(),
            ),
            // طبقة زجاجية شفافة + تينت خفيف
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(.08),
                    (glossTint ?? Colors.white).withOpacity(tintOpacity),
                    Colors.white.withOpacity(.03),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
                border: Border.all(color: Colors.white.withOpacity(borderOpacity), width: borderWidth),
                borderRadius: borderRadius,
              ),
              child: const SizedBox.expand(),
            ),
            // لمعة اختيارية تضيف عمق زجاجي
            if (showHighlight)
              Positioned(
                left: highlightOrigin.dx,
                top: highlightOrigin.dy,
                child: IgnorePointer(
                  child: Container(
                    width: highlightRadius,
                    height: highlightRadius,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(colors: [Colors.white.withOpacity(.35), Colors.transparent]),
                    ),
                  ),
                ),
              ),
            // المحتوى الفعلي
            child,
          ],
        ),
      ),
    );
  }
}

class BalanceRow extends StatefulWidget {
  final String amount;
  final String labelAr;

  const BalanceRow({super.key, required this.amount, required this.labelAr});

  @override
  State<BalanceRow> createState() => _BalanceRowState();
}

class _BalanceRowState extends State<BalanceRow> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _isHidden
                  ? Text(
                      '******',
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: .5),
                    )
                  : Text(
                      widget.amount,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800, letterSpacing: .5),
                    ),
              const SizedBox(width: 6),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isHidden = !_isHidden;
                  });
                },
                icon: Icon(_isHidden ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
                splashRadius: 20,
                tooltip: _isHidden ? "إظهار الرصيد" : "إخفاء الرصيد",
              ),
              const Spacer(),

              Column(
                children: [
                  Text('حساب جاري  ', style: const TextStyle(color: Color(0xFFB7B9D6))),
                  Text('•', style: const TextStyle(color: Color(0xFFB7B9D6))),
                  Text(widget.labelAr, style: const TextStyle(color: Color(0xFFB7B9D6))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
