import 'package:dartz/dartz.dart';
import 'package:learn_tdd_ca/core/error/failure.dart';
import 'package:learn_tdd_ca/core/util/input_converter.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:learn_tdd_ca/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
        getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
        getRandomNumberTrivia: mockGetRandomNumberTrivia,
        inputConverter: mockInputConverter);
  });

  test('initial state should be empty', () {
    expect(bloc.state, equals(NumberTriviaInitial()));
  });
  
  group('GetTriviaForConcreteNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(text: 'test text', number: 1);

    test(
      'should call InputConverter and validate and convert the string to an unsigned integer',
      () async {
        when(() => mockInputConverter.stringToUnsignedInteger(tNumberString)).thenReturn(Right(tNumberParsed));

        bloc.add(GetTriviaForConcreteNumber(tNumberString));

        await untilCalled(() => mockInputConverter.stringToUnsignedInteger(tNumberString));

        verify(() => mockInputConverter.stringToUnsignedInteger(tNumberString));
      }
    );

    test(
        'should emit Error() when the input is invalid',
            () async {
          when(() => mockInputConverter.stringToUnsignedInteger(tNumberString)).thenReturn(Left(InvalidInputFailure()));

          expectLater(bloc.stream, emitsInOrder(
              [
                NumberTriviaInitial(),
                NumberTriviaError(errorMsg: INVALID_INPUT_FAILURE_MESSAGE),
              ]
          ));

          bloc.add(GetTriviaForConcreteNumber(tNumberString));


        }
    );
  });
}