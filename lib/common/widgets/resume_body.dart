import 'package:flutter/material.dart';
import 'package:template/common/widgets/resume_skills.dart';
import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';



class ResumeBody extends StatelessWidget {
  final ResumeContent resumeContent;

  const ResumeBody({
     super.key,
    required this.resumeContent,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final mQ = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          HeaderTitle(mTitle: TitleModel("About Me")),
          _content([_paragraph(resumeContent.aboutMe, context)]),
          HeaderTitle(mTitle: TitleModel("Education")),
          _content(
            [
              for (ContentEducation eduction in resumeContent.contentEducation)
                Education(eduction)
            ],
          ),
          HeaderTitle(
            mTitle: TitleModel("Skills"),
          ),
          _content([
            for (ContentSkill skill in resumeContent.contentSkills)
              ResumeSkills(contentSkill: skill)
          ]),
          HeaderTitle(
            mTitle: TitleModel("Work History"),
          ),
          _content([
            for (ContentWorkHistory workHistory
                in resumeContent.contentWorkHistories)
              ResumeWorkHistory(workHistory: workHistory)
          ]),
          HeaderTitle(
            mTitle: TitleModel("Community Work"),
          ),
          _content([
            for (ContentExperience contentExperience
                in resumeContent.communityWorkList)
              ResumeExperience(experience: contentExperience)
          ]),
          HeaderTitle(
            mTitle: TitleModel("Experience"),
          ),
          _content([
            for (ContentExperience contentExperience
                in resumeContent.contentExperience)
              ResumeExperience(experience: contentExperience)
          ]),
          HeaderTitle(
            mTitle: TitleModel("Hobbies and Interests"),
          ),
          _content([
            ResumeInterest(interestList: resumeContent.interestList),
          ]), // update hobbies and Interest with icons and description form
          HeaderTitle(
            mTitle: TitleModel("Reference"),
          ),
          _content([_paragraph(resumeContent.reference, context)]),
        ],
      ),
    );
  }

  Widget _content(List<Widget> children) {
    return Card(
      margin: EdgeInsets.only(bottom: 5),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: children),
      ),
    );
  }

  Widget _paragraph(String text, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        style: ResumeTheme.description2Text(context),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
