
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
      scaffoldBackgroundColor: Colors.grey[100],
      cardColor: Colors.grey[300],
      hintColor: Colors.grey[800],
      textTheme: TextTheme(
        titleMedium: GoogleFonts.poppins(
          color: Colors.grey[900],
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.24
        ),
        labelMedium: GoogleFonts.poppins(
          color: Colors.grey[800],
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        labelSmall:  GoogleFonts.poppins(
          color: Colors.grey[700],
          fontSize: 13,
          fontWeight: FontWeight.w400,
        )
      ),  
); 

ThemeData darkMoode = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.grey[900],
  hintColor: Colors.grey[300],
        textTheme: TextTheme(
        titleMedium: GoogleFonts.poppins(
          color: Colors.grey[200],
          fontSize: 26,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.24
        ),
        labelMedium: GoogleFonts.poppins(
          color: Colors.grey[300],
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        labelSmall:  GoogleFonts.poppins(
          color: Colors.grey[400],
          fontSize: 13,
          fontWeight: FontWeight.w700,
        )
      ),  
);