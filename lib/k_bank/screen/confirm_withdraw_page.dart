import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_run_app/k_bank/model/model_withdraw.dart';

class ConfirmWithdrawPage extends StatefulWidget {
  final int amount;

  const ConfirmWithdrawPage({super.key, required this.amount});

  @override
  State<ConfirmWithdrawPage> createState() => _ConfirmWithdrawPageState();
}

class _ConfirmWithdrawPageState extends State<ConfirmWithdrawPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004444),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )),
                  Text(
                    'withdraw_money'.tr().replaceAll('\n', ' '),
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox()
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'withdrawal_form_list'.tr(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('from_account'.tr()),
                            SizedBox(
                              height: 30,
                            ),
                            Text('chanel'.tr()),
                            Text('list_number'.tr()),
                            Text('withdraw_money_within'.tr()),
                            SizedBox(
                              height: 20,
                            ),
                            Text('amount'.tr()),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'My Account',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'xxx-xxx-0888',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'ATM',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '022288879',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '15:47',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.amount}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'baht'.tr(),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
