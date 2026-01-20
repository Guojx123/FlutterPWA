import 'package:flutter/material.dart';
import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';

class HeaderTitle extends StatelessWidget {
  final TitleModel mTitle;

  const HeaderTitle({ super.key, required this.mTitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomClipPath(10),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              width: MediaQuery.of(context).size.width * 0.75,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "",
                  style: ResumeTheme.titleText(context),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          ClipPath(
            clipper: CustomClipPath(5),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  mTitle.title,
                  style: ResumeTheme.titleText(context),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  CustomClipPath(this.radius);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - radius);
    path.quadraticBezierTo(size.width * 0.9, radius, size.width * 0.75, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
