import 'package:flutter/material.dart';
import 'package:migros_small_app_debug/provider/product_provider.dart';
import 'package:migros_small_app_debug/views/product_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'navigation/app_router.dart';

void main() async {
  debugPrint('main function called');
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  debugPrint('Supabase initializedsupabaseUrl : $supabaseUrl supabaseKey : $supabaseKey');

  debugPrint('runApp function call : Root()');
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Migros App',
        theme: ThemeData(primarySwatch: Colors.orange
        ),
      ),
    );
  }
}
