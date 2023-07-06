part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class NumberTriviaInitial extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class NumberTriviaLoading extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class NumberTriviaLoaded extends NumberTriviaState {
  final NumberTrivia trivia;
  NumberTriviaLoaded({required this.trivia});

  @override
  List<Object> get props => [];
}

class NumberTriviaError extends NumberTriviaState {
  final String errorMsg;
  NumberTriviaError({required this.errorMsg});

  @override
  List<Object> get props => [];
}
