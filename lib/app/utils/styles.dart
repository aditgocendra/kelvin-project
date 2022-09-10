import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kelvin_project/app/utils/constant.dart';

class GlobalStyles {
  static InputDecoration formInputDecoration(String label) {
    return InputDecoration(
      contentPadding: const EdgeInsets.all(12.0),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(
          width: 1,
          color: primaryColor,
        ),
      ),
      labelText: label,
      floatingLabelStyle: const TextStyle(color: primaryColor),
    );
  }

  static DropDownDecoratorProps dropdownDecoration(String label) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.0, color: primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14),
        floatingLabelStyle: const TextStyle(color: primaryColor),
      ),
    );
  }
}
