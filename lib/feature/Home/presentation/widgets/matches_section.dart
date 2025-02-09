import 'package:crick_hub/common/loaders/loader.dart';
import 'package:crick_hub/common/widgets/show_matches.dart';
import 'package:crick_hub/feature/Home/data/home_repository.dart';
import 'package:crick_hub/feature/startMatch/data/models/start_match_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MatchesSection extends ConsumerStatefulWidget {
  const MatchesSection({
    super.key,
  });
  @override
  ConsumerState<MatchesSection> createState() => _MatchesSectionState();
}

class _MatchesSectionState extends ConsumerState<MatchesSection> {
  List<MatchData> matches = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setState(() {
      loading = true;
    });
    matches = await ref.read(homeRepositoryProvider).getYourMatches();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? const Loader() : ShowMatches(matches: matches);
  }
}
