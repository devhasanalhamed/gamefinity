import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final bool obSecure;
  const CustomTextField({
    Key? key,
    required this.title,
    required this.obSecure,
  }) : super(key: key);

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          key: UniqueKey(),
          decoration: InputDecoration(
            label: Text(widget.title),
            floatingLabelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.orange,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          obscureText: widget.obSecure,
          onSaved: (newValue) => {},
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
