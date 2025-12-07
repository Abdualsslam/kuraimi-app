import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/assets.dart';

final List<String> banners = [Assets.banner1, Assets.banner2, Assets.banner3];

class BannersWidget extends StatefulWidget {
  const BannersWidget({super.key});

  @override
  State<BannersWidget> createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: banners.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: DecorationImage(image: AssetImage(item), fit: BoxFit.cover),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 150.h,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 2000),
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: banners.asMap().entries.map((entry) {
            return Container(
              width: 12.0.w,
              height: 12.0.h,
              margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 4.0.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Theme.of(context).colorScheme.secondary).withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
