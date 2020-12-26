import 'package:flutter/material.dart';
import 'package:asitable/microcomponents/Styles.dart';

/// A [TextFormField] that can be used for editing the markdown.
///
/// When a [controller] is specified, its [TextEditingController.text]
/// defines the [initialValue].
///
/// The function [onChange] will be called when the text changes.
///
/// The [maxLines] number would be used as [maxLines] parameter
/// for the [TextFormField].
class MrkdownEditingField extends StatelessWidget {
  /// Create a [MrkdownEditingField] passing [key], [controller], [onChange]
  /// and [maxLines].
  const MrkdownEditingField({
    Key key,
    @required this.controller,
    this.maxLines = 8,
  })  : assert(controller != null),
        super(key: key);

  /// Controls the text being edited and can't be null.
  final TextEditingController controller;

  /// Will be called when the text change.

  /// Will be passed as [maxLines] parameter to the [TextFormField].
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      maxLines: maxLines,
      controller: controller,
    );
  }
}
