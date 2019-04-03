import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {

  var _currentIndex = 0;
  var _infoType = 'trivia';
  Map _data = Map();

  Future<Map> getFact() async {

    _infoType = determineInfoType(_currentIndex);
    var url = 'http://numbersapi.com/random/$_infoType?json';
    http.Response response = await http.get(url);
    var jsonMap = json.decode(response.body);
    return jsonMap;
  }

  String determineInfoType(index) {
    String infoType;
    switch(index) {
      case 0:
        infoType = 'trivia';
        break;
      case 1:
        infoType = 'year';
        break;
      case 2:
        infoType = 'math';
        break;
      case 3:
        infoType = 'date';
        break;
    }
    return infoType;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFact(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _data = snapshot.data;
        } else {
          return Scaffold(
              appBar: AppBar(
                title: Text("Loading a cool number fact...}"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 4,
                    child: LinearProgressIndicator(value: null)),
              ));
        }
        return Scaffold(
            appBar: AppBar(
              title: Text("Random number selected: ${_data['number']}"),
            ),
            body: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                      height: 240,
                      width: 320,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://source.unsplash.com/random/300x300"+DateTime.now().millisecondsSinceEpoch.toString()),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8.0,
                                offset: Offset(0, 10))
                          ],
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6.0))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Center(
                    child: Text('Did you know?'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                  child: Center(
                    child: Text(_data['text']),
                  ),
                )
              ],
            ),
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.orange,
        backgroundColor: Colors.brown,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('Trivia'),

          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.keyboard), title: Text('Year')),
          BottomNavigationBarItem(
              icon: Icon(Icons.vertical_align_center), title: Text('Math')),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), title: Text('Date')),

        ],
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() { _currentIndex = index; });
        }
      )
        );
      });
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("Let's Flutter!"),
//      ),
//      body: Container(
//        child: Center(
//          child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                color: Colors.yellow,
//                child: Row(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Icon(Icons.library_books),
//                    ),
//                    Text('Welcome. Click the FAB to see number facts...'),
//                  ],
//                ),
//              )),
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.android),
//          onPressed: () =>
//              Navigator.of(context)
//                  .push(
//                  MaterialPageRoute(builder: (context) => FactsScreen()))),
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentIndex,
//        fixedColor: Colors.black,
//        unselectedItemColor: Colors.orange,
//        backgroundColor: Colors.brown,
//        items: [
//          BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('Trivia'),
//
//          ),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.keyboard), title: Text('Year')),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.vertical_align_center), title: Text('Math')),
//          BottomNavigationBarItem(
//              icon: Icon(Icons.date_range), title: Text('Date')),
//
//        ],
//        type: BottomNavigationBarType.shifting,
//        onTap: (index) {
//          setState(() { _currentIndex = index; });
//        }
//      ),
//    );
//  }

}

class FactsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FactsScreenState();
  }
}

class FactsScreenState extends State<FactsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Number facts...}"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 4,
              child: LinearProgressIndicator(value: null)),
        ));
  }

}