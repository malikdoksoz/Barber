import 'package:barber/Models/Font.dart';
import 'package:barber/SearchResultBooking.dart';
import 'package:barber/SearchResultContact.dart';
import 'package:barber/SearchResultHome.dart';
import 'package:barber/SearchResultPictures.dart';
import 'package:barber/json/response.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  final Barber barber;

  _SearchResultState createState() => _SearchResultState();

  SearchResult({Key key, this.barber}) : super(key: key);
}

class _SearchResultState extends State<SearchResult> {

  var _selectedIndex = 0;

  static Barber _barber = new Barber("","","");

  var _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  var _openingTimes = ['9:00-17:00', 'Closed'];

  final List<Widget> _bodyChildren = [
    SearchResultHome(barber: _barber),
    SearchResultBooking(barber: _barber),
    SearchResultPictures(barber: _barber),
    SearchResultContact(barber: _barber)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      bottomNavigationBar: _getBottomNavigationBar(),
      body: _bodyChildren[_selectedIndex],
    );
  }



  _getBottomNavigationBar() {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black54,
            ),
            title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              color: Colors.black54,
            ),
            title: Text("Book")),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.image,
              color: Colors.black54,
            ),
            title: Text("Picture")),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.contacts,
              color: Colors.black54,
            ),
            title: Text("Contact")),
      ],
      currentIndex: _selectedIndex,
      onTap: _onBottomNavigationItemTapped,
      type: BottomNavigationBarType.fixed,
    );
  }

  _onBottomNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Setting _barber to send to the next navigation class
      _barber = new Barber(widget.barber.name, widget.barber.address, widget.barber.icon);
    });
  }

  _getAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(widget.barber.name, style: Font.appBarTextStyle),
    );
  }

  _getBody() {
    return ListView(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
          ),
          child: Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Image.asset(
                  'assets/images/barber2.jpg',
                  fit: BoxFit.fill,
                )),
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      color: Colors.black26,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.barber.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: Font.secondFont,
                          fontSize: 42,
                          color: Color(0xfffffec4)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: Container(
              child: ClipOval(
                child: Image.asset("assets/images/profile1.jpg"),
              ),
            ),
            radius: 55,
            backgroundColor: Colors.transparent,
          ),
        ),
        Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              child: Text(
                'Welcome to',
                style: TextStyle(
                    fontFamily: Font.mainFont,
                    fontSize: 24,
                    color: Color(0xff685408)),
              ),
              alignment: Alignment.topCenter,
            ),
          ),
          Container(
            child: Text(
              widget.barber.name,
              style: TextStyle(
                  fontFamily: Font.mainFont,
                  fontSize: 36,
                  color: Color(0xff685408)),
            ),
            alignment: Alignment.topCenter,
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Opening times',
                      style:
                          TextStyle(fontFamily: Font.secondFont, fontSize: 32),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GridView.count(
                    crossAxisCount: 2,
                    primary: false,
                    childAspectRatio: 8,
                    mainAxisSpacing: 1,
                    shrinkWrap: true,
                    children: _dayOfTheWeekRows(),
                  ),
                ),
              ],
            ),
          ),
        ),

        //Here will be maps
      ],
    );
  }

  _dayOfTheWeekRows() {
    List<Widget> widgets = new List<Widget>();
    for (var x = 0; x < 7; x++) {
      var opening = 0;
      if (x > 4) opening = 1;

      widgets.add(
        Text(
          _daysOfWeek[x] + '  :',
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 24),
        ),
      );
      widgets.add(Text(
        "  " + _openingTimes[opening],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ));
    }
    return widgets;
  }
}