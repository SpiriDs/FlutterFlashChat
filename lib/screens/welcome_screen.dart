import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/preference_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flash_chat/global/theme/app_themes.dart';
import 'package:flash_chat/global/theme/bloc/bloc.dart';

class ThemeChanger extends StatefulWidget {
  @override
  _ThemeChangerState createState() => _ThemeChangerState();
}

class _ThemeChangerState extends State<ThemeChanger> {
  bool switchState = false;
  @override
  Widget build(BuildContext context) {
    final itemAppTheme = AppTheme.values[1];
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Text('Dark Mode'),
                ),
                Flexible(
                  child: Switch(
                    value: switchState,
                    onChanged: (bool value) {
                      if (switchState == false) {
                        BlocProvider.of<ThemeBloc>(context).dispatch(
                          ThemeChanged(),
                        ); //TODO DAS hier rausmachen und stattdessen eine Preference PAge einbauen mit einem FLoating Botton, damit es nahc dem Turorial funktioniert.
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    //! Im Tutorial geloescht
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    //! wurde im Tutorial geloescht. Der Statuslistener muss im dispose() [siehe unten] beendeet werden, ansonsten laeuft er bis in alle Ewigkeit und verbrauch unnoetig Resourcen!!!
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 50);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    controller.addListener(() {
      setState(() {});
      //print(controller.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                ColorizeAnimatedTextKit(
                  colors: [
                    Colors.yellow[400],
                    Colors.yellow[500],
                    Colors.yellow[600],
                    Colors.yellow[700],
                    Colors.yellow[800],
                    Colors.yellow[900],
                    Colors.yellow[800],
                    Colors.yellow[700],
                    Colors.yellow[600],
                    Colors.yellow[500],
                    Colors.yellow[400],
                    //Colors.deepOrangeAccent,
                    //Colors.orangeAccent
                  ],
                  duration: Duration(milliseconds: 5000),
                  //isRepeatingAnimation: false,
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              colour: Colors.lightBlueAccent,
              buttonTitle: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              colour: Colors.blueAccent,
              buttonTitle: 'Registration',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
            SizedBox(
              height: 60.0,
            ),
            //ThemeChanger(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.settings,
          size: 50.0,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, PreferenceScreen.id);
        },
      ),
    );
  }
}
