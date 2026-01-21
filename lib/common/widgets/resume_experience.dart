import 'package:flutter/material.dart';
import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';
import 'resume_theme.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeExperienceCard extends StatelessWidget {
  final ContentExperience experience;

  const ResumeExperienceCard({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    final titleStyle =
    ResumeTheme.titleExperienceText(context)?.copyWith(fontWeight: FontWeight.bold);
    final descStyle = ResumeTheme.description2Text(context)?.copyWith(height: 1.5);
    final featureStyle = ResumeTheme.description2Text(context)?.copyWith(height: 1.5);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            experience.title,
            style: titleStyle,
          ),
          children: [
            // 描述
            if (experience.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12,left: 12,right: 12),
                child: Text(
                  experience.description,
                  style: descStyle,

                  textAlign: TextAlign.justify,
                ),
              ),

            // 功能亮点
            if (experience.features.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: experience.features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6,left: 12,right: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• ", style: featureStyle),
                        Expanded(
                          child: Text(
                            feature,
                            style: featureStyle,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            // 链接
            if (experience.link.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Linkify(
                  text: experience.link,
                  style: featureStyle?.copyWith(color: Colors.blue),
                  linkStyle: featureStyle?.copyWith(
                      color: Colors.blue, decoration: TextDecoration.underline),
                  onOpen: _onOpen,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onOpen(LinkableElement link) async {
    final uri = Uri.parse(link.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch ${link.url}';
    }
  }
}
