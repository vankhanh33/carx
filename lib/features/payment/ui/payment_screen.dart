// ignore_for_file: avoid_print

import 'package:carx/data/model/order.dart';
import 'package:carx/features/payment/bloc/payment_bloc.dart';
import 'package:carx/features/payment/bloc/payment_event.dart';
import 'package:carx/features/payment/bloc/payment_state.dart';

import 'package:carx/loading/loading_screen.dart';
import 'package:carx/features/order_success/slide.dart';
import 'package:carx/service/api/reponsitory/reponsitory.dart';
import 'package:carx/features/order_success/order_success_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentSreen extends StatefulWidget {
  const PaymentSreen({super.key});

  @override
  State<PaymentSreen> createState() => _PaymentSreenState();
}

class _PaymentSreenState extends State<PaymentSreen> {
  @override
  Widget build(BuildContext context) {
    final mapOrder =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    Order order = mapOrder['order'];

    return BlocProvider(
      create: (context) => PaymentBloc(Reponsitory.response())
        ..add(OrderCarUpdate(order: order)),
      child: BlocConsumer<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state.isOnClick) {
            if (state.status == PaymentStatus.loading) {
              LoadingScreen().show(context: context, text: '');
            } else if (state.status == PaymentStatus.failure) {
              LoadingScreen().hide();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorText)));
            } else if (state.status == PaymentStatus.success) {
              LoadingScreen().hide();
              Navigator.of(context).push(SlideBottomRoute(
                page: const OrderSucess(),
                arguments: mapOrder,
              ));
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Payments'),
            ),
            bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color(0x1A000000),
                    offset: Offset(0, -2),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${order.totalAmount}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '14% off',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<PaymentBloc>().add(PaymentButtonSelectEvent(
                          paymentMethod: state.selectedPaymentMethod));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.amber[100],
                      fixedSize: const Size(130, 48),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      side: const BorderSide(width: 1, color: Colors.amber),
                    ),
                    child: const Text(
                      'Continues',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('SAVED CARDS'),
                  ),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 64,
                    ),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: imgBank(context, list.elementAt(index),
                            state.selectedPaymentMethod),
                        minVerticalPadding: 0,
                        title: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Vietcom Bank',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'XXXX XXXX XXXX 7891 ',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          context.read<PaymentBloc>().add(
                              SelectionPaymentMethodEvent(
                                  itemSelected: list.elementAt(index)));
                        },
                        trailing: Radio(
                          value: list.elementAt(index),
                          groupValue: state.selectedPaymentMethod,
                          onChanged: (value) {
                            context.read<PaymentBloc>().add(
                                SelectionPaymentMethodEvent(
                                    itemSelected: list.elementAt(index)));
                          },
                        ),
                      );
                    },
                    shrinkWrap: true,
                    itemCount: 2,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('WALLETS'),
                  ),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 12,
                        mainAxisExtent: 48,
                      ),
                      itemBuilder: (context, index) {
                        return imgBank(
                            context, '$index', state.selectedPaymentMethod);
                      },
                      itemCount: 5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 64,
                    child: ListTile(
                      onTap: () {
                        context.read<PaymentBloc>().add(
                            SelectionPaymentMethodEvent(
                                itemSelected: list.elementAt(2)));
                      },
                      minVerticalPadding: 0,
                      leading: imgBank(context, list.elementAt(2),
                          state.selectedPaymentMethod),
                      title: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cash on delivery',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Nominal fee of 5 cents will be changed',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      trailing: Radio(
                        value: list.elementAt(2),
                        groupValue: state.selectedPaymentMethod,
                        onChanged: (value) {
                          context.read<PaymentBloc>().add(
                              SelectionPaymentMethodEvent(
                                  itemSelected: list.elementAt(2)));
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xffe0e3e7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.wallet_giftcard_rounded),
                      title: const Text(
                        'Apply promo code',
                        style: TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PRICE DETAILS',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 24.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Price',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '\$ ${order.totalAmount}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Delivery Charges',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${order.deliveryCharges}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount',
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 32,
                          thickness: 2,
                          color: Color(0xffe0e3e7),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '\$${order.totalAmount}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget imgBank(BuildContext context, String item, String currentItem) {
    return InkWell(
      onTap: () {
        context
            .read<PaymentBloc>()
            .add(SelectionPaymentMethodEvent(itemSelected: item));
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xffe0e3e7),
          borderRadius: BorderRadius.circular(12),
          border: currentItem == item
              ? Border.all(width: 1, color: Colors.blue)
              : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPaMGgm2xrNztBlJvHiv4g_AlXnOLDivek2g&usqp=CAU',
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

const List<String> list = [
  'Sacombank',
  'Vietcombank',
  'Mbbank',
  'DongABank',
  'Sacombank'
];
