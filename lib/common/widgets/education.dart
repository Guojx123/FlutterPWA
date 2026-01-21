import 'package:flutter/material.dart';
import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';
import 'resume_theme.dart';

class Education extends StatelessWidget {
  final ContentEducation content;

  const Education(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    final desc1 = ResumeTheme.description1Text(context);
    final desc2 = ResumeTheme.description2Text(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 类型 + 年份
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              content.type,
              style: desc1?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              content.year,
              style: desc1?.copyWith(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // 学校 + 专业 + 成绩
        Text(
          content.name,
          style: desc2?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Expanded(
              child: Text(
                content.title,
                style: desc2,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              content.grade,
              style: desc2,
            ),
          ],
        ),

        const SizedBox(height: 6),

        // 描述
        if (content.description.isNotEmpty)
          Text(
            content.description,
            style: desc2?.copyWith(height: 1.5, color: Colors.grey[800]),
          ),

        const SizedBox(height: 16),
      ],
    );
  }
}
