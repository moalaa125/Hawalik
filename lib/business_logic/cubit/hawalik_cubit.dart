import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hawalik_state.dart';

class HawalikCubit extends Cubit<HawalikState> {
  HawalikCubit() : super(HawalikInitial());
}
