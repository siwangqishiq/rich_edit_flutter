// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///
///

class EmojiManager {
  static const int PARSE_STATE_TEXT = 0; //解析状态 文本解析
  static const int PARSE_STATE_EMOJI = 1; //解析状态 表情解析

  static EmojiManager? _instance;

  static EmojiManager get instance => _instance ?? EmojiManager();

  //assets name -> path
  Map<String, String> emojis = <String, String>{};

  EmojiManager() {
    loadEmojiData();
  }

  bool checkHasEmoji(String emojiStr) {
    return emojis.containsKey(findEmojiRealName(emojiStr));
  }

  List<String> listAllEmoji() {
    List<String> emojiList = emojis.keys.toList();
    return emojiList;
  }

  List<InlineSpan> parseContent(String? content, {TextStyle? style}) {
    if (content == null || content.isEmpty) {
      return [const TextSpan(text: "")];
    }

    List<InlineSpan> spanList = [];
    int position = 0;
    int state = PARSE_STATE_TEXT;
    StringBuffer textBuffer = StringBuffer();
    StringBuffer emojiBuffer = StringBuffer();

    while (position < content.length) {
      String ch = content[position];
      // print("ch : $ch");
      if (ch == "[") {
        if (state == PARSE_STATE_TEXT) {
          emojiBuffer.write(ch);
        } else if (state == PARSE_STATE_EMOJI) {
          textBuffer.write(emojiBuffer.toString());
          emojiBuffer.clear();
          emojiBuffer.write(ch);
        }
        state = PARSE_STATE_EMOJI; //状态改为解析表情
      } else if (ch == "]") {
        if (state == PARSE_STATE_TEXT) {
          textBuffer.write(ch);
        } else if (state == PARSE_STATE_EMOJI) {
          emojiBuffer.write(ch);
          String emojiName = emojiBuffer.toString();
          emojiBuffer.clear();
          state = PARSE_STATE_TEXT;

          String emojiRealName = findEmojiRealName(emojiName);
          //print("emoji : $emojiRealName  $emojiName");

          if (emojis.containsKey(emojiRealName)) {
            _createNormalText(spanList, textBuffer, style);
            spanList.add(_createEmojiSpan(emojis[emojiRealName]!, style));
          } else {
            textBuffer.write(emojiName);
          }
        }
      } else {
        if (state == PARSE_STATE_TEXT) {
          textBuffer.write(ch);
        } else if (state == PARSE_STATE_EMOJI) {
          emojiBuffer.write(ch);
        }
      }
      position++;
    } //end while

    if (state == PARSE_STATE_EMOJI && emojiBuffer.isNotEmpty) {
      textBuffer.write(emojiBuffer.toString());
      emojiBuffer.clear();
    }

    _createNormalText(spanList, textBuffer, style);

    //print("spanlist ${spanList.length} ${spanList[0].runtimeType}");
    return spanList;
  }

  void _createNormalText(
      List<InlineSpan> spanList, StringBuffer textBuffer, TextStyle? style) {
    if (textBuffer.isNotEmpty) {
      spanList.add(_createTextSpan(textBuffer.toString(), style));
      textBuffer.clear();
    }
  }

  InlineSpan _createEmojiSpan(String path, TextStyle? style) {
    double size = 64;
    if (style != null) {
      size = style.fontSize! + 10;
    }
    return WidgetSpan(child: SizedBox(child: Image.asset(path), width: size));
  }

  InlineSpan _createTextSpan(String content, TextStyle? style) {
    return TextSpan(text: content, style: style);
  }

  String findEmojiRealName(String emojiName) {
    if (emojiName.startsWith("[") && emojiName.endsWith("]")) {
      return emojiName.substring(1, emojiName.length - 1);
    }
    return emojiName;
  }

