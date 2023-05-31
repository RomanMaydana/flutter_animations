// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:animation_examples/ui/multiple_card_flow/place.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

import 'multiple_card_flow_details.dart';

const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff4b6089),
      Color(0xff9fb4d2),
    ]);

class MultipleCardFlow extends StatefulWidget {
  const MultipleCardFlow({super.key});

  @override
  State<MultipleCardFlow> createState() => _MultipleCardFlowState();
}

class _MultipleCardFlowState extends State<MultipleCardFlow>  with SingleTickerProviderStateMixin {
  final _pageController = PageController(viewportFraction: 0.8);
  late final AnimationController _animationController;

  double page = 0.0;

  void _listenScroll(){
    setState(() {
      page = _pageController.page!;
    });
  }
  @override
  void initState() {
    _pageController.addListener(_listenScroll);
    _animationController = AnimationController(vsync: this, 
    
    duration: const Duration(
      milliseconds: 500
    ),
    reverseDuration: const Duration(milliseconds: 1500)
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
            child: DecoratedBox(
                decoration: BoxDecoration(gradient: backgroundGradient))),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                       Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: _MyTextField(animation: _animationController,),
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.settings_applications))
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      final city = cities[index];
                      final percent = (page - index).abs().clamp(0.0, 1.0); 
                      final factor = _pageController.position.userScrollDirection == ScrollDirection.forward ? 1.0 : -1.0;
                      final opacity = percent.clamp(0.0, 0.7);
                      return Transform(
                        transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(vector.radians(45 * percent * factor)),
                        child: Opacity(
                          opacity: 1- opacity,
                          child: CityItemWidget(city: city, onSwipe: ()=>_onSwipe(city))));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
  void _onSwipe(City city)async{
    _animationController.forward();
    await Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 1200),
      pageBuilder: (context, animation, _) {
      return FadeTransition(
        opacity: animation,
        child: MultipleCardFlowDetails(city: city));
    },));

    _animationController.reverse();
  }
}

class _MyTextField extends AnimatedWidget {
  const _MyTextField({
    required Animation<double> animation

  }):super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final size= MediaQuery.of(context).size;
    final value = 1 - animation.value;
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: size.width * value.clamp(0.1, 1),
        height: 40,
        decoration: BoxDecoration(
        color: const Color(0xff8e9bb5),
        borderRadius: BorderRadius.circular(20)),
        child: Row(
      children: [
        const Icon(Icons.search),
        Expanded(
            child: Text(
          'Search city...',
          maxLines: 1,
          style: TextStyle(color: Colors.grey[600]),
        ))
      ],
                            ),
      ),
    );
  }
}

class CityItemWidget extends StatelessWidget {
  const CityItemWidget({
    Key? key,
    required this.city, required this.onSwipe,
  }) : super(key: key);
  final City city;
  final VoidCallback onSwipe;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        // print(details.primaryDelta);
        if(details.primaryDelta! < -7) {
          onSwipe();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(flex: 2, child: CityWidget(city: city)),
            const Spacer(),
            Expanded(
                flex: 3,
                child: ReviewWidget(
                  review: city.reviews.first,
                ))
          ],
        ),
      ),
    );
  }
}

class CityWidget extends StatelessWidget {
  const CityWidget({
    super.key,
    required this.city,
     this.padding =  EdgeInsets.zero,
  });

  final City city;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24);
    const subtitleStyle = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 19);
    return Hero(
      tag: 'city_${city.name}',
      child: Card(
        elevation: 10,
        child: Stack(
          children: [
            Positioned.fill(
                child: Image.network(
              city.image,
              fit: BoxFit.cover,
            )),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Padding(
                padding: padding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(city.name, style: titleStyle),
                    Text('${city.price}USD', style: titleStyle),
                    const Spacer(),
                    Expanded(child: Text(city.place, style: subtitleStyle)),
                    Expanded(
                      child: Text(city.data,
                          style: subtitleStyle.copyWith(
                            fontSize: 15,
                          )),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
   ReviewWidget({super.key, required this.review});
  final CityReview review;
  final DateFormat format = DateFormat.yMEd();
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'review_${review.title}',
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                        'https://cdn.icon-icons.com/icons2/3106/PNG/512/person_avatar_account_user_icon_191606.png', ),
                  ),
                  const SizedBox(
                    width: 10
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review.title,
                  
                        
                         style:  const TextStyle(
                          color: Colors.black,
                          fontSize: 12
                        ),),
                         Text(format.format(review.date), style:  const TextStyle(
                          color: Colors.black,
                          fontSize: 12
                        ))
                      ],
                    ),
                  )
                ],
              ),
               const SizedBox(
                              height: 10,
                             ),
               Text(review.subtitle,
               
               
                style:  const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                          ))
                             ,
                             const SizedBox(
                              height: 10,
                             ),
               Text(review.description, 
                     maxLines: 3,
               style:  const TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.w200
                            
                          )),
               const SizedBox(
                              height: 10,
                             ),
              Expanded(child: Image.network(review.image,fit: BoxFit.cover,))
            ],
          ),
        ),
      ),
    );
  }
}
