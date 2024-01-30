import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_run_app/k_bank/screen/mobile_transfer_page.dart';
import 'package:test_run_app/k_bank/screen/prompt_pay_page.dart';
import 'package:test_run_app/k_bank/provider/provider_bank.dart';
import 'package:test_run_app/k_bank/screen/select_bank_page.dart';
import 'package:test_run_app/k_bank/screen/transfer_abroad_page.dart';
import 'package:test_run_app/k_bank/screen/transfer_page.dart';

class CategoryTransferPage extends StatefulWidget {
  const CategoryTransferPage({
    super.key,
  });

  @override
  State<CategoryTransferPage> createState() => _CategoryTransferPageState();
}

class _CategoryTransferPageState extends State<CategoryTransferPage> {
  late ProviderBank providerBank;
  String local = 'en_US';

  @override
  void initState() {
    providerBank = Provider.of<ProviderBank>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerBank.getCategory();
      providerBank.getBank();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    local = context.locale.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff004444),
        centerTitle: true,
        title: Text(
          'transfer_money'.tr().replaceAll('\n', ' '),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        iconTheme: IconThemeData(size: 20, color: Colors.white),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ProviderBank>(
          builder: (_, p, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'new_item'.tr(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: p.modelMenuTransfer.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: 2,
                            childAspectRatio: 2 / 1),
                    itemBuilder: (BuildContext context, int index) {
                      var selectPro = p.modelMenuTransfer[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ChangeNotifierProvider<
                                          ProviderBank>.value(
                                        value: p,
                                        child: _getRouteScreen(selectPro.id),
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade200,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  backgroundColor: Color(0xff66b2b2),
                                  child: Icon(
                                    Icons.account_balance_outlined,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      local == 'en_US'
                                          ? selectPro.menuEn
                                          : selectPro.menuTh,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _getRouteScreen(int id) {
    if (id == 2) {
      return ChangeNotifierProvider<ProviderBank>.value(
        builder: (context, child) {
          return SelectBankPage();
        },
        value: providerBank,
      );
    } else if (id == 4) {
      return PromptPayPage();
    } else if (id == 5) {
      return TransferAbroad();
    } else if (id == 1) {
      providerBank.modelBank.firstWhere((element) => element.id == id).select =
          true;
      return TransferPage();
    } else if (id == 3) {
      return MobileTransferPage();
    }else {
      return SelectBankPage();
    }
  }
}