  void loadEmojiData() {
    emojis["[ah]"] = buildAssetFilePath("emoji_ah.webp");
    emojis["[amaze]"] = buildAssetFilePath("emoji_amaze.webp");
    emojis["[anger]"] = buildAssetFilePath("emoji_anger.webp");
    emojis["[angry]"] = buildAssetFilePath("emoji_angry.webp");
    emojis["[arrogant]"] = buildAssetFilePath("emoji_arrogant.webp");
    emojis["[asleep]"] = buildAssetFilePath("emoji_asleep.webp");
    emojis["[awkward]"] = buildAssetFilePath("emoji_awkward.webp");
    emojis["[bad]"] = buildAssetFilePath("emoji_bad.webp");
    emojis["[bad_laugh]"] = buildAssetFilePath("emoji_bad_laugh.webp");
    emojis["[baoquan]"] = buildAssetFilePath("emoji_baoquan.webp");
    emojis["[beat]"] = buildAssetFilePath("emoji_beat.webp");
    emojis["[beer]"] = buildAssetFilePath("emoji_beer.webp");
    emojis["[blessing]"] = buildAssetFilePath("emoji_blessing.webp");
    emojis["[blurred]"] = buildAssetFilePath("emoji_blurred.webp");
    emojis["[bomb]"] = buildAssetFilePath("emoji_bomb.webp");
    emojis["[bone]"] = buildAssetFilePath("emoji_bone.webp");
    emojis["[byb]"] = buildAssetFilePath("emoji_byb.webp");
    emojis["[cake]"] = buildAssetFilePath("emoji_cake.webp");
    emojis["[cattle]"] = buildAssetFilePath("emoji_cattle.webp");
    emojis["[celebrate]"] = buildAssetFilePath("emoji_celebrate.webp");
    emojis["[coffee]"] = buildAssetFilePath("emoji_coffee.webp");
    emojis["[contentde]"] = buildAssetFilePath("emoji_contentde.webp");
    emojis["[cry]"] = buildAssetFilePath("emoji_cry.webp");
    emojis["[crying]"] = buildAssetFilePath("emoji_crying.webp");
    emojis["[curse]"] = buildAssetFilePath("emoji_curse.webp");
    emojis["[depressed]"] = buildAssetFilePath("emoji_depressed.webp");
    emojis["[despise]"] = buildAssetFilePath("emoji_despise.webp");
    emojis["[disdain]"] = buildAssetFilePath("emoji_disdain.webp");
    emojis["[doubt]"] = buildAssetFilePath("emoji_doubt.webp");
    emojis["[dung]"] = buildAssetFilePath("emoji_dung.webp");
    emojis["[embarrassed]"] = buildAssetFilePath("emoji_embarrassed.webp");
    emojis["[embrace]"] = buildAssetFilePath("emoji_embrace.webp");
    emojis["[face_palm]"] = buildAssetFilePath("emoji_face_palm.webp");
    emojis["[fade]"] = buildAssetFilePath("emoji_fade.webp");
    emojis["[fear]"] = buildAssetFilePath("emoji_fear.webp");
    emojis["[fight]"] = buildAssetFilePath("emoji_fight.webp");
    emojis["[fist]"] = buildAssetFilePath("emoji_fist.webp");
    emojis["[frown]"] = buildAssetFilePath("emoji_frown.webp");
    emojis["[get_rich]"] = buildAssetFilePath("emoji_get_rich.webp");
    emojis["[gift]"] = buildAssetFilePath("emoji_gift.webp");
    emojis["[grievances]"] = buildAssetFilePath("emoji_grievances.webp");
    emojis["[hahe]"] = buildAssetFilePath("emoji_hahe.webp");
    emojis["[hand_shake]"] = buildAssetFilePath("emoji_hand_shake.webp");
    emojis["[happy]"] = buildAssetFilePath("emoji_happy.webp");
    emojis["[hard]"] = buildAssetFilePath("emoji_hard.webp");
    emojis["[heart_broken]"] = buildAssetFilePath("emoji_heart_broken.webp");
    emojis["[insidious]"] = buildAssetFilePath("emoji_insidious.webp");
    emojis["[kiss]"] = buildAssetFilePath("emoji_kiss.webp");
    emojis["[knife]"] = buildAssetFilePath("emoji_knife.webp");
    emojis["[leisurely]"] = buildAssetFilePath("emoji_leisurely.webp");
    emojis["[lips]"] = buildAssetFilePath("emoji_lips.webp");
    emojis["[love]"] = buildAssetFilePath("emoji_love.webp");
    emojis["[moon]"] = buildAssetFilePath("emoji_moon.webp");
    emojis["[naughty]"] = buildAssetFilePath("emoji_naughty.webp");
    emojis["[nose_picking]"] = buildAssetFilePath("emoji_nose_picking.webp");
    emojis["[pighead]"] = buildAssetFilePath("emoji_pighead.webp");
    emojis["[poor]"] = buildAssetFilePath("emoji_poor.webp");
    emojis["[red_envelopes]"] = buildAssetFilePath("emoji_red_envelopes.webp");
    emojis["[right_hum]"] = buildAssetFilePath("emoji_right_hum.webp");
    emojis["[rose]"] = buildAssetFilePath("emoji_rose.webp");
    emojis["[sad]"] = buildAssetFilePath("emoji_sad.webp");
    emojis["[seduction]"] = buildAssetFilePath("emoji_seduction.webp");
    emojis["[shh]"] = buildAssetFilePath("emoji_shh.webp");
    emojis["[shock]"] = buildAssetFilePath("emoji_shock.webp");
    emojis["[shutup]"] = buildAssetFilePath("emoji_shutup.webp");
    emojis["[shy]"] = buildAssetFilePath("emoji_shy.webp");
    emojis["[sick]"] = buildAssetFilePath("emoji_sick.webp");
    emojis["[silent]"] = buildAssetFilePath("emoji_silent.webp");
    emojis["[silly_smile]"] = buildAssetFilePath("emoji_silly_smile.webp");
    emojis["[sinister_smile]"] =
        buildAssetFilePath("emoji_sinister_smile.webp");
    emojis["[sleep]"] = buildAssetFilePath("emoji_sleep.webp");
    emojis["[sleepy]"] = buildAssetFilePath("emoji_sleepy.webp");
    emojis["[smile]"] = buildAssetFilePath("emoji_smile.webp");
    emojis["[smile_face]"] = buildAssetFilePath("emoji_smile_face.webp");
    emojis["[son]"] = buildAssetFilePath("emoji_son.webp");
    emojis["[sweat]"] = buildAssetFilePath("emoji_sweat.webp");
    emojis["[tears]"] = buildAssetFilePath("emoji_tears.webp");
    emojis["[tear_smile]"] = buildAssetFilePath("emoji_tear_smile.webp");
    emojis["[ths]"] = buildAssetFilePath("emoji_ths.webp");
    emojis["[titter]"] = buildAssetFilePath("emoji_titter.webp");
    emojis["[tooth]"] = buildAssetFilePath("emoji_tooth.webp");
    emojis["[vomit]"] = buildAssetFilePath("emoji_vomit.webp");
    emojis["[wane]"] = buildAssetFilePath("emoji_wane.webp");
    emojis["[watermelon]"] = buildAssetFilePath("emoji_watermelon.webp");
    emojis["[win]"] = buildAssetFilePath("emoji_win.webp");
    emojis["[wipe_sweat]"] = buildAssetFilePath("emoji_wipe_sweat.webp");
    emojis["[witty]"] = buildAssetFilePath("emoji_witty.webp");
    emojis["[wow]"] = buildAssetFilePath("emoji_wow.webp");
    emojis["[yeah]"] = buildAssetFilePath("emoji_yeah.webp");
    emojis["[yes]"] = buildAssetFilePath("emoji_yes.webp");
  }

