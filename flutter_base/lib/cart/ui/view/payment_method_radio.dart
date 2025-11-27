import 'package:flutter/material.dart';
import 'package:flutter_base/app/app.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

enum PaymentMethod { creditCard, paypal, applePay }

class PaymentMethodRadio extends StatefulWidget {
  const PaymentMethodRadio({super.key});

  @override
  State<PaymentMethodRadio> createState() => _PaymentMethodRadioState();
}

class _PaymentMethodRadioState extends State<PaymentMethodRadio> {
  PaymentMethod? _method = PaymentMethod.creditCard;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.wallet,
                    color: RFXColors.lightPrimary,
                    size: RFXSpacing.spacing20,
                  ),
                  const SizedBox(width: RFXSpacing.spacing8),
                  Text('Credit/Debit Card', style: textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        ),
        RadioMenuButton(
          value: PaymentMethod.paypal,
          groupValue: _method,
          onChanged: (PaymentMethod? value) {
            setState(() {
              _method = value;
            });
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(RFXSpacing.spacing12),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Iconsax.paypal,
                    color: RFXColors.lightPrimary,
                    size: RFXSpacing.spacing20,
                  ),
                  const SizedBox(width: RFXSpacing.spacing8),
                  Text('Paypal', style: textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
