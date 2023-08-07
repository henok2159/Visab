import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/ui/pages/about_page.dart';
import 'package:tourist_guide/ui/pages/photos_page.dart';
import 'package:tourist_guide/ui/pages/reviews_page.dart';

class SliverApp extends StatelessWidget {
  SliverApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        body: DefaultTabController(
          length: 3,
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                // Add the app bar to the CustomScrollView.
                SliverAppBar(
                  // Provide a standard title.
                  title: Text(title),
                  // Allows the user to reveal the app bar if they begin scrolling
                  // back up the list of items.
                  floating: true,
                  // Display a placeholder widget to visualize the shrinking size.
                  flexibleSpace: Placeholder(),
                  // Make the initial height of the SliverAppBar larger than normal.
                  expandedHeight: 200,
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: "About"),
                        Tab(text: "Photos"),
                        Tab(text: "Reviews"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
                // Next, create a SliverList
                SliverList(
                  // Use a delegate to build items as they're scrolled on screen.
                  delegate: SliverChildListDelegate.fixed(
                    [Column(children: [Text("one"),Text("Two")],),Image.network("https://picsum.photos/200/300?random=2"),Image.network("https://picsum.photos/200/300?random=3")]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}