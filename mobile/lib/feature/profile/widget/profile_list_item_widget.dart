import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;
  final VoidCallback? onPressed;

  const ProfileListItem({
    Key? key,
    required this.icon,
    required this.text,
    this.color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ).copyWith(
          bottom: 10,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color ?? const Color(0xFFE5E9EF),
        ),
        child: InkResponse(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              Icon(
                this.icon,
                size: 30,
              ),
              SizedBox(width: 10),
              Text(
                this.text,
              ),
            ],
          ),
        ));
  }
}
