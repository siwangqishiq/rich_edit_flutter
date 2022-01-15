import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rich_input/emoji.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<EditableTextState> edKey = GlobalKey<EditableTextState>();

  final RichTextEditingController _controller = RichTextEditingController();

  late final TextEditingController _edController;

  @override
  void initState() {
    super.initState();
    _edController = RichTextEditingController();
    _edController.text = "Heloo";

    _edController.addListener(() {
      //print("edcontroller ${_edController.text}");
      //print();
      edKey.currentState?.updateFloatingCursor(RawFloatingCursorPoint(
          state: FloatingCursorDragState.Start, offset: Offset(200, 200)));
    });
  }

  @override
  Widget build(BuildContext _context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Padding(
            //   padding: EdgeInsets.all(20),
            //   child: EmojiText(
            //     "",
            //     style: TextStyle(fontSize: 40, color: Colors.red),
            //   ),
            // ),
            // Padding(
            //   padding:const EdgeInsets.all(20),
            //   child: EmojiInputText(),
            // ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: ExtendedTextField(
                maxLines: null,
                specialTextSpanBuilder: MySpecialTextSpanBuilder(),
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onInputChange(String? inputContent) {
    print(inputContent);
  }
}

class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
  MySpecialTextSpanBuilder({this.showAtBackground = false});

  /// whether show background for @somebody
  final bool showAtBackground;
  @override
  TextSpan build(String data,
      {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap}) {
    if (kIsWeb) {
      return TextSpan(text: data, style: textStyle);
    }

    return super.build(data, textStyle: textStyle, onTap: onTap);
  }

  @override
  SpecialText? createSpecialText(String flag,
      {TextStyle? textStyle,
      SpecialTextGestureTapCallback? onTap,
      int? index}) {
    if (flag == '') {
      return null;
    }

    ///index is end index of start flag, so text start index should be index-(flag.length-1)
    if (isStart(flag, EmojiText.flag)) {
      print("input $flag $index");
      return EmojiText(textStyle, start: index! - (EmojiText.flag.length - 1));
    }
    // else if (isStart(flag, ImageText.flag)) {
    //   return ImageText(textStyle,
    //       start: index! - (ImageText.flag.length - 1), onTap: onTap);
    // } else if (isStart(flag, AtText.flag)) {
    //   return AtText(
    //     textStyle,
    //     onTap,
    //     start: index! - (AtText.flag.length - 1),
    //     showAtBackground: showAtBackground,
    //   );
    // } else if (isStart(flag, EmojiText.flag)) {
    //   return EmojiText(textStyle, start: index! - (EmojiText.flag.length - 1));
    // } else if (isStart(flag, DollarText.flag)) {
    //   return DollarText(textStyle, onTap,
    //       start: index! - (DollarText.flag.length - 1));
    // }
    return null;
  }
}

///emoji/image text
class EmojiText extends SpecialText {
  EmojiText(TextStyle? textStyle, {this.start})
      : super(EmojiText.flag, ']', textStyle);
  static const String flag = '[';
  final int? start;

  @override
  InlineSpan finishText() {
    final String key = toString();
    print("finishText $key");

    ///https://github.com/flutter/flutter/issues/42086
    /// widget span is not working on web
    if (EmojiManager.instance.emojis.containsKey(key) && !kIsWeb) {
      //fontsize id define image height
      //size = 30.0/26.0 * fontSize
      const double size = 20.0;

      ///fontSize 26 and text height =30.0
      //final double fontSize = 26.0;
      return ImageSpan(
          AssetImage(
            EmojiManager.instance.emojis[key]!,
          ),
          actualText: key,
          imageWidth: size,
          imageHeight: size,
          start: start!,
          fit: BoxFit.fill,
          margin: const EdgeInsets.only(left: 2.0, top: 2.0, right: 2.0));
    }

    return TextSpan(text: toString(), style: textStyle);
  }
}
