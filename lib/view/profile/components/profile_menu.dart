import 'package:flutter/material.dart';


class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    required this.text,
    required this.icon,
    required this.press,
  });

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        onPressed: press,
        child: Row(
          children: [
            ImageIcon(
              AssetImage(icon),
              size: 30,
              color: Colors.orange,
            ),
            SizedBox(width: 20),
            Expanded(child: Text(text, style: TextStyle(color: Colors.orange))),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
