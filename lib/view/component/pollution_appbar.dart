import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionAppbarWhite extends StatelessWidget
    implements PreferredSizeWidget {
  const PollutionAppbarWhite({
    super.key,
    required this.appBarHeight,
    required this.appBarTitle,
    required this.appBarActions,
  });

  final double appBarHeight;
  final String appBarTitle;
  final List<Widget> appBarActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      title: Text(
        appBarTitle,
        style: PollutionTextStyle.g18_w700.copyWith(
          color: Colors.black,
        ),
      ),
      actions: appBarActions,
      toolbarHeight: appBarHeight,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class PollutionAppbarBackground extends StatelessWidget
    implements PreferredSizeWidget {
  const PollutionAppbarBackground({
    super.key,
    required this.appBarHeight,
    required this.appBarTitle,
    required this.appBarActions,
  });

  final double appBarHeight;
  final String appBarTitle;
  final List<Widget> appBarActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      surfaceTintColor: Theme.of(context).colorScheme.background,
      shadowColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Row(
        children: [
          Text(
            appBarTitle,
            style: PollutionTextStyle.g18_w500.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: appBarActions,
      toolbarHeight: appBarHeight,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBarHeight);
}

class PollutionAppbarTransparent extends StatelessWidget
    implements PreferredSizeWidget {
  const PollutionAppbarTransparent({
    super.key,
    required this.appBarHeight,
    required this.appBarTitle,
    required this.appBarActions,
  });

  final double appBarHeight;
  final String appBarTitle;
  final List<Widget> appBarActions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      title: Row(
        children: [
          Text(
            appBarTitle,
            style: PollutionTextStyle.g18_w500.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: appBarActions,
      toolbarHeight: appBarHeight,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
