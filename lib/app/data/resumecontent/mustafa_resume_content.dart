import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:template/app/data/models/model_index.dart';

class MustafaResumeContent {
  static ResumeContent mContent = ResumeContent(
      profileInformation: ProfileInformation(
          name: "郭君贤-Gino",
          designation: "客户端开发工程师",
          email: "hdb41348@163.com",
          github: "https://github.com/Guojx123",
          linkedIn: "",
          stackOverFlow: "",
          contactNumber: "19129280128",
          wechat: "Johe-0128",
          intendedPosition: "25k-30k 广州",
      ),
      aboutMe:
          "1、近五年的项目实战经验，独立开发期间培养了自己较强的独立分析、解决问题的能力。\n"
          "2、熟练使用Flutter框架，进行安卓、iOS等平台的开发工作，并完成构建打包、上线发布流程。\n"
          "3、在工作期间，也具有良好的团队协作能力，熟练使用SVN、Git工具管理代码，协同开发。\n"
          "4、富有上进心和团队精神，与人为善、责任心强并能承受工作压力，有良好的心理素质。\n"
          "5、生活作息比较规律，偶尔早起跑步，室内健身三年多。",
      reference: "院奖学金三等奖\n院网页设计比赛三等奖\nERP沙盘模拟比赛一等奖\n全国计算机设计大赛校内选拔赛三等奖",
      contentWorkHistories: [
    ContentWorkHistory(
      companyName: "广东很久文化传播有限公司",
      designation: "客户端开发组长",
      duration: "2023.2 - 至今",
      description:
          "1、负责部门孵化一组中跨平台应用开发（问先生、万宗起名、一点倾诉）开发工作。\n"
          "2、定期进行技术分享（Git使用技巧、跨平台方案：Flutter在其中承担的角色等）。\n"
          "3、Flutter布道，搭建公司Flutter项目框架，制定一整套开发规范。\n",
      isCurrent: true,
    ),
    ContentWorkHistory(
      companyName: "广州摩航时代信息科技有限公司",
      designation: "客户端开发工程师",
      duration: "2021.12 - 2023.2",
      description: "1、使用Flutter技术栈，进行跨端、跨境相关业务（Disoo、OrderPin）开发，完成编码和自测工作，并及时CodeReview。\n"
          "2、参与公司Flutter整体框架的搭建，业务组件的统一设计以及启动性能调优的工作。\n"
          "3、使用Google提供的Firebase云平台，监控应用的总体运行状况、异常自动上报以及跟踪用户操作路径，为减少应用闪退、提高应用流畅度提供解决思路。\n"
          "4、调研并实现Flutter动态化方案，采用Flutter渲染页面+Vue页面编辑管理后台，负责其中业务组件、事件注册等模块开发，以满足市场运营的动态页面下发需求。\n",
      isCurrent: false,
    ),
    ContentWorkHistory(
      companyName: "广州紫鲸互联网科技有限公司",
      designation: "Flutter开发工程师",
      duration: "2020.12 - 2021.12",
      description: "1、第一批使用Flutter跨平台框架，构建Android、iOS应用并顺利上线。\n"
          "2、跟进产品新版本的需求梳理和产品设计，一个多月独自完成应用开发，满足需求快速实现、新功能上线的需求。\n"
          "3、负责公司册多多电商项目、速百读电子阅读社区等项目的开发，上线打包发版，并负责项目后期维护工作。\n",
      isCurrent: false,
    ),
  ],
      contentEducation: [
        ContentEducation(
            type: "本科",
            name: "广东海洋大学寸金学院（现湛江科技学院）",
            title: "计算机科学与技术 智能制造学院",
            grade: "3.2 CGPA",
            year: "2016.9- 2020.6",
            description: "湛江科技学院由原广东海洋大学寸金学院转设而成。学校创办于1999年，2006年被批准为独立学院，2011年获学士学位授予权，2013年通过广东省教育厅独立学院本科教学基本状态评估，2021年经教育部批准转设为湛江科技学院。"),
      ],
      contentSkills: [
        ContentSkill(
          name: "Dart（Flutter框架）",
          level: 0.9,
        ),
        ContentSkill(
          name: "GetX、Bloc状态管理",
          level: 0.8,
        ),ContentSkill(
          name: "Firebase",
          level: 0.7,
        ),
        ContentSkill(
          name: "Android（Kotlin）",
          level: 0.5,
        ),ContentSkill(
          name: "iOS（Swift）",
          level: 0.7,
        ),
        ContentSkill(
          name: "CI/CD",
          level: 0.6,
        ),
      ],
      contentExperience: [
        ContentExperience(
            title: "一点倾诉-疗愈直播、一对一连麦咨询",
            description: "是一片温柔之地，让每一次轻声倾诉，都能被静静聆听。是一种轻盈而温暖的仪式，让你在静谧的空间中，将心事轻轻放下，也让心灵重新获得平衡。它承载着理解与陪伴，如心塔般稳固而明亮，悄悄为你照亮前行的路。无论孤独、困惑还是疑惑，这一点倾诉都如一盏心灯，温柔而坚定地陪伴你。",
            features: [
              '在基础聊天功能上线后，进行 IM 系统重构，实现完全自定义聊天界面、消息类型和逻辑，为用户提供更丰富的交互体验。',
              '使用腾讯云 TRTC/Live SDK 完成直播功能，从推流、拉流到多端适配，支持低延迟音视频传输和多路连麦，满足一对多互动及实时互动需求。'
            ],
            link: ""),
        ContentExperience(
            title: "问先生-婚恋情感咨询，一对一聊天",
            description:
            "婚恋、情感咨询平台，客户端实现用户聊天，主要功能有发送文本、语音、视频，消息引用等，还包括一键登陆、消息推送、iOS应用内购等。",
            features: [
              '耗时46天，从零到一构建聊天应用，并顺利上线到Android、iOS平台。',
              '使用Socket，接入服务中心客服与虚拟机器人聊天，通过本地修改插件，实现自定义一对一私密聊天功能。',
              '之后重构IM，接入服务中心客服、虚拟机器人聊天，完全自定义聊天功能。'
            ],
            link: ""),
        ContentExperience(
            title: "万宗起名-起名解名测名改名",
            description:
            "帮助新生宝宝起名，对接起名AI算法，客户端实现支付宝、微信第三方支付，主要功能有起名、解名等，应用内使用了大量画笔绘制组件，丰富的界面设计、动画实现。",
            features: [
              '协助APP1组，完成旧项目Flutter改造升级，负责项目前期搭建，起名、解名、档案服务模块开发，其中还包括V3后台、远程付费点服务、在线配置等原生插件的重构，并顺利上线苹果应用市场',
            ],
            link: ""),
        ContentExperience(
            title: "Disoo-生活服务平台",
            description:
            "国外版的大众点评，主要服务于土耳其用户，客户端实现首页动态化、国际化、对接第三方茄子支付、快捷评价等，还包括应用性能优化、营销类动画实现、广告接入。",
            features: [
              '使用一周时间，开发出Deck动态化业务插件，经过测试部门功能、性能测试并投入生产使用。',
              '应用冷启动、首屏加载相关优化，提升应用运行时流畅度24%，降低应用闪退几率12%等其他提升。',
            ],
            link: ""),
        ContentExperience(
            title: "OrderPin-电子菜单，点餐Pos系统",
            description:
            "电子菜单商家端，支持用户扫码点餐、Pos机点餐、对接打印机自动打印订单和后厨单，还包括桌台管理多维度的营业报表、菜品编辑、会员卡、自配送服务等特点。",
            features: [
              '为了提高订单通知、打印订单的实时性，使用WebSocket代替FCM，提高消息触达率至100%，延迟降低至1s内。',
              '构建批量生成桌台码工具，将重复性的工作使用工具自动化生成并打包上传，目前该工具已生成超过1.6w张桌台码，服务超过1.5k家店铺。',
              '参与公司0rderPin项目客户端重构，使用SwiftUI框架，其中主要负责首页、订单模块的重构,两周时间内开发完并通过测试，两月后顺利上线。'
            ],
            link: ""),

      ],contentProjects: [
    ContentExperience(
        title: "问答君-自建题库、答题社区",
        description:
        "",
        features: [
          '使用Flutter开发，使用GetX框架，实现了题库、答题、社区等功能。',
           ],
        link: "https://github.com/Guojx123/questwer_flu"),
  ],
      );
}
