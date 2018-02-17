import 'package:comiko/pages/is_page.dart';
import 'package:comiko/widgets/artist_image.dart';
import 'package:comiko_shared/models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

class ArtistPage extends StatelessWidget implements IsPage {
  final Artist artist;

  const ArtistPage({@required this.artist});

  @override
  Widget build(BuildContext context) {
    final _appBarHeight = 256.0;

    return new Scaffold(
      primary: false,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: _appBarHeight,
            pinned: true,
            floating: false,
            snap: false,
            flexibleSpace: new FlexibleSpaceBar(
              title: new Text(artist.name),
              background: new Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  new ArtistImage(
                    url: artist.imageUrl,
                    height: _appBarHeight,
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: <Color>[Colors.black54, Colors.transparent],
                          begin: FractionalOffset.bottomCenter),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildListDelegate(
              [
                socialWidgets(artist, context),
                bioWidgets(context, artist),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  AppActionsFactory get actionsFactory => (context) => [];

  @override
  String get title => artist.name;
}

Column bioWidgets(BuildContext context, Artist artist) => new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new ListTile(
          leading: const Icon(Icons.info),
          title: new Text(
            'Biographie',
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        new Container(
          padding: const EdgeInsets.only(
            left: 72.0,
            right: 16.0,
            bottom: 16.0,
          ),
          child: new Text(artist.bio, style: Theme.of(context).textTheme.body1),
        ),
      ],
    );

Widget socialWidgets(Artist artist, BuildContext context) => new Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      new SocialIcon(
        url: artist.facebook,
        leadingIcon: FontAwesomeIcons.facebook,
      ),
      new SocialIcon(
        url: artist.twitter,
        leadingIcon: FontAwesomeIcons.twitter,
      ),
      new SocialIcon(
        url: artist.youtube,
        leadingIcon: FontAwesomeIcons.youtube,
      ),
      new SocialIcon(
        url: artist.website,
        leadingIcon: FontAwesomeIcons.chrome,
      ),
    ].where((w) => w is! Container).toList());

class SocialIcon extends StatelessWidget {
  final String url;
  final IconData leadingIcon;

  const SocialIcon({
    @required this.url,
    @required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) => url == null
      ? new Container()
      : new IconButton(
          icon: new Icon(leadingIcon),
          onPressed: () => launch(url),
        );
}
