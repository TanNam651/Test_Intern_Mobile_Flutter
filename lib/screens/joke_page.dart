import 'package:flutter/material.dart';
import 'package:test_mobile/model/sqlite_model.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  SQLiteModel model = SQLiteModel();
  List<Map<String, dynamic>> _listJokes = [];
  int _current_index = 0;

  @override
  void initState() {
    super.initState();
    _getDatabase();
    print(_listJokes);
  }

  void _getDatabase() async {
    final data = await model.getDatabase();
    setState(() {
      _listJokes = data;
    });
  }

  void _updateVote(
    int id,
    bool vote,
  ) async {
    if (vote) {
      await model.updateFunnyRating(
          id, _listJokes[_current_index]['funny'] + 1);
    } else {
      await model.updateNotFunnyRating(
          id, _listJokes[_current_index]['notfunny'] + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
            margin: EdgeInsets.only(left: 20, bottom: 10),
            child: Image.asset(
              'assets/images/img.png',
            )),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, bottom: 10),
            child: Image.asset('assets/images/action.png'),
          )
        ],
        title: Text('Joke App'),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          color: Color.fromARGB(255, 51, 183, 110),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'A joke a day keeps the doctor away',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'If you joke wrong way, you teeth have to pay.(Serious)',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
            child: _current_index >= _listJokes.length
                ? Center(
                    child: Text(
                        "That's all the jokes for today! Come back another day!"),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 60, left: 30, right: 30),
                    child: Text(
                      _listJokes[_current_index]['content'],
                      style: TextStyle(),
                    ),
                  )),
        _current_index >= _listJokes.length
            ? Container()
            :
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 5, right: 15),
                child: ElevatedButton(
                  child: Text('  This is funny! ', style: TextStyle()),
                  onPressed: () {
                    setState(() {
                      _updateVote(
                        _listJokes[_current_index]['id'],
                        true,
                      );
                      _current_index += 1;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 5),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  child: Text('This is not funny.', style: TextStyle()),
                  onPressed: () {
                    setState(() {
                      _updateVote(
                        _listJokes[_current_index]['id'],
                        false,
                      );
                      _current_index += 1;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Container(
          child: Column(children: [
            Divider(
              thickness: 1,
              color: Colors.grey[350],
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'This appis created as part of Hlsolutuins program. The materials contained on this website are provided for general information only and do not constitute any form of advice. HLS assumes no reponsibility for the accuracy of any particular statement and accepts no liability for any loss or damage which may aries from reliance on the information contained on this site.',
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 15),
              child: Text(
                "Copyright 2021 HLS",
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ]),
        )
      ]),
    );
  }
}
