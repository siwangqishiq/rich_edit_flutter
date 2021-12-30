
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
      edKey.currentState?.updateFloatingCursor(RawFloatingCursorPoint(state: FloatingCursorDragState.Start , offset: Offset(200,200)));
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
            const Padding(
              padding:EdgeInsets.all(20),
              child: EmojiText("" , style: TextStyle(fontSize: 40 , color: Colors.red),), 
            ),
            Padding(
              padding:const EdgeInsets.all(20),
              child: EmojiInputText(), 
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

  void onInputChange(String? inputContent){
    print(inputContent);
  }
}






