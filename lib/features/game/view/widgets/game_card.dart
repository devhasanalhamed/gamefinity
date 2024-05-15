import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/features/game/data/model/game_model.dart';

class GameCard extends StatefulWidget {
  final GameModel game;
  const GameCard({
    super.key,
    required this.game,
  });

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          clicked = !clicked;
        });
      },
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: widget.game.backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16.0,
            ),
            decoration: const BoxDecoration(
              color: Colors.grey,
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.game.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 15,
            child: Text(
              widget.game.rating.toStringAsFixed(1),
            ),
          ),
          if (clicked)
            AnimatedContainer(
              duration: Duration(milliseconds: clicked ? 300 : 0),
              margin: const EdgeInsets.only(
                top: 20.0,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Colors.black87,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(widget.game.released),
                ],
              ),
            ),
        ],
      ),
    );
  }
}