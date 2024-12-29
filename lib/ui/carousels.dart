import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerCarousel extends StatefulWidget {
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
    super.key,
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
  }) : assert(imageUrls.length == urlsToNavigate.length,
            'Each image must have a corresponding URL to navigate.');

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int _currentIndex = 0;

  Future<void> _navigateToUrl(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CarouselSlider.builder(
            itemCount: widget.imageUrls.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () => _navigateToUrl(widget.urlsToNavigate[index]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  child: Image.network(
                    widget.imageUrls[index],
                    fit: BoxFit.cover,
                    width: widget.width,
                    height: widget.height,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: widget.width,
                        height: widget.height,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: widget.width,
                      height: widget.height,
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.error, color: Colors.red, size: 50),
                      ),
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: widget.autoScroll,
              height: widget.height,
              viewportFraction: 0.85,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          if (widget.dotsVisible)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.imageUrls.asMap().entries.map((entry) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _currentIndex == entry.key
                        ? widget.dotSize * 1.5
                        : widget.dotSize,
                    height: widget.dotSize,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: widget.dotShape,
                      color: _currentIndex == entry.key
                          ? widget.activeDotColor
                          : widget.dotColor,
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
