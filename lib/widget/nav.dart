import 'package:flutter/material.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/bottom.png',
            fit: BoxFit.cover, // adjust the fit as per your requirement
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            color: const Color(0xFFD2BB84),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'home');
                  },
                  icon: const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'ticket');
                  },
                  icon: const Icon(
                    Icons.confirmation_num_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'info');
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
