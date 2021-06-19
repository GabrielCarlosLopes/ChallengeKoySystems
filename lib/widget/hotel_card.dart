import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelCard extends StatefulWidget {
  final String name;
  final String price;
  final VoidCallback increment;
  final VoidCallback decrement;

  const HotelCard({
    Key? key,
    required this.name,
    required this.price,
    required this.increment,
    required this.decrement,
  }) : super(key: key);

  @override
  _HotelCardState createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  late String name;
  late String price;
  late final VoidCallback increment;
  late final VoidCallback decrement;

  bool liked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10),
          Container(
            width: size.width * 0.64,
            child: Text(
              widget.name,
              style: GoogleFonts.rubik(),
            ),
          ),
          Container(
            width: size.width * .16,
            child: Text(
              widget.price+' €',
              style: GoogleFonts.rubik(),
            ),
          ),
          IconButton(
            onPressed: () {
              if (liked) {
                setState(() {
                  liked = false;
                });
                widget.decrement();
              } else {
                setState(() {
                  liked = true;
                });
                widget.increment();
              }
            },
            icon: liked
                ? Icon(
                    Icons.favorite_rounded,
                    color: Colors.red,
                  )
                : Icon(Icons.favorite_border),
          )
        ],
      ),
    );
  }
}
