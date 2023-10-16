import 'package:carx/view/order/confirm_payment_view.dart';
import 'package:flutter/material.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  var gender = payments[0]['payment'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Methods'),
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Select the payment method you want to use'),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    setState(() {
                      gender = payments[index]['payment'];
                    });
                  },
                  leading: Icon(Icons.payment),
                  title: Text(payments[index]['name']),
                  trailing: Radio(
                    value: payments[index]['payment'],
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = payments[index]['payment'];
                      });
                    },
                  ),
                ),
              );
            },
            shrinkWrap: true,
            itemCount: payments.length,
          ),
        ],
      )),
    );
  }
}

enum Gender { paypal, Receive_goods_and_pay, momo }

const List<Map<String, dynamic>> payments = [
  {'name': 'Receive Goods And Pay', 'payment': 'receive'},
  {'name': 'PayPal', 'payment': 'paypal'},
  {'name': 'MoMo', 'payment': 'momo'}
];
void main(){
  runApp(MaterialApp(home: ConfirmPaymentView(),));
}
