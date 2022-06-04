import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cia/blocs/blocs.dart';
import 'package:cia/models/models.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromotionCarousel extends StatefulWidget {
  const PromotionCarousel({
    Key? key,
  }) : super(key: key);

  @override
  State<PromotionCarousel> createState() => _PromotionCarouselState();
}

class _PromotionCarouselState extends State<PromotionCarousel> {

  int _current = 0;
  final CarouselController _controller = CarouselController();

  static const dotsRadius = 5.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBloc, PromotionState>(
      builder: (context, state) {
        if(state is PromotionLoading){
          return const Center(child: CircularProgressIndicator(),);
        }
        if(state is PromotionLoaded) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CarouselSlider(
                  carouselController: _controller,
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    autoPlay: true,
                  ),
                  items: state.promotions.map((promotion) =>
                      CarouselImageContainer(promotion: promotion)).toList(),
                ),
              ),
              Positioned(
                bottom: 1,
                left: 1,
                right: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DotsIndicator(
                    onTap: (index) {
                      _controller.animateToPage(index.toInt());
                      setState(() {
                        _current = index.toInt();
                      });
                    },
                    dotsCount: state.promotions.length,
                    position: _current.toDouble(),
                    decorator: DotsDecorator(
                      color: const Color(0xFF707070),
                      activeColor: Colors.white,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(dotsRadius)),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        return const Center(
          child: Text("Something went wrong!"),
        );
      },
    );
  }
}

class CarouselImageContainer extends StatelessWidget {
  final Promotion promotion;
  const CarouselImageContainer({
    Key? key,
    required this.promotion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: promotion.imageUrl,
                fit: BoxFit.cover,
                width: 1000.0,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // Positioned(
              //   bottom: 0.0,
              //   left: 0.0,
              //   right: 0.0,
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           Color.fromARGB(200, 0, 0, 0),
              //           Color.fromARGB(0, 0, 0, 0)
              //         ],
              //         begin: Alignment.bottomCenter,
              //         end: Alignment.topCenter,
              //       ),
              //     ),
              //     padding: const EdgeInsets.symmetric(
              //         vertical: 10.0, horizontal: 20.0),
              //     child: const Text(
              //       '',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 20.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )),
    );
  }
}