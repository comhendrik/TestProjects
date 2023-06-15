import 'package:learn_tdd_ca/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUpAll(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);

  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
    () async {
      // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      print("1");
      when(mockNumberTriviaRepository.getConcreteNumberTrivia()).thenAnswer((_)  => tNumberTrivia,);
      print("2");
      // The "act" phase of the test. Call the not-yet-existent method.
      final result = usecase.execute();
      // UseCase should simply return whatever was returned from the Repository
      expect(result, tNumberTrivia);
      // Verify that the method has been called on the Repository
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia());
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}