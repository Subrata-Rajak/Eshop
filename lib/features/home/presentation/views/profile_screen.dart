import 'package:eshop/config/routes/route_args.dart';
import 'package:eshop/config/routes/route_paths.dart';
import 'package:eshop/core/common/widgets.dart';
import 'package:eshop/core/values/colors.dart';
import 'package:eshop/features/home/presentation/blocs/profile_screen_bloc/profile_Screen_bloc.dart';
import 'package:eshop/features/home/presentation/blocs/profile_screen_bloc/profile_screen_events.dart';
import 'package:eshop/features/home/presentation/blocs/profile_screen_bloc/profile_screen_states.dart';
import 'package:eshop/features/home/presentation/widgets/profile_screen_activity_card.dart';
import 'package:eshop/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entity/user_entity.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with CommonWidgets {
  late UserEntity? globalUser;
  final activityNames = [
    "Edit Profile",
    "Wishlist",
    "Shipping Address",
    "Payment Methods",
    "Order History",
    "Delivery Status",
    "Language",
  ];
  final activityIcons = [
    FontAwesomeIcons.userPen,
    FontAwesomeIcons.solidHeart,
    FontAwesomeIcons.flag,
    FontAwesomeIcons.creditCard,
    FontAwesomeIcons.list,
    FontAwesomeIcons.locationPin,
    FontAwesomeIcons.language,
  ];

  @override
  Widget build(BuildContext context) {
    final activityFunctions = [
      editProfileActivity,
      wishlistActivity,
      shippingAddressActivity,
      () {},
      () {},
      () {},
      () {},
    ];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider<ProfileScreenBloc>(
        create: (context) => sl(),
        child: BlocBuilder<ProfileScreenBloc, ProfileScreenStates>(
          builder: (context, state) {
            if (state is ProfileScreenInitialState) {
              context
                  .read<ProfileScreenBloc>()
                  .add(ProfileScreenDataFetchingEvent());
            } else if (state is ProfileScreenFetchingDataState) {
              return Center(
                child:
                    CircularProgressIndicator(color: AppColors.colors.darkBlue),
              );
            } else if (state is ProfileScreenDataFetchingSuccessState) {
              final user = state.user;
              globalUser = user;
              return buildBody(
                user: user,
                size: size,
                activityFunctions: activityFunctions,
              );
            } else if (state is ProfileScreenSataFetchingErrorState) {
              return const Center(
                child: Text("Something wrong happened"),
              );
            }
            return emptyBox();
          },
        ),
      ),
    );
  }

  SafeArea buildBody({
    required UserEntity? user,
    required Size size,
    required List activityFunctions,
  }) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            verticalSpace(height: 20),
            buildHeader(size),
            verticalSpace(height: 30),
            buildUserInfo(size, user),
            verticalSpace(height: 30),
            buildActivityList(
              size,
              activityFunctions,
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildActivityList(Size size, List activityFunctions) {
    return Expanded(
      child: ListView.separated(
        itemCount: activityNames.length,
        itemBuilder: (context, index) {
          return ProfileScreenActivityCard(
            fun: activityFunctions[index],
            size: size,
            icon: activityIcons[index],
            cardText: activityNames[index],
          );
        },
        separatorBuilder: (context, index) {
          return verticalSpace(height: 15);
        },
      ),
    );
  }

  SizedBox buildUserInfo(Size size, UserEntity? user) {
    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user!.profileImageUrl),
          ),
          horizontalSpace(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: TextStyle(
                  color: AppColors.colors.darkBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              verticalSpace(height: 13),
              SizedBox(
                width: 200,
                child: Text(
                  user.email,
                  style: TextStyle(
                    color: AppColors.colors.darkBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox buildHeader(Size size) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: AppColors.colors.darkBlue,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Icon(
              FontAwesomeIcons.gear,
              color: AppColors.colors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }

  wishlistActivity() {
    context.push(AppRoutePaths.paths.wishlistPath);
  }

  shippingAddressActivity() {
    context.push(AppRoutePaths.paths.addressPath);
  }

  editProfileActivity() {
    context.push(
      AppRoutePaths.paths.editProfilePath,
      extra: EditProfileScreenArgs(user: globalUser),
    );
  }
}
