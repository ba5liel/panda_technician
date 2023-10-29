import 'package:flutter/material.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List options;
  final T value;
  final  Function getLabel;
  final  Function onChanged;

  AppDropdownInput({
    this.hintText = 'Street',
    this.options = const [],
    required this.getLabel,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
            width: 340,
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: true? Colors.grey.withOpacity(0.2)
                          : Colors.red,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.location_city),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: hintText,
            
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: ((value){
                onChanged(value);
              }),
              items: options.map((value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    ));
  }
}