  String buildAssetFilePath(String filename) => folderPath() + filename;

  String folderPath() => "assets/emoji/";
} //end class

class EmojiText extends StatelessWidget {
  final String? content;
  final TextStyle? style;

  const EmojiText(this.content, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          children: EmojiManager.instance.parseContent(content, style: style),
          style: style),
    );
  }
} //end class

class EmojiInputText extends StatefulWidget {
  ValueChanged<String>? onChangeCallback;
  late RichTextEditingController controller;
  late final FocusNode? node;

  EmojiInputText({
    Key? key,
    FocusNode? focusNode,
    this.onChangeCallback,
  }) : super(key: key) {
    controller = RichTextEditingController();
    node = focusNode;
  }

  @override
  State<StatefulWidget> createState() => EmojiInputTextState();
} //end class

class EmojiInputTextState extends State<EmojiInputText> {
  String? _originContent;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: _onChange,
      controller: widget.controller,
      focusNode: widget.node,
    );
  }

  void _onChange(String content) {
    if (_originContent != null && _originContent!.length > content.length) {
      _handleDel(widget.controller.selection.start, content, _originContent);
    }

    String currentContent = widget.controller.text;
    widget.onChangeCallback?.call(currentContent);
    _originContent = currentContent;
  }

  void _handleDel(int delPosition, String? current, String? origin) {
    if (origin == null || delPosition < 0 || delPosition >= origin.length) {
      return;
    }

    String originStr = origin;
    int leftIndex = 0;
    int rightIndex = 0;
    bool isEmoji = false;

    if (originStr[delPosition] == "]") {
      leftIndex = delPosition - 1;
      rightIndex = delPosition;

      while (leftIndex >= 0 && originStr[leftIndex] != "[") {
        leftIndex--;
      } //end while

      isEmoji = leftIndex >= 0 && originStr[leftIndex] == "[";
    }

    if (!isEmoji || rightIndex - leftIndex <= 0) {
      return;
    }

    String name = origin.substring(leftIndex, rightIndex + 1);
    // print("name : $name");

    if (EmojiManager.instance.checkHasEmoji(name)) {
      widget.controller.text =
          origin.substring(0, leftIndex) + origin.substring(rightIndex + 1);
      widget.controller.selection = TextSelection.collapsed(offset: leftIndex);
    }
  }
}

class RichTextEditingController extends TextEditingController {
  RichTextEditingController();

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    if (text.isEmpty) {
      return TextSpan(text: "", style: style);
    }

    return TextSpan(
        children: EmojiManager.instance.parseContent(text, style: style));
  }
}
