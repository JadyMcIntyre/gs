// lib/injection.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../injection.config.dart';   // ← generated

final sl = GetIt.instance;

@InjectableInit()          // <-- tells injectable to generate the code here
Future<void> configureDependencies() async => sl.init();
