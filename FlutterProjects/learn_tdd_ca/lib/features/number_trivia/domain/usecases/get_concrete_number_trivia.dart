import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;


  GetConcreteNumberTrivia(this.repository);

  NumberTrivia execute()  {
    return repository.getConcreteNumberTrivia();
  }
}