
import 'package:challenge_koisystems/api.dart';
import 'package:challenge_koisystems/model/hotels.dart';
import 'package:flutter/material.dart';

import 'widget/hotel_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  int _selectedIndex = 0;

  int likes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.favorite_border,
                color: Colors.red,
                size: 42,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                likes.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
      body: _body(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }

  Column _body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder(
          future: Api().getAll(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return Container();
                } else {
                  final result = snapshot.data as Hotels;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.message?.toList().length,
                      itemBuilder: (context, index) {
                        var hotel = result.message?[index];

                        return HotelCard(
                          name: hotel?[0],
                          price: hotel?[3],
                          increment: _increment,
                          decrement: _decrement,
                        );
                      },
                    ),
                  );
                }
            }
          },
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _increment() {
    setState(() {
      likes++;
    });
  }

  void _decrement() {
    setState(() {
      likes--;
    });
  }
}
