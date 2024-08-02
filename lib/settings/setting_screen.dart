import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_todo_app/colors/app_colors.dart';
import 'package:provider/provider.dart';

import '../Language_popup_screen/language_screen.dart';
import '../provider/app_language_provider.dart';
import '../provider/app_theme_provider.dart';
import '../theme_popup_screen/theme_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    AppLanguageProvider provider = Provider.of<AppLanguageProvider>(context);
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.04,
        vertical: MediaQuery.of(context).size.width * 0.08,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLanguageWidget(provider, themeProvider),
          SizedBox(
            height: 30,
          ),
          _buildThemeWidget(themeProvider)
        ],
      ),
    );
  }

  Widget _buildLanguageWidget(
      AppLanguageProvider provider, AppThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.language}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: _showActionSheetForLanguage,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: themeProvider.getFieldBackgroundColor(),
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${provider.getCurrentLanguageName(context)}',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildThemeWidget(AppThemeProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppLocalizations.of(context)!.theme}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: _showActionSheetForTheme,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: provider.getFieldBackgroundColor(),
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  provider.getCurrentThemeName(context),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                  color: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showActionSheetForLanguage() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return LanguageScreen();
        });
  }

  void _showActionSheetForTheme() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ThemeScreen();
        });
  }
}
