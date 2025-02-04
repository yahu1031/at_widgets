import 'package:flutter/material.dart';
import 'package:at_invitation_flutter/services/invitation_service.dart';

void initializeInvitationService(
    {@required GlobalKey<NavigatorState>? navkey,
    @required String? webPage,
    rootDomain = 'root.atsign.wtf',
    rootPort = 64}) {
  InvitationService()
      .initInvitationService(navkey, webPage, rootDomain, rootPort);
}

void shareAndInvite(BuildContext context, String jsonData) {
  InvitationService().shareAndinvite(context, jsonData);
}

fetchInviteData(BuildContext context, String data, String atsign) {
  InvitationService().fetchInviteData(context, data, atsign);
}
