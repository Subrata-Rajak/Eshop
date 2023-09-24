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
import 'package:eshop/features/cart/data/data_source/remote/cart_details_service.dart';
import 'package:eshop/features/cart/data/repository/cart_details_repository_impl.dart';
import 'package:eshop/features/cart/domain/repository/cart_details_repository.dart';
import 'package:eshop/features/cart/domain/usecases/decrease_cart_quantity_usecase.dart';
import 'package:eshop/features/cart/domain/usecases/get_cart_details_usecase.dart';
import 'package:eshop/features/cart/domain/usecases/increase_cart_quantity_usecase.dart';
import 'package:eshop/features/cart/presentation/blocs/cart_details_screen_bloc/cart_details_screen_bloc.dart';
import 'package:eshop/features/home/data/data_source/remote/all_products_category_service.dart';
import 'package:eshop/features/home/data/data_source/remote/products_service.dart';
import 'package:eshop/features/home/data/data_source/remote/user_service.dart';
import 'package:eshop/features/home/data/data_source/remote/wishlist_items_service.dart';
import 'package:eshop/features/home/data/repository/all_product_categories_repository_impl.dart';
import 'package:eshop/features/home/data/repository/products_repository_impl.dart';
import 'package:eshop/features/home/data/repository/user_repository_impl.dart';
import 'package:eshop/features/home/data/repository/wishlist_items_repository_impl.dart';
import 'package:eshop/features/home/domain/repository/all_products_category_repository.dart';
import 'package:eshop/features/home/domain/repository/products_repository.dart';
import 'package:eshop/features/home/domain/repository/user_repository.dart';
import 'package:eshop/features/home/domain/repository/wishlist_items_repository.dart';
import 'package:eshop/features/home/domain/usecases/get_all_products_categories_usecase.dart';
import 'package:eshop/features/home/domain/usecases/get_all_products_usecase.dart';
import 'package:eshop/features/home/domain/usecases/get_user_info_usecase.dart';
import 'package:eshop/features/home/domain/usecases/get_wishlist_usecase.dart';
import 'package:eshop/features/home/presentation/blocs/home_screen_bloc/home_screen_bloc.dart';
import 'package:eshop/features/home/presentation/blocs/profile_screen_bloc/profile_Screen_bloc.dart';
import 'package:eshop/features/home/presentation/blocs/wishlist_screen_bloc/wishlist_screen_bloc.dart';
import 'package:eshop/features/product_details/data/data_source/remote/product_details_cart_service.dart';
import 'package:eshop/features/product_details/data/data_source/remote/product_service.dart';
import 'package:eshop/features/product_details/data/data_source/remote/wishlist_service.dart';
import 'package:eshop/features/product_details/data/repositories/product_details_cart_repository_impl.dart';
import 'package:eshop/features/product_details/data/repositories/product_repository_impl.dart';
import 'package:eshop/features/product_details/data/repositories/wishlist_repository_impl.dart';
import 'package:eshop/features/product_details/domain/repositories/product_repository.dart';
import 'package:eshop/features/product_details/domain/repositories/wishlist_repository.dart';
import 'package:eshop/features/product_details/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/get_product_details_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/is_product_in_cart_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/is_product_in_wishlist_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/pd_add_to_cart_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/pd_remove_from_cart_usecase.dart';
import 'package:eshop/features/product_details/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:eshop/features/product_details/presentation/blocs/product_details_screen_bloc/product_details_screen_bloc.dart';
import 'package:eshop/features/products_by_category/data/data_source/remote/product_by_category_service.dart';
import 'package:eshop/features/products_by_category/data/repository/product_by_category_repository_impl.dart';
import 'package:eshop/features/products_by_category/domain/usecase/get_product_by_category_usecase.dart';
import 'package:eshop/features/products_by_category/presentation/blocs/product_by_category_screen_bloc/product_by_category_screen_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/product_details/domain/repositories/product_details_cart_repository.dart';
import 'features/products_by_category/domain/repository/product_by_category_repository.dart';

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

  sl.registerFactory<ProductDetailsScreenBloc>(
    () => ProductDetailsScreenBloc(
      getProductDetailsUsecase: sl.call(),
      isProductInWishListUsecase: sl.call(),
      addToWishListUseCase: sl.call(),
      removeFromWishlistUsecase: sl.call(),
      pdAddToUsecase: sl.call(),
      pdRemoveFromCartUsecase: sl.call(),
      isProductInCartUsecase: sl.call(),
    ),
  );

  sl.registerFactory<ProfileScreenBloc>(
    () => ProfileScreenBloc(
      getUserInfoUsecase: sl.call(),
    ),
  );

  sl.registerFactory<WishlistScreenBloc>(
    () => WishlistScreenBloc(
      getWishlistUsecase: sl.call(),
      removeFromWishlistUsecase: sl.call(),
    ),
  );

  sl.registerFactory<CartDetailsScreenBloc>(
    () => CartDetailsScreenBloc(
      getCartDetailsUsecase: sl.call(),
      increaseCartQuantityUsecase: sl.call(),
      decreaseCartQuantityUsecase: sl.call(),
    ),
  );

  sl.registerFactory<ProductByCategoryScreenBloc>(
    () => ProductByCategoryScreenBloc(
      getProductByCategoryUsecase: sl.call(),
    ),
  );

  //services
  sl.registerSingleton<AuthService>(AuthService());

  sl.registerSingleton<UserService>(UserService());

  sl.registerSingleton<AllProductsCategoryService>(
    AllProductsCategoryService(),
  );

  sl.registerSingleton<ProductsService>(ProductsService());

  sl.registerSingleton<ProductDetailsService>(ProductDetailsService());

  sl.registerSingleton<WishlistService>(WishlistService());

  sl.registerSingleton<WishlistItemsService>(WishlistItemsService());

  sl.registerSingleton<ProductDetailsCartService>(ProductDetailsCartService());

  sl.registerSingleton<CartDetailsService>(CartDetailsService());

  sl.registerSingleton<ProductByCategoryService>(ProductByCategoryService());

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

  sl.registerSingleton<ProductDetailsRepository>(
    ProductDetailsRepositoryImpl(
      productDetailsService: sl.call(),
    ),
  );

  sl.registerSingleton<WishlistRepository>(
    WishlistRepositoryImpl(
      wishlistService: sl.call(),
    ),
  );

  sl.registerSingleton<WishlistItemsRepository>(
    WishlistItemsRepositoryImpl(
      wishlistItemsService: sl.call(),
    ),
  );

  sl.registerSingleton<ProductDetailsCartRepository>(
    ProductDetailsCartRepositoryImpl(
      productDetailsCartService: sl.call(),
    ),
  );

  sl.registerSingleton<CartDetailsRepository>(
    CartDetailsRepositoryImpl(
      cartDetailsService: sl.call(),
    ),
  );

  sl.registerSingleton<ProductByCategoryRepository>(
    ProductByCategoryRepositoryImpl(
      productByCategoryService: sl.call(),
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

  sl.registerSingleton<GetProductDetailsUsecase>(
    GetProductDetailsUsecase(
      productRepository: sl.call(),
    ),
  );

  sl.registerSingleton<IsProductInWishListUsecase>(
    IsProductInWishListUsecase(
      wishlistRepository: sl.call(),
    ),
  );

  sl.registerSingleton<AddToWishListUseCase>(
    AddToWishListUseCase(
      wishlistRepository: sl.call(),
    ),
  );

  sl.registerSingleton<RemoveFromWishlistUsecase>(
    RemoveFromWishlistUsecase(
      wishlistRepository: sl.call(),
    ),
  );

  sl.registerSingleton<GetWishlistUsecase>(
    GetWishlistUsecase(
      wishlistItemsRepository: sl.call(),
    ),
  );

  sl.registerSingleton<PDAddToUsecase>(
    PDAddToUsecase(
      productDetailsCartRepository: sl.call(),
    ),
  );

  sl.registerSingleton<PDRemoveFromCartUsecase>(
    PDRemoveFromCartUsecase(
      productDetailsCartRepository: sl.call(),
    ),
  );

  sl.registerSingleton<IsProductInCartUsecase>(
    IsProductInCartUsecase(
      productDetailsCartRepository: sl.call(),
    ),
  );

  sl.registerSingleton<GetCartDetailsUsecase>(
    GetCartDetailsUsecase(
      cartDetailsRepository: sl.call(),
    ),
  );

  sl.registerSingleton<IncreaseCartQuantityUsecase>(
    IncreaseCartQuantityUsecase(
      cartDetailsRepository: sl.call(),
    ),
  );

  sl.registerSingleton<DecreaseCartQuantityUsecase>(
    DecreaseCartQuantityUsecase(
      cartDetailsRepository: sl.call(),
    ),
  );

  sl.registerSingleton(
    GetProductByCategoryUsecase(
      productByCategoryRepository: sl.call(),
    ),
  );
}
