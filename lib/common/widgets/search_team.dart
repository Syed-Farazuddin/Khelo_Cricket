import 'package:crick_hub/common/widgets/custom_button.dart';
import 'package:crick_hub/common/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchTeam extends ConsumerStatefulWidget {
  const SearchTeam({
    super.key,
    required this.onSearch,
  });
  final Function() onSearch;

  @override
  ConsumerState<SearchTeam> createState() => _SearchTeamState();
}

class _SearchTeamState extends ConsumerState<SearchTeam> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: CustomInputField(
              controller: controller,
              label: 'Search for a Team',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Custombutton(
            onTap: widget.onSearch,
            title: "Search",
            showIcon: true,
            width: 100,
            icon: Icons.search,
          ),
        ],
      ),
    );
  }
}
