import 'package:flutter/widgets.dart';

class TextEditingControllerWithEndCursor extends TextEditingController {

  TextEditingControllerWithEndCursor({
    required String text
  }): super(text: text);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection(
        baseOffset: newText.length,
        extentOffset: newText.length
      ),
      composing: TextRange.empty,
    );
  }
}