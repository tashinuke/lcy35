import 'package:flutter/material.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
typedef _prompt = Future<String> Function();

/// A future function that can be used to prompt for a url or image source.
///
/// You can use this to show your own dialog and return the prompt value.
///
/// Check the function _takeInput for an example.
typedef UrlSource = Future<String> Function({
@required BuildContext context,
@required String hint,
@required String label,
});

/// A row of icons(buttons) that can be used to manipulate the text.
///
/// It manipulates the text inside the [controller].
///
/// The function [afterEditing] will be called after the text is edited.
///
/// The [urlSource] is afuture function that can be used to prompt
/// for a url or image source, You can use it to show your
/// own dialog and return the prompt value, Check the
/// function _takeInput for an example.
class MarkdownEditorIcons extends StatelessWidget {
  /// Create a [MarkdownEditorIcons] passing a [controller],
  /// [urlSource] and [afterEditing].
  MarkdownEditorIcons({
    Key key,
    @required this.controller,
    this.afterEditing,
    this.urlSource,
  })  : assert(controller != null),
        super(key: key);

  final _scrollbarController = ScrollController();

  /// This widget will manipulate the text inside this [controller].
  final TextEditingController controller;

  /// Will be invoked afer editing the text.
  final Function afterEditing;

  /// A future function that can be used to prompt for a url or image source.
  ///
  /// You can use this to show your own dialog and return the prompt value.
  ///
  /// Check the function _takeInput for an example.
  final UrlSource urlSource;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Scrollbar(
        controller: _scrollbarController,
        isAlwaysShown: true,
        child: ListView(
          controller: _scrollbarController,
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(
              tooltip: 'Bold',
              icon: Icon(FluentSystemIcons.ic_fluent_text_bold_filled, color: Colors.white70),
              onPressed: () => _surroundTextSelection(
                '**',
                '**',
              ),
            ),
            IconButton(
              tooltip: 'Underline',
              icon: Icon(FluentSystemIcons.ic_fluent_text_underline_filled, color: Colors.white70),
              onPressed: () => _surroundTextSelection(
                '__',
                '__',
              ),
            ),
            IconButton(
              tooltip: 'Code',
              icon: Icon(FluentSystemIcons.ic_fluent_code_filled, color: Colors.white70),
              onPressed: () => _surroundTextSelection(
                '```',
                '```',
              ),
            ),
            IconButton(
              tooltip: 'Strikethrough',
              icon: Icon(FluentSystemIcons.ic_fluent_text_strikethrough_filled, color: Colors.white70),
              onPressed: () => _surroundTextSelection(
                '~~',
                '~~',
              ),
            ),
            IconButton(
                tooltip: 'Link',
                icon: Icon(FluentSystemIcons.ic_fluent_link_filled, color: Colors.white70),
                onPressed: () {
                  _surroundTextSelection(
                    '[',
                    '](',
                    prompt: _getPromptFunction(
                      context: context,
                      hint: 'https://',
                      label: 'URL',
                    ),
                    afterPrompt: ')',
                  );
                }),
            IconButton(
              tooltip: 'Image',
              icon: Icon(FluentSystemIcons.ic_fluent_image_add_filled, color: Colors.white70),
              onPressed: () => _surroundTextSelection(
                '![',
                '](',
                prompt: _getPromptFunction(
                  context: context,
                  hint: 'https://',
                  label: 'Source',
                ),
                afterPrompt: ')',
              ),
            ),
          ],
        ),
      ),
    );
  }

  _prompt _getPromptFunction({
    String label,
    String hint,
    BuildContext context,
  }) {
    return () {
      return urlSource == null
          ? _takeInput(context: context, hint: hint, label: label)
          : urlSource(context: context, hint: hint, label: label);
    };
  }

  void _surroundTextSelection(
      String left,
      String right, {
        _prompt prompt,
        String afterPrompt,
      }) async {
    final currentTextValue = controller.value.text;
    final selection = controller.selection;
    final middle = selection.textInside(currentTextValue);
    final textBefore = selection.textBefore(currentTextValue);
    final textAfter = selection.textAfter(currentTextValue);
    String insertion = '$left$middle$right';
    if (prompt != null) {
      assert(afterPrompt != null);
      insertion += await prompt();
      insertion += afterPrompt;
    }

    final newTextValue = '$textBefore$insertion$textAfter';

    controller.value = controller.value.copyWith(
      text: newTextValue,
      selection: TextSelection.collapsed(
        offset: selection.baseOffset + left.length + middle.length,
      ),
    );
    if (afterEditing != null) afterEditing();
  }

  Future<String> _takeInput({
    @required BuildContext context,
    @required String hint,
    @required String label,
  }) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return _InputPrompt(
          title: 'Enter the value!',
          hint: hint,
          label: label,
        );
      },
    );
  }
}

class _InputPrompt extends StatelessWidget {
  final String title;
  final String label;
  final String hint;

  final _controller = TextEditingController();

  _InputPrompt({
    Key key,
    @required this.title,
    @required this.label,
    @required this.hint,
  })  : assert(title != null),
        assert(hint != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(title),
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
          ),
        ),
        RaisedButton.icon(
          onPressed: () {
            Navigator.pop<String>(context, _controller.text);
          },
          icon: Icon(Icons.done),
          label: Text('Done'),
        ),
      ],
    );
  }
}