import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panda_technician/services/validationServices.dart';

class TextFiledCustom extends StatefulWidget {
  TextFiledCustom(
      {super.key,
      required this.updateCallback,
      required this.preIcon,
      required this.hintText,
      required this.isPassword,
      required this.isZipCode,
      required this.isEmail,
      required this.isNumber,
      this.password = "",
      this.width = 340,
      this.height = 50,
      this.isError = false,
      this.isState = false,
      
      this.isCity = false,
      this.useController = false,
      this.isStreet = false,
      this.isEditable = true,
      this.isUpdated = false,
      
      });
  Function updateCallback;
  IconData preIcon;
  String hintText;
  bool isPassword;
  bool isZipCode = false;
  bool isEmail = false;
  bool isNumber = false;
  String password = "";
  double width = 340;
  double height = 50;
  bool isCity;
  bool isError = false;
  bool useController = false;
  bool isState = false;
  bool isStreet = false;
  bool isEditable = true;
  bool isUpdated = false;
  

  @override
  State<TextFiledCustom> createState() => _TextFiledCustomState();
}

class _TextFiledCustomState extends State<TextFiledCustom> {
  var email = "";
  var password = "";
  var _passwordVisibleConfirmation = true;
  var isEmailValid = true;
  var correctPassword = true;
  var passwordValue = "";

TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    email = "";
    password = "";
    _passwordVisibleConfirmation = true;
    isEmailValid = true;
    correctPassword = true;
    controller.text = widget.hintText;
controller.addListener(onChangeValue);
  }

  void onChangeValue(){
                  widget.updateCallback(controller.text);

        controller.selection =
          TextSelection.collapsed(offset: controller.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return (widget.useController)?
    Container(
            width: widget.width,
        
            height: widget.height,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: (widget.isError)?
                    Colors.red :
                   widget.isEmail
                      ? (isEmailValid
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.red)
                      :  Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              enabled: widget.isEditable,
              maxLength: widget.isZipCode ? 5 : null,
              keyboardType: widget.isZipCode || widget.isNumber
                  ? TextInputType.number
                  :  TextInputType.text,
                controller: controller,
              onChanged: (value) {
                if (widget.isEmail) {
                  setState(() {
                    isEmailValid = emailValidate(value);
                  });
                  widget.updateCallback(value);
                } else {
                  widget.updateCallback(value);
                }
              },
              style: const TextStyle(fontSize: 16),
              cursorWidth: 1,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: widget.hintText,
                prefixIcon: Icon(widget.preIcon),
              ),
            ))
    :
    
       (!widget.isPassword
        ? Container(
            width: widget.width,
            height: widget.height,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: (widget.isError)?
                    Colors.red :
                   widget.isEmail
                      ? (isEmailValid
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.red)
                      :  Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: TextField(
              
                   inputFormatters: <TextInputFormatter>[
                     (widget.isState)?
      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")) :
            FilteringTextInputFormatter.deny(RegExp("")) 
,
  ], 
              maxLength: widget.isZipCode ? 5 : null,
              keyboardType: widget.isZipCode || widget.isNumber
                  ? TextInputType.number
                  :  TextInputType.text,
              onChanged: (value) {
                if (widget.isEmail) {
                  setState(() {
                    isEmailValid = emailValidate(value);
                  });
                  widget.updateCallback(value);
                } else {
                  widget.updateCallback(value);
                }
              },
              style: const TextStyle(fontSize: 16),
              cursorWidth: 1,
              decoration: InputDecoration(
                counterText: '',
                border: InputBorder.none,
                hintText: widget.hintText,
                prefixIcon: Icon(widget.preIcon),
              ),
            ))
        : Container(
            width: widget.width,
            height: 50,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                  (widget.isError)?
                    Colors.red :
                   (widget.password == passwordValue || widget.password == "")?
                      
                           Colors.grey.withOpacity(0.2)
                          : Colors.red,
                     
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                
                if (widget.password != value) {
                  
                  setState(() {
                    correctPassword = false;
                    passwordValue = value;
                  });
                } else {
                  setState(() {
                    correctPassword = true;
                    passwordValue = value;
                  });
                }
                widget.updateCallback(value);
              },
              obscureText: _passwordVisibleConfirmation,
              autocorrect: false,
              inputFormatters: [],
              style: const TextStyle(fontSize: 16),
              cursorWidth: 1,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText == ""? "Password" : widget.hintText,
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisibleConfirmation
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisibleConfirmation =
                            !_passwordVisibleConfirmation;
                      });
                    },
                  )),
            )));
  }
}
