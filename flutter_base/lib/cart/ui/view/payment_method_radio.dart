import 'package:flutter/material.dart';

enum PaymentMethod { creditCard, paypal, applePay }

class PaymentMethodRadio extends StatefulWidget {
  const PaymentMethodRadio({super.key});

  @override
  State<PaymentMethodRadio> createState() => _PaymentMethodRadioState();
}

class _PaymentMethodRadioState extends State<PaymentMethodRadio> {
  PaymentMethod? _method;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioMenuButton(
          value: PaymentMethod.creditCard,
          groupValue: _method,
          onChanged: (PaymentMethod? value) {
            setState(() {
              _method = value;
            });
          },
          child: const Text('Credit/Debit Card'),
        ),
        RadioMenuButton(
          value: PaymentMethod.paypal,
          groupValue: _method,
          onChanged: (PaymentMethod? value) {
            setState(() {
              _method = value;
            });
          },
          child: const Text('PayPal'),
        ),
      ],
    );
  }
}
