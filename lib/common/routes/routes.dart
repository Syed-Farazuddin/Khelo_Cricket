import 'package:crick_hub/feature/authentication/presentation/pages/authentication.dart';
import 'package:crick_hub/feature/dashboard/presentation/dashboard.dart';
import 'package:crick_hub/feature/flpCoin/presentation/pages/flip_coin.dart';
import 'package:crick_hub/feature/match/presentation/pages/match_details.dart';
import 'package:crick_hub/feature/player/presentation/pages/player_details.dart';
import 'package:crick_hub/feature/scoring/data/scoring_models.dart';
import 'package:crick_hub/feature/scoring/presentation/pages/scoring.dart';
import 'package:crick_hub/feature/splashScreens/main_splash.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_team.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/select_teams.dart';
import 'package:crick_hub/feature/startMatch/presentation/pages/start_match.dart';
import 'package:crick_hub/feature/startMatch/presentation/widgets/display_players.dart';
import 'package:crick_hub/feature/tournament/presentation/pages/register_tournament.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static GoRouter router = GoRouter(
    initialLocation: "/splash",
    routes: [
      GoRoute(
        path: "/home",
        name: "/home",
        builder: (context, state) {
          return const DashboardPage();
        },
      ),
      GoRoute(
        path: "/matchDetails",
        name: "/matchDetails",
        builder: (context, state) {
          final extra = state.extra as MatchData;
          return MatchDetails(
            match: extra,
          );
        },
      ),
      GoRoute(
        path: '/playerDetails',
        name: "/playerDetails",
        builder: (context, state) {
          return const PlayerDetails();
        },
      ),
      GoRoute(
        path: "/authentication",
        name: "/authentication",
        builder: (context, state) {
          return const AuthenticationPage();
        },
      ),
      GoRoute(
        path: "/selectPlayer",
        name: "/selectPlayer",
        builder: (context, state) {
          final extra = state.extra as DisplayPlayerData;
          return DisplayPlayers(
            data: extra.data,
            selectBatman: extra.selectbatsman,
            showTeamAllPlayers: extra.showAllPlayers,
            onTap: extra.onTap,
            previousBowlerId: extra.previousPlayerId,
          );
        },
      ),
      GoRoute(
        path: "/startTournament",
        name: "/startTournament",
        builder: (context, state) {
          return const StartTournament();
        },
      ),
      GoRoute(
        path: "/selectTeams",
        name: "/selectTeams",
        builder: (context, state) {
          return const SelectTeams();
        },
      ),
      GoRoute(
        path: "/startMatch",
        name: "/startMatch",
        builder: (context, state) {
          final extras = state.extra;
          debugPrint(extras.toString());
          return const StartOrScheduleMatch(
            startMatch: true,
          );
        },
      ),
      GoRoute(
        path: "/selectTeam",
        name: "/selectTeam",
        builder: (context, state) {
          final StartMatchExtras extra = state.extra as StartMatchExtras;

          return SelectTeam(
            teamName: extra.teamName,
            teamNo: extra.teamNo,
            fetchYourTeams: extra.refreshData,
          );
        },
      ),
      GoRoute(
        path: "/scoring",
        name: "/scoring",
        builder: (context, state) {
          final MatchData extra = state.extra as MatchData;
          return ScoringPage(data: extra);
        },
      ),
      GoRoute(
        path: "/tossCoin",
        name: "/tossCoin",
        builder: (context, state) {
          return const TossMyCoin();
        },
      ),
      GoRoute(
        path: "/splash",
        name: "/splash",
        builder: (context, state) {
          return const MainSplash();
        },
      ),
      GoRoute(
        path: "/getNumber",
        name: "/getNumber",
        builder: (context, state) {
          return const DashboardPage();
        },
      ),
    ],
  );

  void navigateToNewPage(
    BuildContext context,
    String page,
    Object extra,
  ) {
    // This will clear all the previous routes and go to '/newPage'
    GoRouter.of(context).go('/$page', extra: extra);
  }
}
