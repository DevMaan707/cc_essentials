import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerCarousel extends StatelessWidget {
  final double height;
  final double width;
  final Color dotColor;
  final Color activeDotColor;
  final bool autoScroll;
  final double dotSize;
  final BoxShape dotShape;
  final bool dotsVisible;
  final List<String> imageUrls;
  final List<String> urlsToNavigate;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const BannerCarousel({
    Key? key,
    required this.height,
    required this.width,
    this.dotColor = Colors.grey,
    this.activeDotColor = Colors.blue,
    this.autoScroll = true,
    this.dotSize = 8.0,
    this.dotShape = BoxShape.circle,
    this.dotsVisible = true,
    required this.imageUrls,
    required this.urlsToNavigate,
    this.margin,
    this.borderRadius = 16.0,
  })  : assert(imageUrls.length == urlsToNavigate.length,
            'Each image must have a corresponding URL to navigate.'),
        super(key: key);

  Future<void> _navigateToUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () => _navigateToUrl(urlsToNavigate[index]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    height: height,
                    width: width,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Icon(Icons.error, color: Colors.red, size: 50),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: autoScroll,
              height: height,
              viewportFraction: 0.9,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.easeInOut,
              autoPlayAnimationDuration: const Duration(seconds: 2),
            ),
          ),
          if (dotsVisible)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageUrls.asMap().entries.map((entry) {
                  return Container(
                    width: dotSize,
                    height: dotSize,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: dotShape,
                      color: entry.key == CarouselOptions().initialPage
                          ? activeDotColor
                          : dotColor,
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
