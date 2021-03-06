import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';
import 'package:asitable/microcomponents/Styles.dart';

/// [MarkdownPreview] will use [Markdown] from [flutter_markdown]
/// to preview the markdown [text] passed to it.
///
/// [selectable] is used to determine if the preview will be
/// selectable or not and default to true.
class MarkdownPreview extends StatelessWidget {
  /// Create the [MarkdownPreview] passing the text and [selectable].
  const MarkdownPreview({
    Key key,
    @required this.text,
    this.selectable = true,
  }) : super(key: key);

  /// To be displayed by the [Markdown] widget.
  final String text;

  /// Whether should be selectable or not
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Markdown(
          styleSheet: MarkdownStyleSheet(
              p: Theme.of(context).textTheme.bodyText1,
              h1: Theme.of(context).textTheme.headline1,
              h2: Theme.of(context).textTheme.headline2),
          controller: ScrollController(),
          selectable: selectable,
          onTapLink: (_, href, __) {
            canLaunch(href).then((value) {
              if (value) {
                launch(href);
              } else {
                Fluttertoast.showToast(
                  msg: "Couldn't open the URL",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: TashiColors['tl'],
                  fontSize: 16.0,
                );
              }
            });
          },
          data: text,
          shrinkWrap: true,
          extensionSet: md.ExtensionSet(
            md.ExtensionSet.gitHubFlavored.blockSyntaxes,
            [
              md.EmojiSyntax(),
              ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
            ],
          ),
        ),
      ),
    );
  }
}
