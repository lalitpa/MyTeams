import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// to define the textsyle of Text widget
// can we used whenever needed the Text widget
TextStyle mystyle(double size,
    [Color color = Colors.black, FontWeight fw = FontWeight.w700]) {
  return GoogleFonts.montserrat(fontSize: size, color: color, fontWeight: fw);
}
