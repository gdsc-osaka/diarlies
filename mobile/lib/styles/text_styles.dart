import 'package:flutter/material.dart';

import 'color_styles.dart';

class TextStyles {
  const TextStyles({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.label,
    required this.error,
    required this.link,
    required this.handwriting,
  });

  final TextStyleSet display;
  final TextStyleSet headline;
  final TextStyleSet title;
  final TextStyleSet body;
  final TextStyleSet label;
  final TextStyleSet error;
  final TextStyleSet link;
  final TextStyleSet handwriting;

  static TextStyles from(ColorStyles color) {
    return TextStyles(
      display: TextStyleSet(
        l: _bold(fontSize: 57, color: color.onSurface),
        m: _bold(fontSize: 45, color: color.onSurface),
        s: _bold(fontSize: 36, color: color.onSurface),
      ),
      headline: TextStyleSet(
        l: _bold(fontSize: 32, color: color.onSurface),
        m: _bold(fontSize: 28, color: color.onSurface),
        s: _bold(fontSize: 24, color: color.onSurface),
      ),
      title: TextStyleSet(
        l: _bold(fontSize: 22, color: color.onSurface, fontWeight: FontWeight.w700),
        m: _bold(fontSize: 16, color: color.onSurface, fontWeight: FontWeight.w700),
        s: _bold(fontSize: 14, color: color.onSurface, fontWeight: FontWeight.w700),
      ),
      body: TextStyleSet(
        l: _normal(fontSize: 16, color: color.onSurface),
        m: _normal(fontSize: 14, color: color.onSurface),
        s: _normal(fontSize: 12, color: color.onSurface),
      ),
      label: TextStyleSet(
        l: _normal(fontSize: 16, color: color.onSurface, fontWeight: FontWeight.w700),
        m: _normal(fontSize: 14, color: color.onSurface, fontWeight: FontWeight.w700),
        s: _normal(fontSize: 12, color: color.onSurface, fontWeight: FontWeight.w700),
      ),
      error: TextStyleSet(
        l: _normal(fontSize: 16, color: color.error),
        m: _normal(fontSize: 14, color: color.error),
        s: _normal(fontSize: 12, color: color.error),
      ),
      link: TextStyleSet(
        l: _normal(fontSize: 16, color: color.link, fontWeight: FontWeight.w700),
        m: _normal(fontSize: 14, color: color.link, fontWeight: FontWeight.w700),
        s: _normal(fontSize: 12, color: color.link, fontWeight: FontWeight.w700),
      ),
      handwriting: TextStyleSet(
        l: TextStyle(
          fontSize: 22,
          height: 1.6,
          color: color.onSurface,
          fontWeight: FontWeight.w600,
          fontFamily: Fonts.caveat.name,
          fontFamilyFallback: [Fonts.zenkurenaido.name],
          fontVariations: <FontVariation>[
            FontVariation('wght', _fontWeightToNumber(FontWeight.w600)),
          ],
        ),
        m: TextStyle(
          fontSize: 16,
          height: 1.6,
          color: color.onSurface,
          fontWeight: FontWeight.w600,
          fontFamily: Fonts.caveat.name,
          fontFamilyFallback: [Fonts.zenkurenaido.name],
          fontVariations: <FontVariation>[
            FontVariation('wght', _fontWeightToNumber(FontWeight.w600)),
          ],
        ),
        s: TextStyle(
          fontSize: 14,
          height: 1.6,
          color: color.onSurface,
          fontWeight: FontWeight.w600,
          fontFamily: Fonts.caveat.name,
          fontFamilyFallback: [Fonts.zenkurenaido.name],
          fontVariations: <FontVariation>[
            FontVariation('wght', _fontWeightToNumber(FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  static TextStyle _bold({required double fontSize, required Color color, FontWeight fontWeight = FontWeight.w900}) {
    return TextStyle(
      fontSize: fontSize,
      height: 1.2,
      color: color,
      fontWeight: fontWeight,
      fontFamily: Fonts.lexendDeca.name,
      fontFamilyFallback: [Fonts.notoSansJP.name],
      fontVariations: <FontVariation>[
        FontVariation('wght', _fontWeightToNumber(fontWeight)),
      ],
    );
  }

  static TextStyle _normal({required double fontSize, required Color color, FontWeight fontWeight = FontWeight.w400}) {
    return TextStyle(
      fontSize: fontSize,
      height: 1.2,
      color: color,
      fontWeight: fontWeight,
      fontFamily: Fonts.publicSans.name,
      fontFamilyFallback: [Fonts.notoSansJP.name],
      fontVariations: <FontVariation>[
        FontVariation('wght', _fontWeightToNumber(fontWeight)),
      ],
    );
  }
}

enum Fonts {
  lexendDeca('LexendDeca'),
  lexendGiga('LexendGiga'),
  publicSans('PublicSans'),
  caveat('Caveat'),
  notoSansJP('NotoSansJP'),
  zenkurenaido('ZenKurenaido');

  const Fonts(this.name);

  final String name;
}

class TextStyleSet {
  const TextStyleSet({required this.l, required this.m, required this.s});

  final TextStyle l;
  final TextStyle m;
  final TextStyle s;
}

double _fontWeightToNumber(FontWeight weight) => switch (weight) {
      FontWeight.w100 => 100,
      FontWeight.w200 => 200,
      FontWeight.w300 => 300,
      FontWeight.w400 => 400,
      FontWeight.w500 => 500,
      FontWeight.w600 => 600,
      FontWeight.w700 => 700,
      FontWeight.w800 => 800,
      FontWeight.w900 => 900,
      _ => throw ArgumentError('Invalid font weight: $weight'),
    };