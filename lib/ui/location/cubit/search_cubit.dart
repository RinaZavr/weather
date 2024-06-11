import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/domain/models/location_model.dart';
import 'package:weather/domain/services/network_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void search(String query) async {
    try {
      emit(SearchLoading());
      List<LocationInfo> locations =
          await GetIt.I.get<NetworkService>().searchLocation(q: query);
      if (locations.isEmpty) {
        emit(SearchError(message: 'Город не найден'));
      } else {
        emit(SearchLoaded(cities: locations));
      }
    } catch (e) {
      emit(SearchError(message: 'Ошибка при поиске города'));
    }
  }
}
