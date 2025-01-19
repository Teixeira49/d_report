import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ButtonSettingsTileWithLink extends StatefulWidget {
  const ButtonSettingsTileWithLink({
    super.key,
    required this.titleOptionText,
    required this.iconData,
    required this.url,
  });

  final String titleOptionText;
  final IconData iconData;
  final String url;

  @override
  State<ButtonSettingsTileWithLink> createState() =>
      _MyButtonSettingsTileWithLinkButton();
}

class _MyButtonSettingsTileWithLinkButton
    extends State<ButtonSettingsTileWithLink> {

  Future<void>? _launched;

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(
      Uri(path: url),
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw 'Could not launch $url';
      print('no se pudo jefe');
    }
    await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 12, right: 12),
        decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).listTileTheme.tileColor,
        ),
        child: ListTile(
          title: Text(widget.titleOptionText),
          leading: Container(
            padding: const EdgeInsets.only(right: 4),
            child: Icon(widget.iconData),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => setState(
            () {
              _launched = _launchURL(widget.url);
            },
          ),
        ));
  }
}
