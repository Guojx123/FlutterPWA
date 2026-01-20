import 'package:flutter/material.dart';
import 'package:template/app/data/models/content_skills.dart';
import 'package:template/common/widgets/resume_theme.dart';

class ResumeSkills extends StatelessWidget {
  final ContentSkill contentSkill;

  const ResumeSkills({super.key, required this.contentSkill});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              contentSkill.name,
              style: ResumeTheme.description2Text(context),
            ),
          ),
          Expanded(
            flex: 7,
            child: LinearProgressIndicator(
              value: contentSkill.level,
            ),
          ),
        ],
      ),
    );
  }
}
