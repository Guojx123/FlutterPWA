import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/data/resumecontent/mustafa_resume_content.dart' show MustafaResumeContent;
import 'package:template/common/widgets/widget_index.dart';

import 'main_controller.dart';


class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget portfolio(BuildContext context) {
      return ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ResumeHeader(resumeContent: MustafaResumeContent.mContent),
          ResumeBody(resumeContent: MustafaResumeContent.mContent),
          ResumeFooter(),
        ],
      );
    }

    return Scaffold(
      body: portfolio(context),
    );

  }
}
