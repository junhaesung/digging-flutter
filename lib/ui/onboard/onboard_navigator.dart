import 'package:digging/ui/circular_loading_view.dart';
import 'package:digging/ui/onboard/DescriptionView.dart';
import 'package:digging/ui/onboard/GenderAndAgeView.dart';
import 'package:digging/ui/onboard/NicknameView.dart';
import 'package:digging/ui/onboard/NoteGroupView.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/repository/onboard_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardBloc, OnboardState>(
      buildWhen: (previous, current) {
        return previous != current && current.status.hasPage();
      },
      builder: (context, state) => Navigator(
        pages: _getPages(state.status),
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }

  List<Page<dynamic>> _getPages(OnboardStatus status) {
    final pages = <Page<dynamic>>[];
    if (status == OnboardStatus.ready) {
      pages.add(MaterialPage(child: DescriptionView()));
    }
    if (status == OnboardStatus.nickname) {
      pages.add(MaterialPage(child: NicknameView()));
    }
    if (status == OnboardStatus.genderAndAge) {
      pages.add(MaterialPage(child: GenderAndAgeView()));
    }
    if (status == OnboardStatus.noteGroup) {
      pages.add(MaterialPage(child: NoteGroupView()));
    }
    if (pages.isEmpty) {
      pages.add(MaterialPage(child: CircularLoadingView()));
    }
    return pages.toList();
  }
}
