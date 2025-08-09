import 'package:carraze/core/widgets/custom_snackbar.dart';
import 'package:carraze/core/widgets/custom_text.dart';
import 'package:carraze/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final List<Map<String, String>> _paymentMethods = [
    {'type': 'Visa', 'number': '****-1234', 'default': 'Yes'},
    {'type': 'MasterCard', 'number': '****-5678', 'default': 'No'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          txt: 'Payment Methods',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/car1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              CustomText(
                txt: 'Saved Payment Methods',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              const SizedBox(height: 15),
              ..._paymentMethods.map(
                (method) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            method['type'] == 'Visa'
                                ? Icons.credit_card
                                : Icons.credit_card,
                            color: const Color(0xFF2E4A62),
                            size: 30,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                txt: method['type']!,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              CustomText(
                                txt: method['number']!,
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (method['default'] == 'Yes')
                            CustomText(
                              txt: 'Default',
                              fontSize: 14,
                              color: Colors.greenAccent,
                            ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _paymentMethods.remove(method);
                              });
                              CustomSnackBar.show(
                                context,
                                message: 'Payment method removed',
                                type: SnackBarType.success,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                backgroundColor: const Color(0xFF2E4A62),
                content: CustomText(
                  txt: 'Add New Payment Method',
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onPressed: () {
                  CustomSnackBar.show(
                    context,
                    message: 'Redirecting to add payment method...',
                    type: SnackBarType.info,
                  );
                  // Add navigation to add payment method page if needed
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
