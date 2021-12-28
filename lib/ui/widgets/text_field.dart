import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_taksu/ui/shared/styles.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? message;

  const CustomTextField({Key? key, this.label, this.controller, this.hint, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? "Label",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
              color: softBlack, borderRadius: BorderRadius.circular(5)),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return message;
              }
              return null;
            },
            cursorColor: Colors.white,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            decoration: InputDecoration(
              hintText: hint ?? "Type here ..",
              hintStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: softBlack,
                  width: 0.0,
                ),
              ),
              enabled: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: softBlack,
                  width: 0,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: softBlack,
                  width: 1,
                ),
              ),
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }
}
