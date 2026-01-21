import 'package:flutter/material.dart';
import 'package:template/app/data/models/content_work_history.dart';
import 'resume_theme.dart';

class ResumeWorkHistory extends StatelessWidget {
  final ContentWorkHistory workHistory;

  const ResumeWorkHistory({super.key, required this.workHistory});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧竖线
          Container(
            margin: const EdgeInsets.only(right: 12, top: 4),
            width: 3,
            height: 42,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: BorderRadius.circular(1.5),
            ),
          ),

          // 右侧内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 公司名 + 时间
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      workHistory.companyName,
                      style: ResumeTheme.description1Text(context)?.copyWith(
                        fontWeight: FontWeight.bold,
                        color:  theme.primaryColor ,
                      ),
                    ),
                    Text(
                      workHistory.duration,
                      style: ResumeTheme.description2Text(context)?.copyWith(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // 职位
                Text(
                  workHistory.designation,
                  style: ResumeTheme.description2Text(context)?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[800],
                  ),
                ),

                const SizedBox(height: 12),

                // 描述
                Text(
                  workHistory.description,
                  style: ResumeTheme.description2Text(context)?.copyWith(
                    height: 1.5, // 行高
                    color: Colors.grey[800],
                  ),
                ),

                const SizedBox(height: 4),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
