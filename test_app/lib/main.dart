import 'package:cc_essentials/api_client/api_client.dart';
import 'package:cc_essentials/cc_essentials.dart';
import 'package:cc_essentials/helpers/generic_controller/generic_controller.dart';
import 'package:cc_essentials/helpers/generic_service/generic_service.dart';
import 'package:cc_essentials/helpers/logging/logger.dart';
import 'package:cc_essentials/theme/custom_theme.dart';
import 'package:cc_essentials/ui/carousels.dart';
import 'package:cc_essentials/ui/drop_down.dart';
import 'package:cc_essentials/ui/elevated_button.dart';
import 'package:cc_essentials/ui/line_chart.dart';
import 'package:cc_essentials/ui/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_app/exModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CCEssentials.initialize(
      primaryColor: Colors.orange, accentColor: Colors.teal);
  Get.put(ApiClient('http://..'));

  runApp(MyTestApp());
}

class MyTestApp extends StatelessWidget {
  MyTestApp({super.key});
  final RxInt selectedIndex = 0.obs;
  final Rx<TextEditingController> phoneTextController =
      TextEditingController().obs;

  final List<Map<String, String>> countryCodes = [
    {"name": "United States", "code": "+1"},
    {"name": "India", "code": "+91"},
    {"name": "United Kingdom", "code": "+44"},
    {"name": "Australia", "code": "+61"},
    {"name": "Japan", "code": "+81"},
  ];
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Package Test App',
            home: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Test App for Package',
                  style: textTheme.bodyLarge!
                      .copyWith(fontFamily: FontFamily.openSans.name),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ModernLineChart(
                        dataPoints: const [15, 25, 20, 30, 40],
                        xAxisLabels: const ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
                        title: 'Sales Overview',
                        subTitle: 'Monthly data representation',
                        lineColor: Colors.teal,
                        gridColor: Colors.grey[300]!,
                        titleColor: Colors.white,
                        subTitleColor: Colors.grey,
                        dotColor: Colors.redAccent,
                        chartHeight: 250,
                        showPoints: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: BannerCarousel(
                        height: 100.0,
                        width: double.infinity,
                        imageUrls: const [
                          'https://via.placeholder.com/400x200.png?text=Banner+1',
                          'https://via.placeholder.com/400x200.png?text=Banner+2',
                          'https://via.placeholder.com/400x200.png?text=Banner+3',
                        ],
                        urlsToNavigate: const [
                          'https://www.google.com',
                          'https://www.github.com',
                          'https://www.flutter.dev',
                        ],
                        autoScroll: true,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.blue,
                        dotsVisible: true,
                        borderRadius: 16.0,
                      ),
                    ),
                    CustomElevatedButton(
                      onPressed: () async {
                        final GenericService loginService =
                            GenericService(Get.find<ApiClient>());
                        logger.i(
                            '${countryCodes[selectedIndex.value]["code"]!}${phoneTextController.value.text}');
                        final loginController = GenericController<Data>(
                          fetchData: () =>
                              loginService.postData(endpoint: '/..', data: {
                            'phone':
                                '${countryCodes[selectedIndex.value]["code"]!}${phoneTextController.value.text}'
                          }),
                          modelMapper: (data) => Data.fromJson(data),
                        );
                        await loginController.fetchItems();
                        logger.i(loginController.data.value?.toJson() ?? '');
                      },
                      fixedSize: const Size(300, 60),
                      child: Text(
                        "Next",
                        style: textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          ReactiveDropdown(
                            selectedIndex: selectedIndex,
                            items: countryCodes.map((country) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    country["name"]!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const Spacer(),
                                  const VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Text(
                                    country["code"]!,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              );
                            }).toList(),
                            dropdownColor: Colors.blue.shade50,
                            borderRadius: 25.w,
                          ),
                          Obx(
                            () {
                              String selectedCode =
                                  countryCodes[selectedIndex.value]["code"]!;
                              return SizedBox(
                                width: ScreenUtil().screenWidth,
                                child: CustomTextField(
                                  controller: phoneTextController,
                                  width: double.infinity,
                                  height: 56.h,
                                  hintText: 'Phone number',
                                  hintStyle: textTheme.bodyLarge,
                                  keyboardType: TextInputType.phone,
                                  prefixIcon: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 12.h),
                                    margin: EdgeInsets.only(right: 5.w),
                                    child: Text(
                                      selectedCode,
                                      style: textTheme.bodyLarge,
                                    ),
                                  ),
                                  borderWidth: 1.0,
                                  borderRadius: 25.w,
                                  textStyle: textTheme.bodyLarge,
                                  filled: false,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
