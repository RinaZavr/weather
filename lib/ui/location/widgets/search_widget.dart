import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/ui/location/cubit/search_cubit.dart';
import 'package:weather/utils/consts/color_consts.dart';
import 'package:weather/utils/consts/string_consts.dart';

class SearchWidget extends StatefulWidget {
  final SearchCubit searchCubit;
  final ValueChanged canEdit;
  const SearchWidget(
      {super.key, required this.searchCubit, required this.canEdit});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String search = '';
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        focusNode: focusNode,
        style: ThemeProvider.controllerOf(context)
            .theme
            .data
            .textTheme
            .titleMedium
            ?.copyWith(color: AppColors.grey),
        onChanged: (value) {
          setState(() {
            search = value;
            if (value == '') {
              widget.canEdit(true);
            }
          });
        },
        onEditingComplete: () {
          focusNode.unfocus();
          if (search != '') {
            widget.canEdit(false);
            widget.searchCubit.search(search.trim());
          }
        },
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(4),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.grey,
          ),
          hintText: AppStrings.hintSearchLocation,
        ),
      ),
    );
  }
}
