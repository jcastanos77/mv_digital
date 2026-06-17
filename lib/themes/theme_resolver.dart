import 'package:flutter/material.dart';
import 'package:mv_digital/themes/birthday_themes.dart';

import '../core/templates/sections/birthday/cowbow/cowboy_theme.dart';
import 'invitation_theme.dart';


InvitationTheme resolveBirthdayTheme(String? theme) {

  switch (theme) {

    case "cowboy":
      return CowboyTheme.theme;
      case "neon":
      return BirthdayThemes.neon;
    case "elegant":
      return BirthdayThemes.elegant;
    case "kari":
      return BirthdayThemes.kari;
    case "pool":
      return BirthdayThemes.pool;
    case "toystory":
      return BirthdayThemes.toyStory;

    default:
      return CowboyTheme.theme;

  }

}