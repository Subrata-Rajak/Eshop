import 'package:eshop/features/auth/data/data_source/remote/auth_service.dart';
import 'package:eshop/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:eshop/features/auth/domain/repositories/auth_repository.dart';
import 'package:eshop/features/auth/domain/usecases/login_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/register_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/resend_otp_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/update_password_usecase.dart';
import 'package:eshop/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:eshop/features/auth/presentation/blocs/email_for_otp_screen_bloc/email_for_otp_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/login_screen_bloc/login_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/otp_verification_screen_bloc/otp_verification_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/register_screen_bloc/register_screen_bloc.dart';
import 'package:eshop/features/auth/presentation/blocs/update_password_screen_bloc/update_password_screen_bloc.dart';
import 'package:eshop/features/home/data/data_source/remote/all_products_category_service.dart';
import 'package:eshop/features/home/data/data_source/remote/products_service.dart';
import 'package:eshop/features/home/data/data_source/remote/user_service.dart';
import 'package:eshop/features/home/data/repository/all_product_categories_repository_impl.dart';
import 'package:eshop/features/home/data/repository/products_repository_impl.dart';
import 'package:eshop/features/home/data/repository/user_repository_impl.dart';
import 'package:eshop/features/home/domain/repository/all_products_category_repository.dart';
import 'package:eshop/features/home/domain/repository/products_repository.dart';
import 'package:eshop/features/home/domain/repository/user_repository.dart';
import 'package:eshop/features/home/domain/usecases/get_all_products_categories_usecase.dart';
import 'package:eshop/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:eshop/features/home/domain/usecases/get_user_info_usecase.dart';
import 'package:eshop/features/home/presentation/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initDep() async {
  //blocs
  sl.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUsecase: sl.call(),
    ),
  );
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
      loginUsecase: sl.call(),
    ),
  );
  sl.registerFactory<EmailForOtpScreenBloc>(
    () => EmailForOtpScreenBloc(
      sendOtpUsecase: sl.call(),
    ),
  );
  sl.registerFactory<OtpVerificationBloc>(
    () => OtpVerificationBloc(
      verifyOtpUsecase: sl.call(),
      resendOtpUsecase: sl.call(),
    ),
  );
  sl.registerFactory<UpdatePasswordScreenBloc>(
    () => UpdatePasswordScreenBloc(
      updatePasswordUsecase: sl.call(),
    ),
  );

  sl.registerFactory<HomeBloc>(
    () => HomeBloc(
      getAllProductCategoriesUsecase: sl.call(),
      getUserInfoUsecase: sl.call(),
      getAllProductsUsecase: sl.call(),
    ),
  );

  //services
  sl.registerSingleton<AuthService>(AuthService());

  sl.registerSingleton<UserService>(UserService());

  sl.registerSingleton<AllProductsCategoryService>(
      AllProductsCategoryService());

  sl.registerSingleton<ProductsService>(ProductsService());

  //repositories
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authService: sl.call(),
    ),
  );

  sl.registerSingleton<AllProductsCategoryRepository>(
    AllProductCategoriesImpl(
      allProductsCategoryService: sl.call(),
    ),
  );

  sl.registerSingleton<UserRepoSitory>(
    UserRepositoryImpl(
      userService: sl.call(),
    ),
  );

  sl.registerSingleton<ProductsRepository>(
    ProductsRepositoryImpl(
      productsService: sl.call(),
    ),
  );

  //usecase
  sl.registerSingleton<LoginUsecase>(
    LoginUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<RegisterUsecase>(
    RegisterUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<SendOtpUsecase>(
    SendOtpUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<VerifyOtpUsecase>(
    VerifyOtpUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<ResendOtpUsecase>(
    ResendOtpUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<UpdatePasswordUsecase>(
    UpdatePasswordUsecase(
      authRepository: sl.call(),
    ),
  );

  sl.registerSingleton<GetUserInfoUsecase>(
    GetUserInfoUsecase(
      userRepoSitory: sl.call(),
    ),
  );

  sl.registerSingleton<GetAllProductCategoriesUsecase>(
    GetAllProductCategoriesUsecase(
      allProductsCategoryRepository: sl.call(),
    ),
  );

  sl.registerSingleton<GetAllProductsUsecase>(
    GetAllProductsUsecase(
      productsRepository: sl.call(),
    ),
  );
}
