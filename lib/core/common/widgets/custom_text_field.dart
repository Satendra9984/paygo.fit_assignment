import 'package:flutter/material.dart';
import 'package:paygo_fit/core/common/res/colours.dart';

class CustomCollTextField extends StatefulWidget {
  const CustomCollTextField({
    required this.controller,
    required this.validator,
    super.key,
    this.labelText,
    this.onEditingCompleted,
    this.onSubmitted,
    this.onTapOutside,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxLines,
    this.hintText = '',
    this.prefixIcon,
  });
  final TextEditingController controller;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingCompleted;
  final void Function(PointerDownEvent)? onTapOutside;

  final String? labelText;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;

  final String hintText;
  final String? Function(String?) validator;

  @override
  State<CustomCollTextField> createState() => _CustomCollTextFieldState();
}

class _CustomCollTextFieldState extends State<CustomCollTextField> {
  bool _isObscure = false;

  @override
  void initState() {
    _isObscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(32);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              widget.labelText!,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          onEditingComplete: widget.onEditingCompleted,
          onFieldSubmitted: widget.onSubmitted,
          onTapOutside: widget.onTapOutside,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: _isObscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines,
          cursorHeight: 30,
          cursorWidth: 2.5,
          cursorColor: AppColours.primary,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () => setState(
                      () {
                        _isObscure = !_isObscure;
                      },
                    ),
                    icon: _isObscure
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )
                : null,
            labelStyle: const TextStyle(
              color: AppColours.textPrimaryBlack,
              fontWeight: FontWeight.w500,
            ),
            fillColor: AppColours.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: borderRadius, // Set the border radius here
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius, // Set the border radius here
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius, // Set the border radius here
              // borderSide: BorderSide(color: Colors.black),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius, // Set the border radius here
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: borderRadius, // Set the border radius here
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
