import 'package:flutter/material.dart';
import 'package:mataram2/bloc/blocs.dart';
import 'package:mataram2/bloc/user_bloc.dart';
import 'package:mataram2/services/services.dart';
import 'package:mataram2/ui/pages/pages.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/create_room/bloc/create_room_bloc.dart';
import 'bloc/search_room/search_room_bloc.dart';
import 'bloc/send_evidence/bloc/send_evidence_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthServices.userStream,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => PageBloc()),
            BlocProvider(create: (_) => UserBloc()),
            BlocProvider(create: (_) => ThemeBloc()),
            BlocProvider(create: (_) => SearchRoomBloc()),
            BlocProvider(create: (_) => SendEvidenceBloc()),
            BlocProvider(create: (_) => CreateRoomBloc())
          ],
          child: BlocBuilder<ThemeBloc, ThemeState>(
              builder: (_, themeState) => MaterialApp(
                  theme: themeState.themeData,
                  debugShowCheckedModeBanner: false,
                  home: Wrapper()))),
    );
  }
}
