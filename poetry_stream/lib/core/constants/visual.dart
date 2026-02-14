import 'package:flutter/material.dart';

class VerseFont {
  final String family;
  final FontWeight weight;

  const VerseFont(this.family, this.weight);
}

class VersePalette {
  final Color text;
  final Color glow;

  const VersePalette(this.text, this.glow);
}

class VisualConstants {
  static const fonts = [
    VerseFont('Playfair Display', FontWeight.w700),
    VerseFont('Cormorant Garamond', FontWeight.w300),
    VerseFont('DM Serif Display', FontWeight.w400),
    VerseFont('Bodoni Moda', FontWeight.w400),
    VerseFont('Raleway', FontWeight.w200),
    VerseFont('Josefin Sans', FontWeight.w300),
    VerseFont('Caveat', FontWeight.w400),
    VerseFont('Space Mono', FontWeight.w400),
    VerseFont('Italiana', FontWeight.w400),
    VerseFont('Poiret One', FontWeight.w400),
    VerseFont('Spectral', FontWeight.w300),
    VerseFont('Unbounded', FontWeight.w300),
  ];

  static const palettes = [
    VersePalette(Color(0xFFE8D5B7), Color(0x1AE8D5B7)), // warm beige
    VersePalette(Color(0xFF7EB8D4), Color(0x1A7EB8D4)), // cool blue
    VersePalette(Color(0xFFD4A07E), Color(0x1AD4A07E)), // warm brown
    VersePalette(Color(0xFF8CC4A0), Color(0x1A8CC4A0)), // sage green
    VersePalette(Color(0xFFD48A8A), Color(0x1AD48A8A)), // dusty rose
    VersePalette(Color(0xFFF5F0E8), Color(0x14F5F0E8)), // light cream
    VersePalette(Color(0xFFB89CD4), Color(0x1AB89CD4)), // lavender
    VersePalette(Color(0xFFD4C870), Color(0x1AD4C870)), // golden
    VersePalette(Color(0xFFE0B0C0), Color(0x1AE0B0C0)), // soft pink
    VersePalette(Color(0xFF90C8C8), Color(0x1A90C8C8)), // teal
  ];

  static const sizes = [18.0, 22.0, 26.0, 32.0, 40.0, 50.0];

  static const italicChance = 0.3;

  static const backgroundColor = Color(0xFF080604);

  // Background gradient colors
  static const warmGradient = Color(0xE619120A); // rgba(25,18,10,0.9)
  static const coolGradient = Color(0x990C141C); // rgba(12,20,28,0.6)
}
