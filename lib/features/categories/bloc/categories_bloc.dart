import 'package:bloc/bloc.dart';
import 'package:carx/data/model/brand.dart';
import 'package:carx/features/categories/bloc/categories_event.dart';
import 'package:carx/features/categories/bloc/categories_state.dart';
import 'package:carx/service/api/reponsitory/reponsitory.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(Reponsitory reponsitory) : super(CategoriesInitial()) {
    on<FetchBrandsEvent>(
      (event, emit) async {
        emit(CategoriesLoading());
        try {
          final List<Brand> brands = await reponsitory.fetchBrands();
          emit(CategoriesSuccess(brands: brands));
        } catch (e) {
          emit(CategoriesFailure(error: e.toString()));
        }
      },
    );
  }
}
