import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final Color color;
  final String iconCustom;
  final Function function;
  final String text;
  LargeButton(
      {@required this.color,
      @required this.iconCustom,
      @required this.function,
      @required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: SizedBox.expand(
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                child: SizedBox(
                  child: Image.asset(iconCustom),
                  height: 28,
                  width: 28,
                ),
              ),
            ],
          ),
          onPressed: function,
        ),
      ),
    );
  }
}
