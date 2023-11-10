// ignore_for_file: equal_keys_in_map

import 'package:carx/data/features/add_delivery_address/add_delivery_address_screen.dart';
import 'package:carx/data/features/car_by_brand/car_by_brand_screen.dart';
import 'package:carx/data/features/car_detail/ui/detail_screen.dart';
import 'package:carx/data/features/delivery_address/delivery_address_screen.dart';
import 'package:carx/data/features/add_delivery_address/edit_delivery_address_screen.dart';
import 'package:carx/data/features/edit_profile/ui/edit_profile_screen.dart';
import 'package:carx/data/features/order/order_screen.dart';
import 'package:carx/data/features/order_management/ui/car_rental_booking.dart';
import 'package:carx/data/features/order_management_detail/ui/car_rental_booking_detail.dart';
import 'package:carx/data/features/order_success/order_success_view.dart';
import 'package:carx/data/features/payment/ui/payment_screen.dart';
import 'package:carx/data/features/search/ui/search_view.dart';
import 'package:carx/view/favorite_screen.dart';

import 'package:carx/view/main_view.dart';
import 'package:path/path.dart';

class Routes {
  static final pages = {
    routeCarDetail: (context) => const CarDetailView(),
    routeMain: (context) => const MainView(),
    routeEditProfile: (context) => const EditProfileScreen(),
    routeOrder: (context) => const OrderView(),
    routeOrderSuccess: (context) => const OrderSucess(),
    routePayment: (context) => const PaymentSreen(),
    routeSearch: (context) => const SearchView(),
    routeOrderDetail: (context) => const CarRentalBookingDetail(),
    routeAllOrder: (context) => const CarRentalBooking(),
    routeCarByBrand: (context) => const CarByBrandScreen(),
    routeDeliveryAddresses: (context) => const DeliveryAddressScreen(),
    routeAddDeliveryAddresses: (context) => const AddDeliveryAddressScreen(),
    routeEditDeliveryAddresses: (context) => const EditDeliveryAddressScreen(),
    routeFavorite: (context) => const FavoriteScreen(),
  };

  static const routeCarDetail = '/car_detail';
  static const routeMain = '/main';
  static const routeEditProfile = '/edit_profile';
  static const routeOrder = '/order';
  static const routeOrderSuccess = '/order_success';
  static const routePayment = '/payment';
  static const routeSearch = '/search';
  static const routeAllOrder = '/all_order';
  static const routeOrderDetail = '/order_detail';
  static const routeCarByBrand = '/car_by_brand';
  static const routeDeliveryAddresses = '/delivery_addresses';
  static const routeAddDeliveryAddresses = '/add_delivery_addresses';
  static const routeEditDeliveryAddresses = '/edit_delivery_addresses';
  static const routeFavorite = '/favorite';
}
