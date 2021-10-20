import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_users_list/screen/users_list/bloc/search_event.dart';
import 'package:flutter_users_list/screen/users_list/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(): super(DisabledSearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is DisabledSearchEvent) {
      yield DisabledSearchState();
    } else if (event is EnabledSearchEvent) {
      yield EnabledSearchState();
    }
  }
}