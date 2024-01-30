import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_run_app/k_bank/model/model_bank.dart';
import 'package:test_run_app/k_bank/provider/provider_bank.dart';
import 'package:test_run_app/k_bank/screen/confirm_transfer_page.dart';
import 'package:test_run_app/k_bank/screen/select_bank_page.dart';

class TransferPage extends StatefulWidget {
  final bool isEditChangeBank;
  final bool isClean;

  const TransferPage(
      {super.key, this.isClean = false, this.isEditChangeBank = false});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  late ProviderBank providerBank;
  String local = 'en_US';
  ModelBank? selectedBank;

  @override
  void initState() {
    providerBank = Provider.of<ProviderBank>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      selectedBank = providerBank.modelBank
          .firstWhere((element) => element.select == true);
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    providerBank.account.clear();
    providerBank.money.clear();
    super.dispose();
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
        leading: widget.isClean == true
            ? null
            : GestureDetector(
                onTap: () {
                  var p = context.read<ProviderBank>();
                  p.modelBank.map((e) => e.select = false).toList();
                  p.modelBank = p.modelBank;
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(
        child: Form(
          key: providerBank.keyForm,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<ProviderBank>(builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'other_bank_accounts'.tr(),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (widget.isEditChangeBank)
                        ? () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChangeNotifierProvider.value(
                                            value: providerBank,
                                            builder: (context, child) {
                                              return SelectBankPage(
                                                  isEdit: true,
                                                  id: selectedBank?.id);
                                            })));
                          }
                        : null,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: selectedBank?.color == null
                            ? Colors.white
                            : Color(int.parse('0xff${selectedBank?.color}')),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: Color(0xff66b2b2),
                            child: Icon(
                              Icons.monetization_on_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            local == 'en_US'
                                ? selectedBank?.nameEn ?? ''
                                : selectedBank?.nameTh ?? '',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Spacer(),
                          if (widget.isEditChangeBank)
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: providerBank.account,
                    onChanged: (value) => providerBank.onChange(),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'account_number'.tr(),
                        suffixText: 'enter_account_number'.tr(),
                        suffixStyle: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: providerBank.money,
                    onChanged: (value) => providerBank.onChange(),
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'amount'.tr(),
                        suffixText: 'baht'.tr(),
                        suffixStyle: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: (value.account.text.isEmpty &&
                            value.money.text.isEmpty)
                        ? null
                        : () {
                      if(value.account.text == '123456789'){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChangeNotifierProvider<ProviderBank>(
                                      create: (BuildContext context) =>
                                          ProviderBank(context: context),
                                      child: ConfirmTransferPage(
                                          accountName: value.account.text,
                                          amount: value.money.text),
                                    )));
                      } else {
                        final snackBar = SnackBar(
                          content: Text('invalid_account_number'.tr()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                          },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CircleAvatar(
                        backgroundColor: (value.account.text.isEmpty &&
                                value.money.text.isEmpty)
                            ? Colors.grey
                            : Colors.greenAccent,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
