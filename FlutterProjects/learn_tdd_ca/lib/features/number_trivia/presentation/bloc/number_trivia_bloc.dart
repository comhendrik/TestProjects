import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:learn_tdd_ca/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:learn_tdd_ca/core/util/input_converter.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter
  }) : super(NumberTriviaInitial()) { //this super sets the initial state of the event
    on<NumberTriviaEvent>((event, emit) async {
      emit(NumberTriviaInitial());
      if (event is GetTriviaForConcreteNumber)  {
        final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
        await inputEither.fold(
           (failure) async {
            emit(const NumberTriviaError(errorMsg: INVALID_INPUT_FAILURE_MESSAGE));
          },
          (integer) async {
            emit(NumberTriviaLoading());
            final resultEither = await getConcreteNumberTrivia.execute(number: integer);
            await resultEither.fold(
                (failure) async {
                  emit(const NumberTriviaError(errorMsg: SERVER_FAILURE_MESSAGE));
                },
                (numberTrivia) async{
                  emit(NumberTriviaLoaded(trivia: numberTrivia)); //Error
                }
            );
          }
        );


      } else if (event is GetTriviaForRandomNumber) {
        emit(NumberTriviaLoading());
        final resultEither = await getRandomNumberTrivia.execute();
        resultEither.fold(
            (failure) {
              emit(const NumberTriviaError(errorMsg: SERVER_FAILURE_MESSAGE));
            },
            (numberTrivia) {
              emit(NumberTriviaLoaded(trivia: numberTrivia));
            }
        );
      }
    }, transformer: sequential());
  }
}
