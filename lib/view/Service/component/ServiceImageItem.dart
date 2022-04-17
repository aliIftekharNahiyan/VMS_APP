import 'package:amargari/widgets/ImageFullScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ServiceImageItem extends StatefulWidget {
  ServiceImageItem({
    required this.textTitle,
    required this.image,
  });

  final String textTitle, image;
  @override
  _ServiceImageItemState createState() => _ServiceImageItemState();
}

class _ServiceImageItemState extends State<ServiceImageItem> {
  @override
  void initState() {
    super.initState();
    print(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(widget.textTitle, style: TextStyle(fontSize: 15)),
          ),
          SizedBox(width: 1),
          Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageFullScreen(imageURL: widget.image)
                    )        
                  );
                },
                child: widget.image == ""
                    ? Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                          "assets/icons/edit_image.png",
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                          color: Colors.black,
                        ),
                    )
                    : Container(
                        alignment: Alignment.centerLeft,
                        child: CachedNetworkImage(
                          imageUrl: widget.image,
                          placeholder: (context, url) => Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => ImageIcon(
                              AssetImage("assets/icons/edit_image.png")),
                          height: 70,
                        ),
                      ),
              )),
          SizedBox(width: 1),
        ],
      ),
    );
  }
}
//
