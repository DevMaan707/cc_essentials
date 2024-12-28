import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 5,
    lineLength: 200,
    colors: true,
    printEmojis: true,
    printTime: false,
  ),
);
