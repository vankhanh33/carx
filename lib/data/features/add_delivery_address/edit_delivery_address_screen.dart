// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:carx/data/features/add_delivery_address/bloc/delivery_address_handler_bloc.dart';
import 'package:carx/data/features/add_delivery_address/bloc/delivery_address_handler_event.dart';
import 'package:carx/data/features/add_delivery_address/bloc/delivery_address_handler_state.dart';
import 'package:carx/data/model/delivery_address.dart';
import 'package:carx/data/reponsitories/auth/auth_reponsitory_impl.dart';
import 'package:carx/loading/loading.dart';
import 'package:carx/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditDeliveryAddressScreen extends StatefulWidget {
  const EditDeliveryAddressScreen({super.key});

  @override
  State<EditDeliveryAddressScreen> createState() =>
      _EditDeliveryAddressScreenState();
}

class _EditDeliveryAddressScreenState extends State<EditDeliveryAddressScreen> {
  late DeliveryAddressHandlerBloc _addressBloc;
  @override
  void initState() {
    _addressBloc = DeliveryAddressHandlerBloc(AuthReponsitoryImpl.reponsitory());
    super.initState();
  }

  @override
  void dispose() {
    _addressBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryAddress =
        ModalRoute.of(context)!.settings.arguments as DeliveryAddress;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, false);
          return false;
        },
        child: BlocProvider(
          create: (context) => _addressBloc
            ..add(UpdateIdDeliveryAddressEvent(deliveryAddress.id))
            ..add(TypeAddressChangeEvent(deliveryAddress.type))
            ..add(DefaultAddressChangeEvent(deliveryAddress.isSelected == 1))
            ..add(PhoneNumberChangeEvent(deliveryAddress.phone))
            ..add(AddressChangeEvent(deliveryAddress.address))
            ..add(RecipientNameChangeEvent(deliveryAddress.recipientName)),
          child: BlocConsumer<DeliveryAddressHandlerBloc, DeliveryAddressHandlerState>(
            listener: (context, state) {
              if (state.status == DeliveryAddressHandlerStatus.loading) {
                Loading().show(context: context);
              } else if (state.status == DeliveryAddressHandlerStatus.success) {
                Loading().hide();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully'),
                  backgroundColor: AppColors.colorSuccess,
                ));
                Navigator.pop(context, true);
              } else if (state.status == DeliveryAddressHandlerStatus.failure) {
                Loading().hide();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.textError)));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Container(
                  color: AppColors.whiteSmoke,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: Text(
                          'Contact',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        color: Colors.white,
                        height: 54,
                        alignment: Alignment.center,
                        child: TextFormField(
                          initialValue: deliveryAddress.recipientName,
                          cursorColor: AppColors.primary,
                          decoration: const InputDecoration(
                            hintText: 'Enter full name',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: AppColors.primary),
                          onChanged: (value) {
                            context
                                .read<DeliveryAddressHandlerBloc>()
                                .add(RecipientNameChangeEvent(value));
                          },
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        margin: const EdgeInsets.only(top: 2),
                        color: Colors.white,
                        height: 54,
                        alignment: Alignment.center,
                        child: TextFormField(
                          initialValue: deliveryAddress.phone,
                          cursorColor: AppColors.primary,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            hintText: 'Enter phone number',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: AppColors.primary),
                          onChanged: (value) {
                            context
                                .read<DeliveryAddressHandlerBloc>()
                                .add(PhoneNumberChangeEvent(value));
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(12, 24, 12, 12),
                        child: Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        color: Colors.white,
                        height: 54,
                        alignment: Alignment.center,
                        child: TextFormField(
                          initialValue: deliveryAddress.address,
                          cursorColor: AppColors.primary,
                          decoration: const InputDecoration(
                            hintText: 'Enter address',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(color: AppColors.primary),
                          onChanged: (value) {
                            context
                                .read<DeliveryAddressHandlerBloc>()
                                .add(AddressChangeEvent(value));
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        color: Colors.white,
                        height: 54,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text(
                                'Type of address',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.fontColor,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<DeliveryAddressHandlerBloc>()
                                        .add(TypeAddressChangeEvent('Home'));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: state.typeAddress == 'Home'
                                            ? Border.all(
                                                width: 1,
                                                color: AppColors.secondary)
                                            : null,
                                        color: AppColors.lightGray),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    child: Text(
                                      'Home',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: state.typeAddress == 'Home'
                                            ? AppColors.secondary
                                            : AppColors.primary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<DeliveryAddressHandlerBloc>()
                                        .add(TypeAddressChangeEvent('Work'));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: state.typeAddress == 'Work'
                                            ? Border.all(
                                                width: 1,
                                                color: AppColors.secondary)
                                            : null,
                                        color: AppColors.lightGray),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 4),
                                    child: Text(
                                      'Work',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: state.typeAddress == 'Work'
                                            ? AppColors.secondary
                                            : AppColors.primary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                        color: Colors.white,
                        height: 54,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Set as default address',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.fontColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            Switch(
                              value: state.isDefault,
                              onChanged: (value) {
                                context
                                    .read<DeliveryAddressHandlerBloc>()
                                    .add(DefaultAddressChangeEvent(value));
                              },
                              activeColor: AppColors.secondary,
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 24, 12, 6),
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<DeliveryAddressHandlerBloc>()
                                    .add(EditDeliveryAddressToServerEvent());
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 16)),
                              child: const Text(
                                'Save Address',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                12, 6, 12, 6),
                            child: TextButton(
                              onPressed: () async {
                                bool isRemove =
                                    await showBottomSheetRemoveAddress();
                                if (isRemove)
                                  context
                                      .read<DeliveryAddressHandlerBloc>()
                                      .add(DeleteDeliveryAddressToServerEvent());
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 16)),
                              child: const Text(
                                'Remove Address',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> showBottomSheetRemoveAddress() {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      enableDrag: true,
      builder: (context) {
        return SizedBox(
          height: 180,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 24, 12, 24),
            child: Column(
              children: [
                const Text(
                  'Delete Address',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Do you want to remove this delivery address?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text('No'),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            shadowColor: Colors.transparent,
                          ),
                          child: const Text('Yes',style: TextStyle(color: Colors.redAccent),),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) => value ?? false);
  }
}
