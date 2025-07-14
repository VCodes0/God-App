import 'package:flutter/material.dart';
import 'package:god_app/providers/popular_wallpaper_provider.dart';
import 'package:god_app/providers/recently_used_provider.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../main.dart';
import '../../../providers/god_category_provider.dart';
import '../../../widgets/search_bar_widget.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GodCategoryProvider>(
      context,
      listen: false,
    ).fetchGodCategories();
    Provider.of<PopularWallpaperProvider>(
      context,
      listen: false,
    ).fetchWallpapers();
    Provider.of<RecentlyUsedProvider>(
      context,
      listen: false,
    ).fetchRecentWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wallpaper")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mq.height * .02),
            SearchBarWidget(
              onChanged: (query) {
                Provider.of<GodCategoryProvider>(
                  context,
                  listen: false,
                ).filterGodCategories(query);
              },
            ),
            SizedBox(height: mq.height * .02),

            // 🔹 God Categories
            Consumer<GodCategoryProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    height: mq.height * .15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.filteredCategories.length,
                      itemBuilder: (context, index) {
                        final category = provider.filteredCategories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: category.catImage != null
                                    ? CachedNetworkImageProvider(
                                        category.catImage!,
                                      )
                                    : null,
                                child: category.catImage == null
                                    ? const Icon(Icons.image_not_supported)
                                    : null,
                              ),
                              const SizedBox(height: 4),
                              SizedBox(
                                width: 80,
                                child: Text(
                                  category.catName ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),

            SizedBox(height: mq.height * .025),
            Container(
              width: mq.width * .94,
              height: mq.height * .32,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recently Used",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: mq.height * .02),
                  Expanded(
                    child: Consumer<RecentlyUsedProvider>(
                      builder: (context, controller, child) {
                        if (controller.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.recentItems.length,
                            itemBuilder: (context, index) {
                              final item = controller.recentItems[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: mq.width * .4,
                                      height: mq.height * .21,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child:
                                            item.postImage != null &&
                                                item.postImage!.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: item.postImage!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                          Icons.broken_image,
                                                          size: 50,
                                                        ),
                                              )
                                            : const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 40,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: mq.width * .94,
              height: mq.height * .32,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Popular",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: mq.height * .02),
                  Expanded(
                    child: Consumer<PopularWallpaperProvider>(
                      builder: (context, controller, child) {
                        if (controller.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.popwallpapers.length,
                            itemBuilder: (context, index) {
                              final item = controller.popwallpapers[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: mq.width * .4,
                                      height: mq.height * .21,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child:
                                            item.postImage != null &&
                                                item.postImage!.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: item.postImage!,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                          Icons.broken_image,
                                                          size: 50,
                                                        ),
                                              )
                                            : const Center(
                                                child: Icon(
                                                  Icons.image_not_supported,
                                                  size: 40,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: mq.height * .07),
          ],
        ),
      ),
    );
  }
}
