import 'package:flutter/material.dart';

// Text(
// 'Nome',
// style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// ),
// SizedBox(height: 5),
// TextField(
// decoration: InputDecoration(
// hintText: 'Digite o nome',
// border: OutlineInputBorder(),
// hintStyle: TextStyle(fontSize: 12)),
// ),

class CustomTextfield extends StatelessWidget {
  final String titulo, hint;
  final TextEditingController textEditingController;

  const CustomTextfield(
      {Key key, this.titulo, this.hint, this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
              hintStyle: TextStyle(fontSize: 12)),
          controller: textEditingController,
        ),
      ],
    );
  }
}