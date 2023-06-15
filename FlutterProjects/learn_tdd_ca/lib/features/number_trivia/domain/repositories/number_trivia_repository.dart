import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/number_trivia.dart';

class NumberTriviaRepository {
  NumberTrivia getConcreteNumberTrivia()  {
    return const NumberTrivia(text: 'test', number: 1);
  }
}

