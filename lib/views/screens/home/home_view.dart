import 'package:flutter/material.dart';
import 'package:spacex/core/init/lang/locale_keys.g.dart';
import 'package:spacex/core/view/widgets/text/locale_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocaleText(
          text: LocaleKeys.home_latest_mission_title,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.language),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.color_lens),
          ),
        ],
      ),
      body: Center(
        child: Text('Hi'),
      ),
    );
  }
}
