import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacex/core/constants/app_constants.dart';
import 'package:spacex/model/mission_model.dart';
import 'package:spacex/views/screens/home/service/mission_service.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/provider/theme_provider.dart';
import '../../../core/view/widgets/text/locale_text.dart';
import '../../widgets/change_theme_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeView extends StatelessWidget {
  final List<String> _choices = [
    "TR",
    "EN",
  ];
  final MissionService missionService = MissionService();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: appBar(context, themeProvider),
      body: SingleChildScrollView(
        child: Container(
          color: themeProvider.themeMode == ThemeMode.dark
              ? Colors.grey.shade600
              : Colors.grey.shade300,
          child: SafeArea(
            child: FutureBuilder(
                future: missionService.fetchMission(),
                builder: (BuildContext context,
                    AsyncSnapshot<MissionModel> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
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
                              Text(snapshot.data!.name.toString()),
                              Image.network(
                                snapshot.data!.links.patch.small,
                              ),
                              Text(snapshot.data!.details.toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      print(snapshot.data!.links.webcast);
                                    },
                                    child: Text(
                                      'To watch Transporter-2 Mission Click',
                                      style: TextStyle(
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? Colors.amber
                                            : Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text("Loading at the moment, please hold the line.")
                      ],
                    ));
                  }
                }),
          ),
        ),
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
