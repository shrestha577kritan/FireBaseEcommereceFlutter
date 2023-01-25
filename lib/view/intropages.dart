import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

final List<PageViewModel> pages = [
  PageViewModel(
    title: 'Cheap Experiance',
    body: 'Description',
    footer: ElevatedButton(
      onPressed: () {},
      child: Text('Lets go..'),
    ),
    image: Center(
      child: Lottie.network('https://assets9.lottiefiles.com/private_files/lf30_ecnepkno.json'),
    ),
    decoration: PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  PageViewModel(
    title: 'Buy Now',
    body: 'Description',
    footer: ElevatedButton(
      onPressed: () {},
      child: Text('Lets go..'),
    ),
    image: Center(
      child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_AvL4ARCJct.json'),
    ),
    decoration: PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  PageViewModel(
    title: 'Heavy Discount',
    body: 'Description',
    footer: ElevatedButton(
      onPressed: () {},
      child: Text('Lets go..'),
    ),
    image: Center(
      child: Lottie.network('https://assets2.lottiefiles.com/private_files/lf30_9kdbftpx.json'),
    ),
    decoration: PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
];
