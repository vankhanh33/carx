import 'package:carx/data/presentation/add_delivery_address/bloc/delivery_address_handler_state.dart';
import 'package:carx/data/model/delivery_address.dart';
import 'package:carx/data/reponsitories/auth/auth_reponsitory.dart';
import 'package:carx/service/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delivery_address_handler_event.dart';

class DeliveryAddressHandlerBloc
    extends Bloc<DeliveryAddressHandlerEvent, DeliveryAddressHandlerState> {
  AuthReponsitory authReponsitory;
  DeliveryAddressHandlerBloc(this.authReponsitory)
      : super(const DeliveryAddressHandlerState.initial()) {
    on<UpdateIdDeliveryAddressEvent>(
      (event, emit) => emit(state.copyWith(id: event.id)),
    );
    on<RecipientNameChangeEvent>(
      (event, emit) => emit(state.copyWith(recipientName: event.fullName)),
    );

    on<PhoneNumberChangeEvent>(
      (event, emit) => emit(state.copyWith(phoneNumber: event.phoneNumber)),
    );

    on<AddressChangeEvent>(
      (event, emit) => emit(state.copyWith(address: event.address)),
    );
    on<TypeAddressChangeEvent>(
      (event, emit) => emit(state.copyWith(typeAddress: event.type)),
    );

    on<DefaultAddressChangeEvent>(
      (event, emit) => emit(state.copyWith(isDefault: event.isDefault)),
    );
    on<AddAddressToServerEvent>(
      (event, emit) => _onAddOrUpdateDeliveryAddressToServerEvent(event, emit),
    );
    on<EditDeliveryAddressToServerEvent>(
      (event, emit) => _onAddOrUpdateDeliveryAddressToServerEvent(event, emit),
    );
    on<DeleteDeliveryAddressToServerEvent>(
      (event, emit) => _onDeleteAddress(event, emit),
    );
  }

  void _onAddOrUpdateDeliveryAddressToServerEvent(
      DeliveryAddressHandlerEvent event, Emitter emit) async {
    emit(state.copyWith(status: DeliveryAddressHandlerStatus.loading));
    String uId = AuthService.firebase().currentUser!.id;
    String? id = state.id;
    String recipientName = state.recipientName;
    String phoneNumber = state.phoneNumber;
    String address = state.address;
    String typeAddress = state.typeAddress;
    int defaultAddress = state.isDefault ? 1 : 0;
    if (recipientName.isEmpty) {
      emit(state.copyWith(
        textError: 'Please enter your full name!',
        status: DeliveryAddressHandlerStatus.failure,
      ));
    } else if (phoneNumber.isEmpty) {
      emit(state.copyWith(
        textError: 'Please enter your phone number!',
        status: DeliveryAddressHandlerStatus.failure,
      ));
    } else if (!isPhoneNumber(phoneNumber) || phoneNumber.length > 11) {
      emit(state.copyWith(
        textError: 'Invalid phone number format!',
        status: DeliveryAddressHandlerStatus.failure,
      ));
    } else if (address.isEmpty) {
      emit(state.copyWith(
        textError: 'Please enter your address!',
        status: DeliveryAddressHandlerStatus.failure,
      ));
    } else if (typeAddress.isEmpty) {
      emit(state.copyWith(
        textError: 'Please enter your type of address!',
        status: DeliveryAddressHandlerStatus.failure,
      ));
    } else {
      DeliveryAddress deliveryAddress = DeliveryAddress(
        id: id ?? '',
        recipientName: recipientName,
        address: address,
        phone: phoneNumber,
        isSelected: defaultAddress,
        type: typeAddress,
        userId: uId,
      );
      try {
        print(deliveryAddress.toString());
        await authReponsitory.addDeliveryAddress(uId, deliveryAddress);

        emit(state.copyWith(status: DeliveryAddressHandlerStatus.success));
      } catch (e) {
        emit(state.copyWith(
          textError: 'Error Server',
          status: DeliveryAddressHandlerStatus.failure,
        ));
      }
    }
    emit(state.copyWith(status: DeliveryAddressHandlerStatus.initial));
  }

  void _onDeleteAddress(
      DeleteDeliveryAddressToServerEvent event, Emitter emit) async {
    emit(state.copyWith(status: DeliveryAddressHandlerStatus.loading));
    try {
      await authReponsitory.deleteDeliveryAddress(state.id!);
      emit(state.copyWith(status: DeliveryAddressHandlerStatus.success));
    } catch (e) {
      emit(state.copyWith(status: DeliveryAddressHandlerStatus.failure));
    }
  }

  bool isPhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^[0-9]+$');

    return regex.hasMatch(phoneNumber);
  }
}
