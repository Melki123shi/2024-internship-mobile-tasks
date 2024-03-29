import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:melkishitesfaye/features/product/presentatoin/bloc/product_bloc.dart';
import 'package:melkishitesfaye/core/routing/routes.dart';
import 'package:melkishitesfaye/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        getProduct: getIt(),
        getProducts: getIt(),
        deleteProduct: getIt(),
        addProduct: getIt(),
        updateProduct: getIt(),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Shoes Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        routerConfig: RouteConfig.returnRouter(),
      ),
    );
  }
}
