import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/app/data/resumecontent/mustafa_resume_content.dart' show MustafaResumeContent;
import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';
import '../../../common/i18n/translation_keys.dart';
import '../../../common/widgets/app_badge.dart';
import '../discover/discover_view.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import 'main_controller.dart';
import 'package:template/common/widgets/widget_index.dart';
import 'package:template/app/data/models/model_index.dart';


class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget portfolio(BuildContext context) {
      return SafeArea(
        child: ListView(
          children: <Widget>[
            ResumeHeader(resumeContent: MustafaResumeContent.mContent),
            ResumeBody(resumeContent: MustafaResumeContent.mContent),
            ResumeFooter(),
          ],
        ),
      );
    }

    return Scaffold(
      body: portfolio(context),
    );

  }
}
