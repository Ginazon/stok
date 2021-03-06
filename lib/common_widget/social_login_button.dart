

import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String butonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double yukseklik;
  final Widget butonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      this.butonText,
      this.butonColor,
      this.textColor,
      this.radius:16,
      this.yukseklik,
      this.butonIcon,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: yukseklik,
        child: RaisedButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Spreads, Collection-if, Collection-For
              if (butonIcon != null) ...[
                butonIcon,
                Text(
                  butonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
                Opacity(opacity: 0, child: butonIcon)
              ],
              if (butonIcon == null) ...[
                Container(),
                Text(
                  butonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
                Container(),
              ]
            ],
          ),
          color:butonColor,
        ),
      ),
    );
  }


}

