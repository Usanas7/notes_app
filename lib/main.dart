import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:notes_app/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repository.dart';
import 'package:notes_app/features/notes/data/repositories/notes_repository.dart';
import 'package:notes_app/features/auth/presentation/pages/auth_page.dart';
import 'package:notes_app/features/notes/presentation/pages/notes_page.dart';
import 'package:notes_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => NotesBloc(NotesRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'Notes App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const NotesPage();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}