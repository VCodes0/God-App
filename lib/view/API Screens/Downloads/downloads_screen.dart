import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../main.dart';
import '../../../providers/all_god_wallpaper_provider.dart';
import '../../../providers/recently_played_provider.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Provider.of<AllGodWallpaperProvider>(
      context,
      listen: false,
    ).getAllGodWallPaperatsData();

    Provider.of<RecentlyPlayedProvider>(
      context,
      listen: false,
    ).getRecentlyPlayedData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> shareAarti(String title) async {
    final result = await Share.share(
      'Listen to this Aarti: $title',
      subject: 'Share Aarti',
    );

    if (result.status == ShareResultStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Aarti shared successfully")),
      );
    } else if (result.status == ShareResultStatus.dismissed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Aarti sharing cancelled")),
      );
    }
  }

  Future<void> shareWallpaper(String imageUrl) async {
    final result = await Share.share(
      'Check out this wallpaper: $imageUrl',
      subject: 'Share Wallpaper',
    );

    if (result.status == ShareResultStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wallpaper shared successfully")),
      );
    } else if (result.status == ShareResultStatus.dismissed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wallpaper sharing cancelled")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloads"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: CupertinoColors.activeOrange,
          labelColor: CupertinoColors.activeOrange,
          tabs: const [
            Tab(child: Text("Aarti")),
            Tab(child: Text("Wallpapers")),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_showAarti(), _showDownloadsWallPaper()],
      ),
    );
  }

  Widget _showAarti() {
    return Consumer<RecentlyPlayedProvider>(
      builder: (context, provider, _) {
        final recentlyPlayed = provider.recentlyPlayed;

        if (recentlyPlayed.isEmpty) {
          return const Center(child: Text("No aarti found."));
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: recentlyPlayed.length,
            itemBuilder: (context, index) {
              final item = recentlyPlayed[index];
              return InkWell(
                onTap: () {
                  // Add navigation or playback logic here
                },
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.music_note)),
                  title: Text(item.title ?? 'Untitled Aarti'),
                  subtitle: Text(item.title ?? 'Unknown'),
                  trailing: IconButton(
                    onPressed: () {
                      shareAarti(item.title ?? 'Untitled Aarti');
                    },
                    icon: const Icon(Icons.share),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _showDownloadsWallPaper() {
    return Consumer<AllGodWallpaperProvider>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.getAllGodWallPapers.isEmpty) {
          return const Center(child: Text("No wallpapers found."));
        } else {
          final wallpapers = controller.getAllGodWallPapers;

          return Padding(
            padding: const EdgeInsets.all(8),
            child: GridView.builder(
              itemCount: wallpapers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 16,
                childAspectRatio: (mq.width * 0.4) / (mq.height * 0.21),
              ),
              itemBuilder: (context, index) {
                final item = wallpapers[index];

                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: item.images != null && item.images!.isNotEmpty
                            ? CachedNetworkImage(
                          imageUrl: item.images!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.broken_image, size: 50),
                        )
                            : const Center(
                          child: Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.share, color: Colors.white),
                        onPressed: () {
                          if (item.images != null &&
                              item.images!.isNotEmpty) {
                            shareWallpaper(item.images!);
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}
