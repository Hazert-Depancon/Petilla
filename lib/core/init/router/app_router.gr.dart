// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    DetailRoute.name: (routeData) {
      final args = routeData.argsAs<DetailRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: DetailView(
          key: args.key,
          petModel: args.petModel,
        ),
      );
    },
    InChatRoute.name: (routeData) {
      final args = routeData.argsAs<InChatRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: InChatView(
          key: args.key,
          currentUserId: args.currentUserId,
          currentUserEmail: args.currentUserEmail,
          friendUserId: args.friendUserId,
          friendUserEmail: args.friendUserEmail,
          friendUserName: args.friendUserName,
          currentUserName: args.currentUserName,
        ),
      );
    },
    Control.name: (routeData) {
      final args = routeData.argsAs<ControlArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: Control(
          key: args.key,
          showhome: args.showhome,
        ),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          DetailRoute.name,
          path: '/detail',
        ),
        RouteConfig(
          InChatRoute.name,
          path: '/inChat',
        ),
        RouteConfig(
          Control.name,
          path: '/',
        ),
      ];
}

/// generated route for
/// [DetailView]
class DetailRoute extends PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    Key? key,
    required PetModel petModel,
  }) : super(
          DetailRoute.name,
          path: '/detail',
          args: DetailRouteArgs(
            key: key,
            petModel: petModel,
          ),
        );

  static const String name = 'DetailRoute';
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.petModel,
  });

  final Key? key;

  final PetModel petModel;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, petModel: $petModel}';
  }
}

/// generated route for
/// [InChatView]
class InChatRoute extends PageRouteInfo<InChatRouteArgs> {
  InChatRoute({
    Key? key,
    required String currentUserId,
    required String currentUserEmail,
    required String friendUserId,
    required String friendUserEmail,
    required String friendUserName,
    required String currentUserName,
  }) : super(
          InChatRoute.name,
          path: '/inChat',
          args: InChatRouteArgs(
            key: key,
            currentUserId: currentUserId,
            currentUserEmail: currentUserEmail,
            friendUserId: friendUserId,
            friendUserEmail: friendUserEmail,
            friendUserName: friendUserName,
            currentUserName: currentUserName,
          ),
        );

  static const String name = 'InChatRoute';
}

class InChatRouteArgs {
  const InChatRouteArgs({
    this.key,
    required this.currentUserId,
    required this.currentUserEmail,
    required this.friendUserId,
    required this.friendUserEmail,
    required this.friendUserName,
    required this.currentUserName,
  });

  final Key? key;

  final String currentUserId;

  final String currentUserEmail;

  final String friendUserId;

  final String friendUserEmail;

  final String friendUserName;

  final String currentUserName;

  @override
  String toString() {
    return 'InChatRouteArgs{key: $key, currentUserId: $currentUserId, currentUserEmail: $currentUserEmail, friendUserId: $friendUserId, friendUserEmail: $friendUserEmail, friendUserName: $friendUserName, currentUserName: $currentUserName}';
  }
}

/// generated route for
/// [Control]
class Control extends PageRouteInfo<ControlArgs> {
  Control({
    Key? key,
    required bool showhome,
  }) : super(
          Control.name,
          path: '/',
          args: ControlArgs(
            key: key,
            showhome: showhome,
          ),
        );

  static const String name = 'Control';
}

class ControlArgs {
  const ControlArgs({
    this.key,
    required this.showhome,
  });

  final Key? key;

  final bool showhome;

  @override
  String toString() {
    return 'ControlArgs{key: $key, showhome: $showhome}';
  }
}
