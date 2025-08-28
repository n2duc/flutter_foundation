import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:flutter_base/notification/notification.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  static const routeName = 'notification';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _bloc = getIt<NotificationCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.loadNotifications();
    _bloc.loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: RFXSpacing.spacing16,
                  horizontal: RFXSpacing.spacing20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notification',
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: RFXSpacing.spacing6),
                        Text(
                          'You always get the latest news',
                          style: textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    AvatarProfile(
                      avatarUrl:
                          "https://cdnphoto.dantri.com.vn/eJdf4Hj7FwFUFPstG0vVi--cJDw=/thumb_w/960/2019/12/20/diem-danh-12-hot-girl-noi-bat-nhat-nam-2019-docx-1576850955802.jpeg",
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: RFXSpacing.spacing20,
                  vertical: RFXSpacing.spacing10,
                ),
                child: Container(
                  height: RFXSpacing.spacing40,
                  decoration: BoxDecoration(
                    color: RFXColors.lightPrimary,
                    borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
                  ),
                  padding: const EdgeInsets.all(RFXSpacing.spacing2),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(RFXSpacing.spacing8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    dividerColor: Colors.transparent,
                    labelStyle: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: Colors.white,
                    tabs: const [
                      Tab(text: 'Notification'),
                      Tab(text: 'Activity'),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: TabBarView(
                  children: [
                    BlocSelector<
                      NotificationCubit,
                      NotificationState,
                      List<Map<String, dynamic>>
                    >(
                      bloc: _bloc,
                      selector: (state) {
                        if (state is NotificationStateSuccess) {
                          return state.listNotification;
                        }
                        return [];
                      },
                      builder: (context, notifications) {
                        if (notifications.isEmpty) {}
                        return ListView.separated(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            return NotificationItem(
                              notification: notifications[index],
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(
                            color: RFXColors.lightOutlineVariant,
                            height: 1,
                          ),
                        );
                      },
                    ),
                    BlocSelector<
                      NotificationCubit,
                      NotificationState,
                      List<Map<String, dynamic>>
                    >(
                      bloc: _bloc,
                      selector: (state) {
                        if (state is NotificationStateSuccess) {
                          return state.listActivity;
                        }
                        return [];
                      },
                      builder: (context, activities) {
                        if (activities.isEmpty) {}
                        return ListView.separated(
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            return NotificationItem(
                              notification: activities[index],
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(
                            color: RFXColors.lightOutlineVariant,
                            height: 1,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
