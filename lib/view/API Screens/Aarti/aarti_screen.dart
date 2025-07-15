import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main.dart';
import '../../../providers/festival_provider.dart';
import '../../../providers/recently_played_provider.dart';
import '../../../providers/trending_aarti_provider.dart';
import '../../../widgets/search_bar_widget.dart';

class AartiScreen extends StatefulWidget {
  const AartiScreen({super.key});

  @override
  State<AartiScreen> createState() => _AartiState();
}

class _AartiState extends State<AartiScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<RecentlyPlayedProvider>(
      context,
      listen: false,
    ).getRecentlyPlayedData();
    Provider.of<TrendingAartiProvider>(
      context,
      listen: false,
    ).getTrendingAartiData();
    Provider.of<FestivalProvider>(
      context,
      listen: false,
    ).getFestivalAartiData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(title: const Text("Aarti")),
        body: SafeArea(
          child: SizedBox(
            height: mq.height,
            width: mq.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SearchBarWidget(
                    onChanged: (query) {
                      Provider.of<RecentlyPlayedProvider>(
                        context,
                        listen: false,
                      ).filterAarti(query);
                      Provider.of<TrendingAartiProvider>(
                        context,
                        listen: false,
                      ).filterAarti(query);
                      Provider.of<FestivalProvider>(
                        context,
                        listen: false,
                      ).filterAarti(query);
                    },
                  ),
                  Container(
                    width: mq.width * .94,
                    height: mq.height * .32,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Recently Played",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: mq.height * .02),
                        // 👇 Consumer to show loading/list
                        Expanded(
                          child: Consumer<RecentlyPlayedProvider>(
                            builder: (context, controller, child) {
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (controller.recentlyPlayed.isEmpty) {
                                return const Center(child: Text("No data found"));
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.recentlyPlayed.length,
                                  itemBuilder: (context, index) {
                                    final item = controller.recentlyPlayed[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: mq.width * .4,
                                            height: mq.height * .21,
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade200,
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                              child:
                                                  item.mainImage != null &&
                                                      item.mainImage!.isNotEmpty
                                                  ? Image.network(
                                                      item.mainImage!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => const Icon(
                                                            Icons.broken_image,
                                                            size: 50,
                                                            color: Colors.grey,
                                                          ),
                                                    )
                                                  : const Center(
                                                      child: Icon(
                                                        Icons.image_not_supported,
                                                        size: 40,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              item.title ?? 'No Title',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Trending Aarti’s",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: mq.height * .02),
                        // 👇 Consumer to show loading/list
                        Expanded(
                          child: Consumer<TrendingAartiProvider>(
                            builder: (context, controller, child) {
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (controller.trendingAarti.isEmpty) {
                                return const Center(child: Text("No data found"));
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.trendingAarti.length,
                                  itemBuilder: (context, index) {
                                    final item = controller.trendingAarti[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: mq.width * .4,
                                            height: mq.height * .21,
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade200,
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                              child:
                                                  item.mainImage != null &&
                                                      item.mainImage!.isNotEmpty
                                                  ? Image.network(
                                                      item.mainImage!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => const Icon(
                                                            Icons.broken_image,
                                                            size: 50,
                                                            color: Colors.grey,
                                                          ),
                                                    )
                                                  : const Center(
                                                      child: Icon(
                                                        Icons.image_not_supported,
                                                        size: 40,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              item.title ?? 'No Title',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              "Festival",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: mq.height * .02),
                        // 👇 Consumer to show loading/list
                        Expanded(
                          child: Consumer<FestivalProvider>(
                            builder: (context, controller, child) {
                              if (controller.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (controller.getFestivalData.isEmpty) {
                                return const Center(child: Text("No data found"));
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller.getFestivalData.length,
                                  itemBuilder: (context, index) {
                                    final item =
                                        controller.getFestivalData[index];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: mq.width * .4,
                                            height: mq.height * .21,
                                            decoration: BoxDecoration(
                                              color: Colors.orange.shade200,
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                              shape: BoxShape.rectangle,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                              child:
                                                  item.catImage != null &&
                                                      item.catImage!.isNotEmpty
                                                  ? Image.network(
                                                      item.catImage!,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (
                                                            context,
                                                            error,
                                                            stackTrace,
                                                          ) => const Icon(
                                                            Icons.broken_image,
                                                            size: 50,
                                                            color: Colors.grey,
                                                          ),
                                                    )
                                                  : const Center(
                                                      child: Icon(
                                                        Icons.image_not_supported,
                                                        size: 40,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              item.name ?? 'No Title',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
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
                  SizedBox(height: mq.height * .1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
