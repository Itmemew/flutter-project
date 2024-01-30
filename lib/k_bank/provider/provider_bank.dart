import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_run_app/k_bank/api/api.dart';
import 'package:test_run_app/k_bank/model/model_api.dart';
import 'package:test_run_app/k_bank/model/model_bank.dart';
import 'package:test_run_app/k_bank/model/model_menu_transfer.dart';
import 'package:test_run_app/k_bank/model/model_withdraw.dart';

class ProviderBank extends ChangeNotifier {
  ProviderBank({required this.context});

  late BuildContext context;
  List<Map<String, dynamic>> dataBank = [
    {
      "id": 1,
      "name_en": "Kasikorn",
      "name_th": "กสิกรไทย",
      "color": "00b159",
      "img":
          "https://t3.ftcdn.net/jpg/04/49/22/98/240_F_449229860_uczw7ZS0sw6Ou31yhifld9s0KHkdULcR.jpg",
      "select": false,
    },
    {
      "id": 2,
      "name_en": "CIMB",
      "name_th": "ซีไอเอ็มบี",
      "color": "b51509",
      "img":
          "https://t3.ftcdn.net/jpg/04/49/22/98/240_F_449229860_uczw7ZS0sw6Ou31yhifld9s0KHkdULcR.jpg",
      "select": false,
    },
    {
      "id": 3,
      "name_en": "Aomsin",
      "name_th": "ออมสิน",
      "color": "ef1093",
      "img":
          "https://t3.ftcdn.net/jpg/04/49/22/98/240_F_449229860_uczw7ZS0sw6Ou31yhifld9s0KHkdULcR.jpg",
      "select": false,
    },
    {
      "id": 4,
      "name_en": "Krungsri",
      "name_th": "กรุงศรี",
      "color": "f7e90e",
      "img":
          "https://t3.ftcdn.net/jpg/04/49/22/98/240_F_449229860_uczw7ZS0sw6Ou31yhifld9s0KHkdULcR.jpg",
      "select": false,
    },
    {
      "id": 5,
      "name_en": "SCB",
      "name_th": "ไทยภาณิชย์",
      "color": "6c55a7",
      "img":
          "https://t3.ftcdn.net/jpg/04/49/22/98/240_F_449229860_uczw7ZS0sw6Ou31yhifld9s0KHkdULcR.jpg",
      "select": false,
    },
    {
      "id": 6,
      "name_en": "UOB",
      "name_th": "ยูโอบี",
      "color": "310997",
      "img":
          "https://t3.ftcdn.net/jpg/04/49/22/98/240_F_449229860_uczw7ZS0sw6Ou31yhifld9s0KHkdULcR.jpg",
      "select": false,
    },
  ];

  List<Map<String, dynamic>> menuTransfer = [
    {
      "id": 1,
      "menu_en": "Account Kasikorn",
      "menu_th": "บัญชีกสิกรไทย",
    },
    {
      "id": 2,
      "menu_en": "Account Other",
      "menu_th": "บัญชีกธนาคารอื่น",
    },
    {
      "id": 3,
      "menu_en": "Phone Number",
      "menu_th": "เบอร์มือถือ",
    },
    {
      "id": 4,
      "menu_en": "Prompt Pay",
      "menu_th": "พร้อมเพย์",
    },
    {
      "id": 5,
      "menu_en": "Transfer money abroad",
      "menu_th": "โอนเงินต่างประเทศ",
    },
    {
      "id": 6,
      "menu_en": "Group money transfer",
      "menu_th": "โอนเงินเป็นกลุ่ม",
    },
  ];

  List<Map<String, dynamic>> selectMoney = [
    {
      "id": 1,
      "amount": 100,
      "selectWithdraw": false,
    },
    {
      "id": 2,
      "amount": 200,
      "selectWithdraw": false,
    },
    {
      "id": 3,
      "amount": 300,
      "selectWithdraw": false,
    },
    {
      "id": 4,
      "amount": 400,
      "selectWithdraw": false,
    },
    {
      "id": 5,
      "amount": 500,
      "selectWithdraw": false,
    },
    {
      "id": 6,
      "amount": 600,
      "selectWithdraw": false,
    },
    {
      "id": 7,
      "amount": 1000,
      "selectWithdraw": false,
    },
    {
      "id": 8,
      "amount": 2000,
      "selectWithdraw": false,
    },
    {
      "id": 9,
      "amount": 3000,
      "selectWithdraw": false,
    },
    {
      "id": 10,
      "amount": 0,
      "selectWithdraw": false,
    },
  ];

  List<ModelWithdraw> _modelWithdraw = [];

  List<ModelMenuTransfer> _modelMenuTransfer = [];
  List<ModelBank> _modelBank = [];
  List<ModelApi> _modelApi = [];

  final apiData = DataApi();

  String _search = '';

  final keyForm = GlobalKey<FormState>();
  final account = TextEditingController();
  final money = TextEditingController();

  Future<bool?> getApi() async {
    try {
      var les =
          await apiData.getDataApi(account: account.text, money: money.text);
      return les?.resultCode == 200 ? true : false;
    } catch (e) {
      return null;
    }
  }

  Future<void> getAmount() async {
    modelWithdraw = selectMoney.map((e) => ModelWithdraw.fromJson(e)).toList();
  }

  onChange() {
    if (account.text.isNotEmpty && money.text.isNotEmpty) {
      notifyListeners();
    }
  }

  Future<void> getBank() async {
    modelBank = dataBank.map((e) => ModelBank.fromJson(e)).toList();
  }

  Future<void> getCategory() async {
    modelMenuTransfer =
        menuTransfer.map((e) => ModelMenuTransfer.fromJson(e)).toList();
  }

  List<ModelBank> get modelBank => _modelBank
      .where((element) => (context.locale.toString() == 'en_US'
              ? element.nameEn.toLowerCase()
              : element.nameTh.toLowerCase())
          .contains(search.toLowerCase()))
      .toList();

  set modelBank(List<ModelBank> value) {
    _modelBank = value;
    notifyListeners();
  }

  List<ModelMenuTransfer> get modelMenuTransfer => _modelMenuTransfer;

  set modelMenuTransfer(List<ModelMenuTransfer> value) {
    _modelMenuTransfer = value;
    notifyListeners();
  }

  List<ModelWithdraw> get modelWithdraw => _modelWithdraw;

  set modelWithdraw(List<ModelWithdraw> value) {
    _modelWithdraw = value;
    notifyListeners();
  }

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<ModelApi> get modelApi => _modelApi;

  set modelApi(List<ModelApi> value) {
    _modelApi = value;
    notifyListeners();
  }

}
