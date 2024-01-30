import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_run_app/k_bank/provider/provider_bank.dart';
import 'package:test_run_app/k_bank/screen/transfer_page.dart';
import 'package:collection/collection.dart';

class SelectBankPage extends StatefulWidget {
  final bool isEdit;
  final int? id;

  const SelectBankPage({
    super.key,
    this.isEdit = false,
    this.id,
  });

  @override
  State<SelectBankPage> createState() => _SelectBankPageState();
}

class _SelectBankPageState extends State<SelectBankPage> {
  String local = 'en_US';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var r = context.read<ProviderBank>();
      if (widget.id != null) {
        r.modelBank.firstWhere((element) => element.id == widget.id).select =
            true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    local = context.locale.toString();
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff004444)),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.isEdit == false)
                      GestureDetector(
                        onTap: () {
                          var u = context.read<ProviderBank>();
                          u.modelBank.map((e) => e.select = false).toList();
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    Spacer(),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          'choose_a_bank'.tr(),
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Spacer(),
                    if (widget.isEdit == true)
                      CloseButton(
                        color: Colors.white,
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<ProviderBank>(
              builder: (_, p, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (item) {
                          p.search = item;
                        },
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.withOpacity(0.1),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                color: Colors.grey.withOpacity(0.1),
                              ),
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ...p.modelBank
                          .map(
                            (e) => GestureDetector(
                              onTap: () {
                                var res = p.modelBank.firstWhereOrNull(
                                    (element) => element.select == true);
                                if (res != null) {
                                  res.select = false;
                                }
                                e.select = !e.select;
                                p.modelBank = p.modelBank;
                                if (widget.isEdit) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChangeNotifierProvider<
                                                  ProviderBank>.value(
                                                value: p,
                                                child: TransferPage(
                                                  isEditChangeBank: true,
                                                ),
                                              )));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ChangeNotifierProvider<
                                                  ProviderBank>.value(
                                                value: p,
                                                child: TransferPage(
                                                  isEditChangeBank: true,
                                                ),
                                              )));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: (e.select)
                                      ? Color(int.parse('0xff${e.color}'))
                                      : Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.5,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: Color(
                                              int.parse('0xff${e.color}'))),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            maxRadius: 25,
                                            backgroundColor: Color(0xff66b2b2),
                                            child: Icon(
                                              Icons.account_balance_outlined,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            local == 'en_US'
                                                ? e.nameEn
                                                : e.nameTh,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: e.select
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
