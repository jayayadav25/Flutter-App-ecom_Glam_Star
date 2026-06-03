import 'package:firebase_mastery_app/src/app/ui/SplashScreen.dart';
import 'package:firebase_mastery_app/src/app/ui/main_layout.dart';
import 'package:firebase_mastery_app/src/app/utils/go_router_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/models/address_model.dart';
import '../core/models/order_model.dart';
import '../core/models/user_model.dart';
import '../features/address/presentation/address_detail_screen.dart';
import '../features/address/presentation/address_list_screen.dart';
import '../features/address/presentation/edit_address_screen.dart';
import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/signup_screen.dart';
import '../features/cart/presentation/cart_screen.dart';
import '../features/cart/presentation/coupon_screen.dart';
import '../features/checkout/presentation/checkout_screen.dart';
import '../features/checkout/presentation/order_failed_screen.dart';
import '../features/checkout/presentation/order_success_screen.dart';
import '../features/checkout/presentation/payment_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/orders/presentation/order_detail_screen.dart';
import '../features/orders/presentation/tracking_screen.dart';
import '../features/products/presentation/product_detail_screen.dart';
import '../features/profile/presentation/edit_profile_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/wishlist/presentation/wishlist_screen.dart';
import '../features/auth/providers/auth_providers.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),


    redirect: (context, state) async {
      final location = state.uri.toString();

      // Splash allowed always
      if (location == '/') return null;

      // Prevent redirects during sign-in
      if (ref.read(authInProgressProvider)) return null;

      final prefs = await SharedPreferences.getInstance();
      final onboardingDone = prefs.getBool('onboarding') ?? false;

      final user = FirebaseAuth.instance.currentUser;

      final isAuthRoute = location == '/login' ||
          location == '/signup' ||
          location == '/forgot-password';

      // If onboarding NOT DONE - always allow onboarding page
      if (!onboardingDone) {
        if (location == '/onboarding') return null;
        return '/onboarding';
      }

      // After onboarding - user not logged in → send to login
      if (user == null && !isAuthRoute) {
        return '/login';
      }

      // If logged in - block login/signup
      if (user != null && isAuthRoute) {
        return '/home';
      }

      return null;
    },

    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute( name: 'onboarding',path: '/onboarding', builder: (_, __) => const OnboardingScreen()
      ),

      GoRoute(
        name: 'login',
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),

      GoRoute(
        name: 'signup',
        path: '/signup',
        builder: (_, __) => const SignupScreen(),
      ),

      GoRoute(
        path: '/forgot-password',
        builder: (_, __) => const ForgotPasswordScreen(),
      ),

      GoRoute(path: '/home', builder: (_, __) => const MainLayout()),

      GoRoute(path: '/profile', builder: (_, __) => const ProfileScreen()),

      GoRoute(
        path: '/edit-profile',
        builder: (_, state) {
          final user = state.extra as UserModel;
          return EditProfileScreen(user: user);
        },
      ),



      GoRoute(path: '/wishlist', builder: (_, __) => const WishlistScreen()),
      GoRoute(path: '/cart', builder: (_, __) => const CartScreen()),
      GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
      GoRoute(
        path: '/product/:id',
        name: 'product-detail',
        builder: (context, state) {
          final productId = int.parse(state.pathParameters['id']!);
          return ProductDetailScreen(productId: productId);
        },
      ),


      GoRoute(
        path: '/cart',
        name: 'cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/coupons',
        name: 'coupons',
        builder: (context, state) {
          return const CouponScreen();
        },
      ),

      GoRoute(
        path: '/addresses',
        name: 'addresses',
        builder: (context, state) {
          return const AddressListScreen();
        },
      ),

      GoRoute(
        path: '/addresses/add',
        name: 'add-address',
        builder: (context, state) {
          return const AddEditAddressScreen();
        },
      ),

      GoRoute(
        path: '/addresses/edit',
        name: 'edit-address',
        builder: (context, state) {

          final address =
          state.extra as AddressModel;

          return AddEditAddressScreen(
            address: address,
          );
        },
      ),

      GoRoute(
        path: '/addresses/details',
        name: 'address-details',
        builder: (context, state) {

          final address =
          state.extra as AddressModel;

          return AddressDetailsScreen(
            address: address,
          );
        },
      ),

      GoRoute(
        path: '/checkout',
        name: 'checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),

      GoRoute(
        path: '/payment',
        name: 'payment',
        builder: (context, state) => const PaymentScreen(),
      ),

      GoRoute(
        path: '/order-success',
        name: 'order_success',
        builder: (context, state) => const OrderSuccessScreen(),
      ),


      GoRoute(
        path: '/order-failed',
        name: 'order_failed',
        builder: (_, __) => const OrderFailedScreen(),
      ),

      GoRoute(
        path: '/order-details',
        name: 'order-details',
        builder: (context, state) {
          final order = state.extra as OrderModel;
          return OrderDetailsScreen(
            order: order,
          );
        },
      ),


      GoRoute(
        path: '/tracking',
        name: 'tracking',
        pageBuilder: (context, state) {
          final order = state.extra as OrderModel;
          return MaterialPage(
            child: TrackingScreen(
              order: order,
            ),
          );
        },
      ),


    ],
  );
});
