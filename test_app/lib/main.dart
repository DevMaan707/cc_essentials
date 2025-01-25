import 'package:cc_essentials/api_client/api_client.dart';
import 'package:cc_essentials/cc_essentials.dart';
import 'package:cc_essentials/chat/chat_screen.dart';
import 'package:cc_essentials/chat/controller/chat_controller.dart';
import 'package:cc_essentials/chat/models/chat_config.dart';
import 'package:cc_essentials/helpers/generic_controller/generic_controller.dart';
import 'package:cc_essentials/helpers/generic_service/generic_service.dart';
import 'package:cc_essentials/helpers/logging/logger.dart';

import 'package:cc_essentials/ui/carousels.dart';
import 'package:cc_essentials/ui/drop_down.dart';
import 'package:cc_essentials/ui/elevated_button.dart';
import 'package:cc_essentials/ui/line_chart.dart';
import 'package:cc_essentials/ui/otp_bottom_sheet.dart';
import 'package:cc_essentials/ui/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'exModel.dart' as ex;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await CCEssentials.initialize(
    primaryColor: Colors.orange,
    accentColor: Colors.teal,
    navigatorKey: navigatorKey,
  );
  Get.put(ApiClient('http://wedzing-backend-offline.coffeecodes.in'));

  runApp(const MyTestApp());
}

class MyTestApp extends StatelessWidget {
  const MyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Package Test App',
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return HomeScreen();
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final RxBool isLoading = false.obs;
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
    final RxString otpValue = ''.obs;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Test App for Package',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomElevatedButton(
              onPressed: () async {
                final chatConfig = await ChatConfig(
                  primaryColor: Colors.blue,
                  secondaryColor: Colors.grey,
                  saveToLocal: true,
                  messagesPerPage: 20,
                  isConversationEnd: (response) => response['isEnd'] == true,
                );

                Get.put(ChatController(config: chatConfig));
                Get.to(ChatScreen());
              },
              child: const Text("Chat Screen"),
            ),
            CustomElevatedButton(
              onPressed: () {
                OtpWidget.showOtpModal(
                  isLoading: RxBool(false),
                  width: ScreenUtil().screenWidth,
                  titleTextStyle: textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                  context: context,
                  otpValue: otpValue,
                  otpLength: 6,
                  fieldWidth: 48,
                  fieldHeight: 56,
                  borderRadius: 12,
                  defaultColor: Colors.white,
                  focusedColor: Colors.blue,
                  errorColor: Colors.red,
                  padding2: const EdgeInsets.only(bottom: 20),
                  padding3: const EdgeInsets.only(top: 20),
                  padding4: const EdgeInsets.only(bottom: 20),
                  title: 'Verification',
                  helperText: 'Enter the otp to verify',
                  onResend: () {
                    logger.i("Resend OTP clicked");
                  },
                  onRegister: () {
                    logger.i("Navigate to Register Page");
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "OTP cannot be empty";
                    }
                    if (value.length != 6) {
                      return "Enter a valid 6-digit OTP";
                    }
                    return null;
                  },
                  onComplete: (otp) {
                    logger.i("Entered OTP: $otp");
                  },
                  resendText: "Resend Code",
                  registerText: "Sign Up",
                  showRegisterLink: true,
                  padding: const EdgeInsets.all(16),
                  containerColor: Colors.black,
                  containerBorderRadius: BorderRadius.circular(20),
                  verifySize: const Size(300, 60),
                );
              },
              child: const Text("Open OTP Modal"),
            ),
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
                  try {
                    isLoading.value = true;
                    final GenericService loginService =
                        GenericService(Get.find<ApiClient>());
                    logger.i(
                        '${countryCodes[selectedIndex.value]["code"]!}${phoneTextController.value.text}');
                    final loginController = GenericController<ex.Data>(
                      fetchData: () => loginService
                          .postData(endpoint: '/v1/auth/provider/login', data: {
                        'phone':
                            '${countryCodes[selectedIndex.value]["code"]!}${phoneTextController.value.text}'
                      }),
                      model: (data) => ex.Data.fromJson(data),
                    );
                    await loginController.fetchItems();
                    logger.i(loginController.data.value?.toJson() ?? '');
                    isLoading.value = false;
                  } catch (e) {
                    logger.i(e);
                  } finally {
                    isLoading.value = false;
                  }
                },
                fixedSize: const Size(300, 60),
                child: Obx(() {
                  return (isLoading.value)
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: const CircularProgressIndicator())
                      : Text(
                          "Next",
                          style: textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                        );
                })),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ReactiveDropdown(
                    selectedIndex: selectedIndex,
                    items: countryCodes.map((country) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  CustomElevatedButton(
                      onPressed: () async {
                        try {
                          final GenericService bookingService =
                              GenericService(Get.find<ApiClient>());

                          final bookingController =
                              GenericController<ex.BookingData>(
                            fetchData: () => bookingService.getData(
                              endpoint: '/v1/bookings/provider',
                              headers: {
                                'Authorization':
                                    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1lcmFsYXVkYUBzYWJzZWJhZGEuY29tIiwiZXhwIjoxNzM4NDI4ODAyLCJwaG9uZSI6Iis5MTk2NjIxMDU3MTAiLCJyb2xlIjoicHJvdmlkZXIiLCJ1aWQiOiI1MzB5MWw3NzhyIn0.l7Eb4M3BsBV97Dj6WVE8DmB_0r-0ypjpdzHSz9heoD8',
                              },
                            ),
                            model: (json) => ex.BookingData.fromJson(json),
                          );

                          await bookingController.fetchItems();

                          if (bookingController.listData.isNotEmpty) {
                            bookingController.listData.forEach((booking) {
                              logger.i(booking.toJson());
                            });
                          } else if (bookingController.data.value != null) {
                            logger.i(
                                'Fetched Single Booking: ${bookingController.data.value}');
                          } else {
                            logger.w('No data found.');
                          }
                        } catch (e) {
                          logger.e('Error while fetching bookings: $e');
                        }
                      },
                      fixedSize: const Size(300, 60),
                      child: Obx(() {
                        return (isLoading.value)
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator())
                            : Text(
                                "Next",
                                style: textTheme.bodyLarge!.copyWith(
                                  color: Colors.white,
                                ),
                              );
                      })),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
