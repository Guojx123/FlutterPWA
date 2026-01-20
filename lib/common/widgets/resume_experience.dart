import 'package:flutter/material.dart';

import 'dart:async';

import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';

import 'package:flutter_linkify/flutter_linkify.dart';

import 'package:url_launcher/url_launcher.dart';

class ResumeExperience extends StatelessWidget {
  final ContentExperience experience;

  const ResumeExperience({ super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        experience.title,
        style: ResumeTheme.titleExperienceText(context),
        textAlign: TextAlign.left,
      ),
      children: <Widget>[
        Builder(
          builder: (context) {
            if (experience.description.length > 0) {
              return Container(
                padding: EdgeInsets.only(left: 11, right: 11),
                child: Text(
                  experience.description,
                  style: ResumeTheme.description2Text(context),
                  textAlign: TextAlign.justify,
                ),
              );
            } else {
              return SizedBox(
                height: 1,
              );
            }
          },
        ),
        Builder(
          builder: (context) {
            if (experience.link.isNotEmpty) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: experience.description.isNotEmpty ? 10 : 0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.open_in_new,
                          size: 14,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Linkify(
                          text: experience.link,
                          onOpen: _onOpen,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return SizedBox(
                height: 1,
              );
            }
          },
        ),
    //          Divider(
    //            height: 1,
    //          )
      ],
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }
}
