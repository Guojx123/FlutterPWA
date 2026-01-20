import 'package:flutter/material.dart';
import 'package:template/app/data/models/content_interest.dart' show ContentInterest;

import 'resume_theme.dart';

class ResumeInterest extends StatelessWidget {
  final List<ContentInterest> interestList;

  const ResumeInterest({ super.key, required this.interestList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? 3
                    : 4),
        children: interestList.map((interest) {
          return Container(
            margin: EdgeInsets.all(2),
            child: Column(
              children: <Widget>[
                Icon(
                  interest.icon,
                  color: Theme.of(context).primaryColor,
                  size:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width / 6
                          : MediaQuery.of(context).size.width / 8,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  interest.title,
                  textAlign: TextAlign.center,
                  style: ResumeTheme.description2Text(context),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
