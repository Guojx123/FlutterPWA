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

  static const double _sectionSpacing = 12;
  static const double _cardPadding = 14;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 自我介绍
          HeaderTitle(mTitle: TitleModel("自我介绍")),
          _content([_paragraph(resumeContent.aboutMe, context)]),

          SizedBox(height: _sectionSpacing),

          // 工作经历
          HeaderTitle(mTitle: TitleModel("工作经历")),
          _content([
            for (final workHistory in resumeContent.contentWorkHistories)
              ResumeWorkHistory(workHistory: workHistory)
          ]),

          SizedBox(height: _sectionSpacing),

          // 教育经历
          HeaderTitle(mTitle: TitleModel("教育经历")),
          _content([
            for (final education in resumeContent.contentEducation)
              Education(education)
          ]),

          SizedBox(height: _sectionSpacing),

          // 技能
          HeaderTitle(mTitle: TitleModel("技能")),
          _content([
            for (final skill in resumeContent.contentSkills)
              ResumeSkills(contentSkill: skill)
          ]),

          SizedBox(height: _sectionSpacing),

          // 项目经历
          HeaderTitle(mTitle: TitleModel("项目经历")),
          _content([
            for (final contentExperience in resumeContent.contentExperience)
              ResumeExperienceCard(experience: contentExperience)
          ]),

          SizedBox(height: _sectionSpacing),

          // 相关证书
          HeaderTitle(mTitle: TitleModel("相关证书")),
          _content([_paragraph(resumeContent.reference, context)]),
        ],
      ),
    );
  }

  /// 通用内容卡片
  Widget _content(List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      shadowColor: Colors.grey.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(_cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  /// 段落文本
  Widget _paragraph(String text, BuildContext context) {
    return Text(
      text,
      style: ResumeTheme.subTitleText(context)?.copyWith(height: 1.5),
      textAlign: TextAlign.justify,
    );
  }
}
