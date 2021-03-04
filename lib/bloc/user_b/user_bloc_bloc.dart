import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:campusflutter/api/api_service.dart';
import 'package:campusflutter/models/usuario_list.dart';
import 'package:meta/meta.dart';
import 'package:query_params/query_params.dart';

part 'user_bloc_event.dart';
part 'user_bloc_state.dart';

class UsuariosBloc extends Bloc<UsuariosEvent, UsuariosState> {
  UsuariosBloc() : super(UsuariosInitial());
  ApiService api = ApiService();
  List<UsuarioList> userList = [];
  int page = 0;
  int limit = 8;
  bool isLoading = false;

  @override
  Stream<UsuariosState> mapEventToState(
    UsuariosEvent event,
  ) async* {
    if (event is FetchUsuarios) {
      if (!isLoading) {
        isLoading = true;
        try {
          page++;
          URLQueryParams queryParams = URLQueryParams();
          queryParams.append('page', page);
          queryParams.append('limit', limit);

          List<UsuarioList> list = await api.getUsersPag(queryParams);
          if (list == null) {
            page--;
            isLoading = false;
            yield LoadedUsers(userList: userList);
          } else {
            userList.addAll(list);
            yield LoadedUsers(userList: userList);
          }
        } catch (e) {
          page--;
          yield ErrorState(mensaje: "Error en la API");
        }
        isLoading = false;
      }
    }
  }
}
