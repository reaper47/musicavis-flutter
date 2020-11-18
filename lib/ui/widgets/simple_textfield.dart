import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SimpleTextField extends StatefulWidget {
  final TextInputType type;
  final TextEditingController controller;

  SimpleTextField({
    this.type,
    this.controller,
  });

  @override
  _SimpleTextFieldState createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  TextEditingController _controller;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    TextInputFormatter formatters;
    if (widget.type == TextInputType.number) {
      formatters = FilteringTextInputFormatter.digitsOnly;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: TextField(
        keyboardType: widget.type,
        controller: widget.controller,
        inputFormatters: [formatters],
        autocorrect: true,
        textAlign: TextAlign.center,
        maxLength: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
