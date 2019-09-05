import 'package:flash_chat/global/theme/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/preference_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        builder: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: _buildWithTheme,
        ));
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      theme: state.themeData,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) =>
            WelcomeScreen(), //! WelcomeScreen().id bezieht sich auf den String id im WelcomeScreen
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        PreferenceScreen.id: (context) => PreferenceScreen(),
      },
    );
  }
}
