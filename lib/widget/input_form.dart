import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final IconData? prefixIcon;
  final IconButton? sufixIcon;
  final bool? obscureText;
  final String? hintTxt;
  final String? Function(String?)? validator;
  const LoginForm({
    Key? key,
    // this.title,
    this.controller,
    this.validator,
    this.inputType,
    this.obscureText,
    this.prefixIcon,
    this.sufixIcon,
    this.hintTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: const Color.fromARGB(146, 204, 228, 144),
      style: TextStyle(
        color: Colors.white.withOpacity(.9),
      ),
      obscureText: false,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.white.withOpacity(.8),
        ),
        border: InputBorder.none,
        hintMaxLines: 1,
        hintText: hintTxt,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.white.withOpacity(.5),
        ),
        suffixIcon: sufixIcon,
      ),
      validator: validator,
    );
  }
}

class InputForm extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Icon? prefixIcon;
  final String? helperTxt;
  final String? Function(String?)? validator;
  const InputForm(
      {Key? key,
      this.title,
      this.controller,
      this.validator,
      this.inputType,
      this.prefixIcon,
      this.helperTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          helperText: helperTxt,
          labelText: title,
          prefixIcon: prefixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: validator);
  }
}

class NonEditableForm extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  const NonEditableForm(
      {Key? key, this.title, this.controller, this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

// class InputImageForm extends StatelessWidget {
//   final String? title;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   const InputImageForm({Key? key, this.title, this.controller, this.validator})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: TextInputType.number,
//       autofocus: true,
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: title,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         prefixIcon: const Icon(Icons.image_outlined),
//       ),
//       onTap: ,
//       validator: validator,
//     );
//   }
// }
