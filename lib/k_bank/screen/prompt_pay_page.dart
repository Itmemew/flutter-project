import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_run_app/k_bank/provider/provider_bank.dart';
import 'package:test_run_app/k_bank/screen/confirm_transfer_page.dart';
import 'package:test_run_app/k_bank/screen/contact_page.dart';

class PromptPayPage extends StatefulWidget {
  const PromptPayPage({super.key});

  @override
  State<PromptPayPage> createState() => _PromptPayPageState();
}

class _PromptPayPageState extends State<PromptPayPage> {
  late ProviderBank prompt;

  @override
  void initState() {
    prompt = Provider.of<ProviderBank>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    prompt.account.clear();
    prompt.money.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff004444)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      'transfer_money'.tr(),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'from:'.tr(),
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: Icon(
                        Icons.person_3_outlined,
                        color: Colors.white,
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
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'xxxx-xxx-0888',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'prompt_pay'.tr(),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: prompt.account,
                  onChanged: (value) => prompt.onChange(),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'code_prompt_pay'.tr(),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: GestureDetector(
                          onTap: () async {
                            var contact = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ContactPage()));
                            if (contact != null) {
                              prompt.account.text = contact;
                            }
                          },
                          child: Icon(
                            Icons.contact_page_outlined,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: prompt.money,
                  onChanged: (value) => prompt.onChange(),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'amount'.tr(),
                      suffixText: 'baht'.tr(),
                      suffixStyle: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  height: 10,
                ),
                Consumer<ProviderBank>(builder: (context, value, child) {
                  return GestureDetector(
                    onTap: (prompt.account.text.isEmpty &&
                            prompt.money.text.isEmpty)
                        ? null
                        : () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ChangeNotifierProvider<ProviderBank>(
                                          create: (BuildContext context) =>
                                              ProviderBank(context: context),
                                          child: ConfirmTransferPage(
                                              accountName:
                                                  prompt.account.text,
                                              amount: prompt.money.text),
                                        )));
                          },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: (prompt.account.text.isEmpty &&
                                prompt.money.text.isEmpty)
                            ? Colors.grey
                            : Colors.greenAccent,
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
