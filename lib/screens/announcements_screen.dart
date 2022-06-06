import 'package:cached_network_image/cached_network_image.dart';
import 'package:cia/blocs/announcement/announcement_bloc.dart';
import 'package:cia/config/theme.dart';
import 'package:cia/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: AnnouncementsList()
      ),
    );
  }
}

class AnnouncementsList extends StatefulWidget{
  const AnnouncementsList({Key? key}) : super(key: key);
  @override
  State<AnnouncementsList> createState() => _AnnouncementsListState();
}

class _AnnouncementsListState extends State<AnnouncementsList> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AnnouncementBloc, AnnouncementState>(
        builder: (context, state) {
          if(state is AnnouncementLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is AnnouncementLoaded) {
            return PageView(
              scrollDirection: Axis.vertical,
              children: state.announcements.map((Announcement announcement) {
                return announcement.type == AnnouncementType.poster
                    ? _AnnouncementPoster(announcement: announcement,)
                    : _AnnouncementTile(announcement: announcement,);
              }).toList(),
            );
          }
          return const Center(child: Text("Something went wrong!"));
        }
    );
  }
}

class _AnnouncementPoster extends StatefulWidget {

  final Announcement announcement;

  const _AnnouncementPoster({Key? key, required this.announcement}) : super(key: key);

  @override
  State<_AnnouncementPoster> createState() => _AnnouncementPosterState();
}

class _AnnouncementPosterState extends State<_AnnouncementPoster> {

  bool overlayShow = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(imageUrl: widget.announcement.imageUrl,),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: overlayShow ?
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)
                )
              ),
              child: ListTile(
                title: Text(widget.announcement.description, style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white),),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      overlayShow = false;
                    });
                  },
                  icon: Icon(Icons.close, color: Colors.white.withOpacity(0.6),),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          try {
                            launchUrl(Uri.parse("tel:${widget.announcement.contactNo}"));
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        icon: Icon(Icons.phone, color: Colors.white.withOpacity(0.6),),
                    ),
                    const SizedBox(width: 30.0,),
                    IconButton(
                      onPressed: () {
                        try {
                          launchUrl(Uri.parse("mailto:${widget.announcement.contactEmail}"));
                        }catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      icon: Icon(Icons.email, color: Colors.white.withOpacity(0.6),),
                    ),
                  ],
                ),
              ),
              ) : Container(),
          ),
        )
      ],
    );
  }
}

class _AnnouncementTile extends StatelessWidget {
  final Announcement announcement;
  const _AnnouncementTile({Key? key, required this.announcement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: CachedNetworkImageProvider(announcement.imageUrl),
          fit: BoxFit.fill
        ),
      ),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(13),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(announcement.title!, style: Theme.of(context).textTheme.headline2,),
              ),
              Expanded(
                  child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(announcement.description, style: TextStyle(fontSize: 16)),
                ],
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {
                      try {
                        launchUrl(Uri.parse("tel:${announcement.contactNo}"));
                      } catch(e) {
                        debugPrint(e.toString());
                      }
                    }, icon: const Icon(Icons.call)),
                    IconButton(onPressed: () {
                      try {
                        launchUrl(Uri.parse("mailto:${announcement.contactEmail}"));
                      } catch(e) {
                        debugPrint(e.toString());
                      }
                    }, icon: const Icon(Icons.email)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

