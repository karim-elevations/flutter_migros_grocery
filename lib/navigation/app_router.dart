// lib/navigation/app_router.dart
//import 'package:flutter/material.dart';
import 'package:migros_small_app_debug/views/image_upload_screen.dart';

import '../views/product_screen.dart';
import '../views/login_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
    GoRoute(path: '/products', builder: (context, state) => ProductScreen()),
    GoRoute(path: '/image', builder: (context, state) => ImageUploadScreen()),
  ],
);
