import 'package:flutter/material.dart';

class InputInfo extends StatefulWidget {
  String hint;
  IconData icon;
  InputInfo({required this.hint, required this.icon,Key? key}) : super(key: key);

  @override
  _InputInfoState createState() => _InputInfoState();
}

class _InputInfoState extends State<InputInfo> {
  String text = '';
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty||value.length<4){
          return 'Please enter at least 4 characters';
        }
      },
      onSaved: (value){
        text = value!;
      },
      onChanged: (value){
        text = value;
      },
      decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(35))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(35))),
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.all(10)),
    );
  }
}
