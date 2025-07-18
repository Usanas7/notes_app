import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth_repository.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthSignOut extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthSignIn>(_onSignIn);
    on<AuthSignUp>(_onSignUp);
    on<AuthSignOut>(_onSignOut);
    on<AuthCheckStatus>(_onCheckStatus);

    // Check initial auth status
    add(AuthCheckStatus());
  }

  Future<void> _onSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.createUserWithEmailAndPassword(
        event.email,
        event.password,
      );
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final user = _authRepository.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user: user));
    } else {
      emit(AuthUnauthenticated());
    }
  }
}