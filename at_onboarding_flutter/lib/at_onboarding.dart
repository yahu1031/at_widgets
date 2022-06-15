import 'package:at_onboarding_flutter/screen/at_onboarding_activate_screen.dart';
import 'package:at_onboarding_flutter/screen/at_onboarding_reset_screen.dart';
import 'package:at_onboarding_flutter/services/at_onboarding_backup_service.dart';
import 'package:at_onboarding_flutter/services/onboarding_service.dart';
import 'package:at_onboarding_flutter/utils/at_onboarding_app_constants.dart';
import 'package:flutter/material.dart';

import 'at_onboarding_result.dart';
import 'screen/at_onboarding_backup_screen.dart';
import 'screen/at_onboarding_home_screen.dart';
import 'screen/at_onboarding_intro_screen.dart';
import 'services/at_onboarding_config.dart';
import 'screen/at_onboarding_start_screen.dart';

class AtOnboarding {
  static Future<AtOnboardingResult> onboard({
    required BuildContext context,
    required AtOnboardingConfig config,
  }) async {
    AtOnboardingConstants.setApiKey(config.appAPIKey ??
        (AtOnboardingConstants.rootEnvironment.apikey ?? ''));
    AtOnboardingConstants.rootDomain =
        config.domain ?? AtOnboardingConstants.rootEnvironment.domain;
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AtOnboardingStartScreen(config: config),
    );
    if (result is AtOnboardingResult) {
      if (result.status == AtOnboardingResultStatus.success) {
        if (await AtOnboardingBackupService.instance.shouldOpenBackup() ==
            true) {
          await AtOnboardingBackupScreen.push(context: context);
        }
      }
      return result;
    } else {
      return AtOnboardingResult.cancelled();
    }
  }

  // static Future<bool?> checkAccount({
  //   required BuildContext context,
  // }) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return const AtOnboardingIntroScreen();
  //       },
  //     ),
  //   );
  //   return result;
  // }

  static Future<AtOnboardingResult> start({
    required BuildContext context,
    required AtOnboardingConfig config,
    VoidCallback? onSuccess,
    VoidCallback? onError,
  }) async {
    AtOnboardingConstants.setApiKey(config.appAPIKey ??
        (AtOnboardingConstants.rootEnvironment.apikey ?? ''));
    AtOnboardingConstants.rootDomain =
        config.domain ?? AtOnboardingConstants.rootEnvironment.domain;
    final haveAnAtsign = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const AtOnboardingIntroScreen();
        },
      ),
    );

    if (haveAnAtsign != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return AtOnboardingHomeScreen(
              config: config,
              haveAnAtsign: haveAnAtsign ?? true,
            );
          },
        ),
      );

      if (result is AtOnboardingResult) {
        return result;
      } else {
        return AtOnboardingResult.cancelled();
      }
    } else {
      return AtOnboardingResult.cancelled();
    }
  }

  static Future<AtOnboardingResult> activateAccount({
    required BuildContext context,
  }) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const AtOnboardingActivateScreen(
        hideReferences: false,
      );
    }));
    if (result is AtOnboardingResult) {
      return result;
    } else {
      return AtOnboardingResult.cancelled();
    }
  }

  static Future<bool> changePrimaryAtsign({required String atsign}) async {
    return await OnboardingService.getInstance()
        .changePrimaryAtsign(atsign: atsign);
  }

  static Future<AtOnboardingResult> reset({
    required BuildContext context,
    required AtOnboardingConfig config,
  }) async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return AtOnboardingResetScreen(config: config);
    }));
    if (result is AtOnboardingResult) {
      return result;
    } else {
      return AtOnboardingResult.cancelled();
    }
  }
}
