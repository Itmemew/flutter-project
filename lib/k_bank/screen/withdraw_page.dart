import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_run_app/k_bank/model/model_withdraw.dart';
import 'package:test_run_app/k_bank/provider/provider_bank.dart';
import 'package:collection/collection.dart';
import 'package:test_run_app/k_bank/screen/confirm_withdraw_page.dart';

class WithdrawPage extends StatefulWidget {
  final bool isEditAmount;

  const WithdrawPage({super.key, this.isEditAmount = false});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  late ProviderBank draw;
  int? amount;

  @override
  void initState() {
    draw = Provider.of<ProviderBank>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      draw.getAmount();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: draw.keyForm,
        child: Consumer<ProviderBank>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff004444),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
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
                            ),
                          ),
                          Text(
                            'withdraw_money'.tr().replaceAll('\n', ' '),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'account_number'.tr(),
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.grey, width: 2),
                                ),
                                child: Icon(
                                  Icons.person_3_outlined,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'My Account',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff66a3a3)
                                    ),
                                  ),
                                  Text(
                                    'xxx-xxx-0888',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'select_amount'.tr(),
                          style: TextStyle(fontSize: 20),
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: value.modelWithdraw.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 3 / 1),
                            itemBuilder: (BuildContext context, int index) {
                              var selectAmount = value.modelWithdraw[index];
                              return GestureDetector(
                                onTap: () {
                                  ModelWithdraw? where = value.modelWithdraw
                                      .firstWhereOrNull((element) =>
                                          element.selectWithdraw == true);

                                  if (where == null) {
                                    selectAmount.selectWithdraw =
                                        !selectAmount.selectWithdraw;
                                    amount = selectAmount.amount;
                                  } else {
                                    var isChange = where;
                                    isChange.selectWithdraw = false;
                                    amount = null;
                                    if (isChange != selectAmount) {
                                      selectAmount.selectWithdraw =
                                          !selectAmount.selectWithdraw;
                                      amount = selectAmount.amount;
                                    }
                                  }
                                  value.modelWithdraw = value.modelWithdraw;
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: selectAmount.selectWithdraw == false
                                        ? Colors.grey.shade200
                                        : Colors.greenAccent,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(selectAmount.amount == 0
                                          ? 'select_amount'.tr()
                                          : '${selectAmount.amount} baht'.tr()),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (amount == 0)
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: draw.money,
                            onChanged: (value) {
                              amount = int.parse(value);
                            },
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'amount'.tr(),
                                suffixText: 'baht'.tr(),
                                suffixStyle: TextStyle(color: Colors.black)),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: (amount == null)
                                ? null
                                : () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChangeNotifierProvider<
                                                    ProviderBank>.value(
                                                  value: value,
                                                  child: ConfirmWithdrawPage(
                                                      amount: amount!),
                                                )));
                                  },
                            child: CircleAvatar(
                              backgroundColor: amount == null
                                  ? Colors.grey
                                  : Colors.greenAccent,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
