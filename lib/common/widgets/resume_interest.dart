import 'package:flutter/material.dart';
import 'package:template/app/data/models/content_interest.dart';
import 'resume_theme.dart';

class ResumeInterest extends StatelessWidget {
  final List<ContentInterest> interestList;

  const ResumeInterest({
    super.key,
    required this.interestList,
  });

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;

    final crossAxisCount = orientation == Orientation.portrait ? 3 : 4;
    final iconSize =
    orientation == Orientation.portrait ? size.width / 6 : size.width / 8;

    return Padding(
      padding: const EdgeInsets.all(4),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: interestList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
        ),
        itemBuilder: (context, index) {
          final interest = interestList[index];
          return _InterestItem(
            interest: interest,
            iconSize: iconSize,
          );
        },
      ),
    );
  }
}

class _InterestItem extends StatelessWidget {
  final ContentInterest interest;
  final double iconSize;

  const _InterestItem({
    required this.interest,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            interest.icon,
            color: Theme.of(context).primaryColor,
            size: iconSize,
          ),
          const SizedBox(height: 8),
          Text(
            interest.title,
            textAlign: TextAlign.center,
            style: ResumeTheme.description2Text(context),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

