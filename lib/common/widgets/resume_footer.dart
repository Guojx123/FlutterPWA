import 'package:flutter/material.dart';
import 'package:template/common/widgets/widget_index.dart';

class ResumeFooter extends StatelessWidget {
  const ResumeFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: FooterBackgroundDark(),
          child: Container(
            height: 50,
            color: Theme.of(context).primaryColor,
          ),
        ),
        ClipPath(
          clipper: FooterBackgroundLight(),
          child: Container(
            height: 50,
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ],
    );
  }
}
