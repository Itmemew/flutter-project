import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_run_app/k_bank/provider/provider_bank.dart';
import 'package:test_run_app/k_bank/screen/category_transfer_page.dart';
import 'package:test_run_app/k_bank/screen/withdraw_page.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePageKBank extends StatefulWidget {
  const HomePageKBank({super.key});

  @override
  State<HomePageKBank> createState() => _HomePageKBankState();
}

class _HomePageKBankState extends State<HomePageKBank> {
  String local = 'en_US';

  @override
  Widget build(BuildContext context) {
    local = context.locale.toString();
    return Scaffold(
      backgroundColor: Color(0xff004444),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Color(0xff58f0bd)),
                    ),
                    child: Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 8,
                    decoration: BoxDecoration(color: Color(0xff58f0bd)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'urgent_transaction'.tr(),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildItemMenu(
                        text: 'transfer_money'.tr(),
                        icon: Icons.currency_exchange,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider<ProviderBank>(
                                        create: (BuildContext context) =>
                                            ProviderBank(context: context),
                                        child: CategoryTransferPage(),
                                      )));
                        }),
                    _buildItemMenu(
                        text: 'top_up'.tr(),
                        icon: Icons.arrow_downward,
                        onTap: () {}),
                    _buildItemMenu(
                        text: 'pay_the_bill'.tr(),
                        icon: Icons.document_scanner_outlined,
                        onTap: () {}),
                    _buildItemMenu(
                        text: 'withdraw_money'.tr(),
                        icon: Icons.attach_money_outlined,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChangeNotifierProvider<ProviderBank>(
                                        create: (BuildContext context) =>
                                            ProviderBank(context: context),
                                        child: WithdrawPage(),
                                      )));
                        }),
                  ],
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.setLocale(Locale('en', 'US'));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: (local == 'en_US')
                              ? Colors.greenAccent
                              : Colors.grey),
                      child: Text(
                        'EN',
                        style: TextStyle(
                            color: (local == 'en_US')
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      context.setLocale(Locale('en', 'TH'));
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: (local == 'en_TH')
                              ? Colors.greenAccent
                              : Colors.grey),
                      child: Text(
                        'TH',
                        style: TextStyle(
                            color: (local == 'en_TH')
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemMenu(
      {required IconData icon, required String text, required Function onTap}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => onTap.call(),
            child: Container(
              margin: EdgeInsets.only(bottom: 6),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: Icon(
                icon,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
