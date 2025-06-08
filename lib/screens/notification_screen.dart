import 'package:assignment/provider/network_notifier.dart';
import 'package:assignment/provider/notification_provider/notification_provider.dart';
import 'package:assignment/utils/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/theme.dart';
import '../provider/theme_provider.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    _getAllNotificationList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = ref.watch(themeProvider);
    final themeData = CustomTheme.getTheme(isLightMode);
    final notificationList = ref.watch(notificationProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xffFFFFFF),
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeData!.primaryColor,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          // elevation: 4,
          title: Text(
            "Notification",
            style: themeData.textTheme.titleLarge,
          ),
          centerTitle: false,
        ),
        body: notificationList.isLoading
            ? const Center(child: LoadingAnimation())
            : notificationList.notificationList.isEmpty
                ? Center(
                    child: Text(
                      "Notification is not Available",
                      style: themeData.textTheme.titleLarge,
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      var data =
                          notificationList.notificationList.elementAt(index);
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title ?? "",
                              style: themeData.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              data.body ?? "",
                              style: themeData.textTheme.titleSmall!
                                  .copyWith(color: const Color(0xff474747)),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color(0xffD2D2D2),
                      );
                    },
                    itemCount: notificationList.notificationList.length),
      ),
    );
  }

  _getAllNotificationList() async {
    try {
      await ref
          .read(networkProvider.notifier)
          .isNetworkAvailable()
          .then((isNetworkAvailable) {
        if (isNetworkAvailable) {
          ref.read(notificationProvider).setIsLoading(true);
          ref.read(allNotification(""));
        } else {}
      });
    } catch (e) {
      ref.read(notificationProvider).setIsLoading(false);
    }
    FocusScope.of(context).unfocus();
  }
}
