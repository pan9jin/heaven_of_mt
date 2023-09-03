// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import '../GameOver.dart';
import 'Candidate_choi.dart';
import '../card.dart';

class ChoiGame extends StatefulWidget {
  final String id;

  const ChoiGame({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<ChoiGame> createState() => _ChoiGamePageState();
}

class _ChoiGamePageState extends State<ChoiGame> {
  final CardSwiperController controller = CardSwiperController();
  List<GameCard> cards = []; // cards 변수를 초기화
  String setNumber = '';
  bool _isDone = false;
  @override
  void initState() {
    super.initState();

    // widget.id 값에 따라 cards 변수에 값을 할당
    if (widget.id == '1') {
      cards = candidates1.map(GameCard.new).toList();
    } else if (widget.id == '2') {
      cards = candidates2.map(GameCard.new).toList();
    } else if (widget.id == '3') {
      cards = candidates3.map(GameCard.new).toList();
    } else if (widget.id == '4') {
      cards = candidates4.map(GameCard.new).toList();
    } else if (widget.id == '5') {
      cards = candidates5.map(GameCard.new).toList();
    } else {
      cards = candidates5.map(GameCard.new).toList();
    }
    setNumber = widget.id;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(onPressed: (){Navigator.of(context).pop();},
      icon: Icon(Icons.door_back_door_outlined, color: Colors.black,)),),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: controller.undo,
                color: Colors.black,
                icon: Icon(
                  Icons.keyboard_arrow_left,
                ),
                iconSize: 50, // 아이콘 크기 조절
              ),
              Container(
                width: 1280,
                height: 832,
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      'SET $setNumber',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 100,
                      ),
                    ),
                    Flexible(
                      child: CardSwiper(
                        isDisabled: true,
                        controller: controller,
                        cardsCount: cards.length,
                        numberOfCardsDisplayed: 3,
                        backCardOffset: const Offset(40, 40),
                        padding: const EdgeInsets.all(24.0),
                        cardBuilder: (
                          context,
                          index,
                          horizontalThresholdPercentage,
                          verticalThresholdPercentage,
                        ) => cards[index],
                        onSwipe: (previousIndex, currentIndex, direction) {
                          setState(() {
                            _isDone = (currentIndex == 9);
                          });
                          return true;
                        },
                        
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_isDone) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            GameOver(id: widget.id), // Beauty 이미지에 대한 페이지
                      ),
                    );
                  } else {
                    controller.swipeLeft();
                  }
                },
                color: Colors.black,
                icon: Icon(Icons.keyboard_arrow_right),
                iconSize: 50, // 아이콘 크기 조절
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $previousIndex was swiped to the ${direction.name}. Now the card $currentIndex is on top',
    );
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
