import 'package:flutter/material.dart';
import '../../../constants/assets.dart';

class BannersWidget extends StatefulWidget {
  const BannersWidget({super.key});

  @override
  State<BannersWidget> createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  final List<String> banners = [Assets.banner1, Assets.banner2, Assets.banner3];
  late final PageController _controller;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
    Future.delayed(const Duration(milliseconds: 500), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted) return;
    _currentPage = (_currentPage + 1) % banners.length;
    _controller.animateToPage(_currentPage, duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final double width = 300;
    final double height = 170;
    return SizedBox(
      height: height,
      // width: width,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: banners.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(banners[i], fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(banners.length, (i) {
              final bool active = i == _currentPage;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 14 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: active ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
