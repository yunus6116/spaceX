import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex/core/constants/app_constants.dart';
import 'package:spacex/model/mission_model.dart';
import 'package:spacex/views/screens/home/service/mission_service.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/provider/theme_provider.dart';
import '../../../core/view/widgets/text/locale_text.dart';
import '../../widgets/change_theme_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeView extends StatelessWidget {
  final List<String> _choices = [
    "TR",
    "EN",
  ];
  launchWebsite(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final MissionService missionService = MissionService();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.themeMode == ThemeMode.dark
          ? Colors.grey.shade600
          : Colors.grey.shade300,
      appBar: appBar(context, themeProvider),
      body: body(themeProvider),
    );
  }

  Widget body(ThemeProvider themeProvider) {
    return SingleChildScrollView(
      child: Container(
        child: SafeArea(
          child: FutureBuilder(
              future: missionService.fetchMission(),
              builder:
                  (BuildContext context, AsyncSnapshot<MissionModel> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      missionContainer(context, snapshot, themeProvider),
                    ],
                  );
                } else {
                  return loadingContainer(context);
                }
              }),
        ),
      ),
    );
  }

  Container loadingContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: 20.0,
          ),
          LocaleText(
            text: LocaleKeys.home_loading,
          ),
        ],
      )),
    );
  }

  Container missionContainer(BuildContext context,
      AsyncSnapshot<MissionModel> snapshot, ThemeProvider themeProvider) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: [
          nameOfMission(snapshot, context),
          imageOfMission(context, snapshot),
          missionDetails(snapshot, context),
          toWatchMission(snapshot, themeProvider)
        ],
      ),
    );
  }

  Row toWatchMission(
      AsyncSnapshot<MissionModel> snapshot, ThemeProvider themeProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            launchWebsite(snapshot.data!.links.webcast);
          },
          child: LocaleText(
            text: LocaleKeys.home_to_watch,
            style: TextStyle(
              color: themeProvider.themeMode == ThemeMode.dark
                  ? Colors.amber
                  : Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Text missionDetails(
      AsyncSnapshot<MissionModel> snapshot, BuildContext context) {
    return Text(
      snapshot.data!.details.toString(),
      style: Theme.of(context).textTheme.subtitle2,
    );
  }

  Container imageOfMission(
      BuildContext context, AsyncSnapshot<MissionModel> snapshot) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      child: CachedNetworkImage(
        imageUrl: snapshot.data!.links.patch.small,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Container nameOfMission(
      AsyncSnapshot<MissionModel> snapshot, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
        top: 5,
      ),
      child: Text(
        snapshot.data!.name.toString(),
        style: Theme.of(context).textTheme.headline5,
      ),
    );
  }

  AppBar appBar(BuildContext context, ThemeProvider themeProvider) {
    return AppBar(
      title: appBarTitle(context),
      actions: [
        appBarActions(themeProvider, context),
      ],
    );
  }

  Widget appBarActions(ThemeProvider themeProvider, BuildContext context) {
    return Row(
      children: [
        LocaleText(
          text: themeProvider.themeMode == ThemeMode.dark
              ? LocaleKeys.dark
              : LocaleKeys.light,
        ),
        ChangeThemeButtonWidget(),
        selectLanguage(context),
      ],
    );
  }

  Widget selectLanguage(BuildContext context) {
    return Row(
      children: [
        Text(context.locale == AppConstant.EN_LOCALE ? 'EN' : 'TR'),
        PopupMenuButton<String>(
          icon: Icon(
            Icons.language,
          ),
          onSelected: (String choice) {
            if (choice == "TR") {
              context.setLocale(AppConstant.TR_LOCALE);
              print("TR");
            } else {
              context.setLocale(AppConstant.EN_LOCALE);
              print("EN");
            }
          },
          itemBuilder: (BuildContext context) {
            return _choices.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }

  LocaleText appBarTitle(BuildContext context) {
    return LocaleText(
      text: LocaleKeys.home_latest_mission_title,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
