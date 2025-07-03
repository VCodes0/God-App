import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/recently_played_controller.dart';
import '../../widgets/search_bar.dart';

class Aarti extends StatefulWidget {
  const Aarti({super.key});

  @override
  State<Aarti> createState() => _AartiState();
}

class _AartiState extends State<Aarti> {
  @override
  void initState() {
    super.initState();
    Provider.of<RecentlyPlayedController>(
      context,
      listen: false,
    ).getRecentlyPlayedData();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text("Aarti")),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SearchBarWidget(),
            Container(
              width: mq.width * .94,
              height: mq.height * .32,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recently Played",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "View all",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: mq.height * .02),
                  // 👇 Consumer to show loading/list
                  Expanded(
                    child: Consumer<RecentlyPlayedController>(
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
                                        borderRadius: BorderRadius.circular(15),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Trending Aarti’s",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "View all",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: mq.height * .02),
                  // 👇 Consumer to show loading/list
                  Expanded(
                    child: Consumer<RecentlyPlayedController>(
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
                                        borderRadius: BorderRadius.circular(15),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
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
          ],
        ),
      ),
    );
  }
}
