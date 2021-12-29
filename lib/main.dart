
import 'package:flutter/material.dart';
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

  final RichTextEditingController _controller = RichTextEditingController();
  

  @override
  void initState() {
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            const Padding(
              padding:EdgeInsets.all(20),
              child: EmojiText("你好世界[ah][coffee]hahah\n重来[ah][[[dasdsa[bad]]]]]][yes]]" , style: TextStyle(fontSize: 40 , color: Colors.red),), 
            ),
            Padding(
              padding:const EdgeInsets.all(20),
              child: TextField(
                maxLines: null,
                onChanged: onInputChange,
                style:const TextStyle(fontSize: 40.0),
                controller: _controller,
                showCursor: true,
              ), 
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void onInputChange(String? inputContent){
    print(inputContent);

    
  }
}


class RichTextEditingController extends TextEditingController {

  @override
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing}) {

    if(text.isEmpty){
      return TextSpan(
        text: "",
        style: style
      );
    }

    List<InlineSpan> textSpans = EmojiManager.instance.parseContent(text , style : style);
    return TextSpan(children: textSpans);
  }
}



