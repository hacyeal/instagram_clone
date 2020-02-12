import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/size.dart';
import 'package:instagram_clone/utils/profile_image_path.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _menuOpened = false;
  Size _size;
  double menuWidth;
  int duration = 200;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    menuWidth = _size.width / 1.5;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _sideMenu(),
          _profile(),
        ],
      ),
    );
  }

  Widget _sideMenu() {
    return AnimatedContainer(
        curve: Curves.easeInOut,
        color: Colors.grey[200],
        duration: Duration(milliseconds: duration),
        transform: Matrix4.translationValues(
          _menuOpened ? _size.width - menuWidth : _size.width,
          0,
          0,
        ),
        child: SafeArea(
          child: SizedBox(
            width: menuWidth,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FlatButton(child: Text('hacyeal'), onPressed: null)
              ],
            ),
          ),
        ));
  }

  Widget _profile() {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: duration),
      color: Colors.transparent,
      transform: Matrix4.translationValues(
        _menuOpened ? -menuWidth : 0,
        0,
        0,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _usernameIconButton(),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _getProfileHeader,
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row get _getProfileHeader => Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_gap),
          child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                getProfileImgPath(('hacyeal')),
              )),
        ),
        Expanded(
          child: Table(
            children: [
              TableRow(children: [
                _getStatusValueWidget('123'),
                _getStatusValueWidget('324'),
                _getStatusValueWidget('4536'),
              ]),
              TableRow(children: [
                _getStatusLabelWidget('Posts'),
                _getStatusLabelWidget('Followers'),
                _getStatusLabelWidget('Following'),
              ])
            ],
          ),
        )
      ]);

  Widget _getStatusValueWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
      );

  Widget _getStatusLabelWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w300))),
        ),
      );

  Row _usernameIconButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: common_gap),
          child: Text('학열',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        )),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
              _menuOpened = !_menuOpened;
            });
          },
        )
      ],
    );
  }
}
