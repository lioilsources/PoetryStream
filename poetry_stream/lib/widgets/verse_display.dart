import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/verse_style.dart';

class VerseDisplay extends StatelessWidget {
  final String text;
  final VerseStyle style;
  final double opacity;
  final Duration fadeDuration;

  const VerseDisplay({
    super.key,
    required this.text,
    required this.style,
    required this.opacity,
    required this.fadeDuration,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth = screenWidth * 0.85 > 720 ? 720.0 : screenWidth * 0.85;

    return AnimatedOpacity(
      opacity: opacity,
      duration: fadeDuration,
      curve: Curves.easeInOut,
      child: SizedBox(
        width: maxWidth,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            width: maxWidth,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: _buildTextStyle(),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _buildTextStyle() {
    final baseStyle = _getGoogleFont();
    return baseStyle.copyWith(
      fontSize: style.fontSize,
      fontWeight: style.fontWeight,
      fontStyle: style.isItalic ? FontStyle.italic : FontStyle.normal,
      color: style.textColor,
      height: 1.9,
      letterSpacing: 0.5,
      shadows: [
        Shadow(color: style.glowColor, blurRadius: 80),
        Shadow(color: style.glowColor, blurRadius: 160),
      ],
    );
  }

  TextStyle _getGoogleFont() {
    switch (style.fontFamily) {
      case 'Playfair Display':
        return GoogleFonts.playfairDisplay();
      case 'Cormorant Garamond':
        return GoogleFonts.cormorantGaramond();
      case 'DM Serif Display':
        return GoogleFonts.dmSerifDisplay();
      case 'Bodoni Moda':
        return GoogleFonts.bodoniModa();
      case 'Raleway':
        return GoogleFonts.raleway();
      case 'Josefin Sans':
        return GoogleFonts.josefinSans();
      case 'Caveat':
        return GoogleFonts.caveat();
      case 'Space Mono':
        return GoogleFonts.spaceMono();
      case 'Italiana':
        return GoogleFonts.italiana();
      case 'Poiret One':
        return GoogleFonts.poiretOne();
      case 'Spectral':
        return GoogleFonts.spectral();
      case 'Unbounded':
        return GoogleFonts.unbounded();
      default:
        return GoogleFonts.spectral();
    }
  }
}
