import 'package:flutter/material.dart';
import 'package:template/app/data/models/content_skills.dart';
import 'package:template/common/widgets/resume_theme.dart';

class ResumeSkills extends StatelessWidget {
  final ContentSkill contentSkill;

  const ResumeSkills({
    super.key,
    required this.contentSkill,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// 技能名称
          Expanded(
            flex: 3,
            child: Text(
              contentSkill.name,
              style: ResumeTheme.description2Text(context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 8),

          /// 技能等级
          Expanded(
            flex: 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: contentSkill.level.clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor:
                theme.primaryColor.withValues(alpha: 0.15),
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
