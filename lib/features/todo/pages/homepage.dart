import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/common/utils/constants.dart';
import 'package:task_manager/common/widgets/appstyle.dart';
import 'package:task_manager/common/widgets/custom_text_field.dart';
import 'package:task_manager/common/widgets/height_spacer.dart';
import 'package:task_manager/common/widgets/reusable_text.dart';
import 'package:task_manager/common/widgets/width_spacer.dart';
import 'package:task_manager/common/widgets/xpansion_tile.dart';
import 'package:task_manager/features/todo/controllers/xpansion_provider.dart';
import 'package:task_manager/features/todo/widgets/todo_tile.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final TextEditingController search = TextEditingController();
  late final TabController tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: "Dashboard",
                      style: appStyle(18, AppConst.kLight, FontWeight.bold),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: AppConst.kLight,
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.add,
                          color: AppConst.kBkDark,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const HeightSpacer(height: 20),
              CustomTextField(
                hintText: "Search",
                controller: search,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(14),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      AntDesign.search1,
                      color: AppConst.kGreyLight,
                    ),
                  ),
                ),
                suffixIcon:
                    const Icon(FontAwesome.sliders, color: AppConst.kGreyLight),
              ),
              const HeightSpacer(height: 15),
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HeightSpacer(height: 25),
            Row(
              children: [
                const Icon(
                  FontAwesome.tasks,
                  size: 20,
                  color: AppConst.kLight,
                ),
                const WidthSpacer(width: 25),
                ReusableText(
                    text: "Today's Task",
                    style: appStyle(18, AppConst.kLight, FontWeight.bold))
              ],
            ),
            const HeightSpacer(height: 25),
            Container(
              decoration: const BoxDecoration(
                color: AppConst.kLight,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
              ),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const BoxDecoration(
                    color: AppConst.kGreyLight,
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  controller: tabController,
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: AppConst.kBlueLight,
                  labelStyle:
                      appStyle(24, AppConst.kBlueLight, FontWeight.w700),
                  unselectedLabelColor: AppConst.kLight,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: AppConst.kWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                              text: "Pending",
                              style: appStyle(
                                  16, AppConst.kBkDark, FontWeight.bold)),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        padding: EdgeInsets.only(left: 30.w),
                        width: AppConst.kWidth * 0.5,
                        child: Center(
                          child: ReusableText(
                              text: "Completed",
                              style: appStyle(
                                  16, AppConst.kBkDark, FontWeight.bold)),
                        ),
                      ),
                    )
                  ]),
            ),
            const HeightSpacer(height: 20),
            SizedBox(
              height: AppConst.kHeight * 0.3,
              width: AppConst.kWidth,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(14),
                ),
                child: TabBarView(controller: tabController, children: [
                  Container(
                    color: AppConst.kBkLight,
                    height: AppConst.kHeight * 0.3,
                    child: ListView(
                      children: [
                        ToDoTile(
                          start: "04:15",
                          end: "12:00",
                          switcher: Switch(value: false, onChanged: (value) {}),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: AppConst.kBkLight,
                    height: AppConst.kHeight * 0.3,
                    child: ListView(
                      children: const [
                        ToDoTile(
                          start: "04:15",
                          end: "12:00",
                          switcher: Icon(Icons.check_circle),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
            const HeightSpacer(height: 10),
            XpansionTile(
              text: "Tomorrow's Task",
              text2: "Upcoming tasks show here.",
              onExpansionChanged: (bool expanded) =>
                  ref.read(xpansionStateProvider.notifier).setStart(!expanded),
              trailing: Padding(
                padding: EdgeInsets.only(right: 12.0.w),
                child: ref.watch(xpansionStateProvider)
                    ? const Icon(
                        AntDesign.circledown,
                        color: AppConst.kLight,
                      )
                    : const Icon(
                        AntDesign.closecircleo,
                        color: AppConst.kBlueLight,
                      ),
              ),
              children: [
                ToDoTile(
                  start: "02:15",
                  end: "05:00",
                  switcher: Switch(value: false, onChanged: (value) {}),
                )
              ],
            ),
            const HeightSpacer(height: 10),
            XpansionTile(
              text: DateTime.now()
                  .add(const Duration(days: 2))
                  .toString()
                  .substring(5, 10),
              text2: "Future tasks show here.",
              onExpansionChanged: (bool expanded ) =>
                  ref.read(xpansionState0Provider.notifier).setStart(!expanded),
              trailing: Padding(
                padding: EdgeInsets.only(right: 12.0.w),
                child: ref.watch(xpansionState0Provider)
                    ? const Icon(
                  AntDesign.circledown,
                  color: AppConst.kLight,
                )
                    : const Icon(
                  AntDesign.closecircleo,
                  color: AppConst.kBlueLight,
                ),
              ),
              children: [
                ToDoTile(
                  start: "02:15",
                  end: "05:00",
                  switcher: Switch(value: false, onChanged: (value) {}),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
