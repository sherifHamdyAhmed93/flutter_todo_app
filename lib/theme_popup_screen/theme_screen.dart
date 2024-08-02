import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../colors/app_colors.dart';
import '../provider/app_theme_provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    AppThemeProvider provider = Provider.of<AppThemeProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              provider.changeAppTheme(ThemeMode.light);
            },
            child: provider.isCurrentAppThemeLight()
                ? setSelectedItem(AppLocalizations.of(context)!.day_mode,
                    provider.getSelectionColor())
                : setUnSelectedItem(AppLocalizations.of(context)!.day_mode),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              provider.changeAppTheme(ThemeMode.dark);
            },
            child: provider.isCurrentAppThemeLight() == false
                ? setSelectedItem(AppLocalizations.of(context)!.night_mode,
                    provider.getSelectionColor())
                : setUnSelectedItem(AppLocalizations.of(context)!.night_mode),
          )
        ],
      ),
    );
  }

  Widget setSelectedItem(String text, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: color, fontSize: 18),
        ),
        Icon(
          Icons.check,
          color: color,
          size: 25,
        )
      ],
    );
  }

  Widget setUnSelectedItem(String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: AppColors.blackColor, fontSize: 18),
    );
  }
}
