import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final String titulo;
  final Color? colorFocus;
  final double? borderRadius;
  final TextInputType? tipoInput;
  final String? labelInput;
  final double? marginInput;
  final TextEditingController? controller;
  final bool? soloLectura;
  final VoidCallback? callBack;
  final String? Function(String?)? validacion;

  const Inputs({
    super.key,
    required this.titulo,
    this.colorFocus,
    this.borderRadius,
    this.tipoInput,
    this.labelInput,
    this.marginInput,
    this.controller,
    this.soloLectura,
    this.callBack,
    required this.validacion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: marginInput ?? 2.2),
      child: TextFormField(
        readOnly: soloLectura ?? false,
        controller: controller,
        style: const TextStyle(fontSize: 22, letterSpacing: 1.5),
        decoration: InputDecoration(
            label: Text(labelInput ?? ""),
            hintText: titulo,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorFocus ?? Colors.white),
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10))),
            border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRadius ?? 10)))),
        keyboardType: tipoInput ?? TextInputType.text,
        validator: validacion,
      ),
    );
  }
}
