import 'package:flutter/material.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_client_mobile/at_client_mobile.dart';

/// Common error dialog to show the error to user
class AtErrorDialog {
  static AlertDialog getAlertDialog(Object error, BuildContext context) {
    /// The error message to display
    String errorMessage = _getErrorMessage(error);
    String title = 'Error';
    return AlertDialog(
      title: Row(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          const Icon(Icons.sentiment_dissatisfied)
        ],
      ),
      content: Text(errorMessage),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        )
      ],
    );
  }

  ///Returns corresponding errorMessage for [error].
  static String _getErrorMessage(Object error) {
    switch (error.runtimeType) {
      case AtClientException:
        return 'Unable to perform this action. Please try again.';
      case UnAuthenticatedException:
        return 'Unable to authenticate. Please try again.';
      case NoSuchMethodError:
        return 'Failed in processing. Please try again.';
      case AtConnectException:
        return 'Unable to connect server. Please try again later.';
      case AtIOException:
        return 'Unable to perform read/write operation. Please try again.';
      case AtServerException:
        return 'Unable to activate server. Please contact admin.';
      case SecondaryNotFoundException:
        return 'Server is unavailable. Please try again later.';
      case SecondaryConnectException:
        return 'Unable to connect. Please check with network connection and try again.';
      case InvalidAtSignException:
        return 'Invalid atsign is provided. Please contact admin.';
      // case ServerStatus:
      //   return _getServerStatusMessage(error);
      // case OnboardingStatus:
      //   return _message(error);
      default:
        return 'unable to connect. Please refresh the page';
    }
  }
}

extension CustomMessages on OnboardingStatus {}
