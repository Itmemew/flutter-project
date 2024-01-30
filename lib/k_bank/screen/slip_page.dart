
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test_run_app/k_bank/screen/home_page_k_bank.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'dart:ui' as ui;

class SlipPage extends StatefulWidget {
  final String note;
  final String sendAccount;
  final String sendMoney;

  const SlipPage(
      {super.key,
      required this.note,
      required this.sendAccount,
      required this.sendMoney});

  @override
  State<SlipPage> createState() => _SlipPageState();
}

class _SlipPageState extends State<SlipPage> {
  WidgetsToImageController controller = WidgetsToImageController();
  Uint8List? bytes;

  GlobalKey globalKey = GlobalKey();

  Future<void> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage();
      ByteData? byteData =
          await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final result = await ImageGallerySaver.saveImage(
            bytes = byteData.buffer.asUint8List());
      }
      setState(() {});
    } catch (e, s) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004444),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'successfully'.tr(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 5,
                              decoration:
                                  BoxDecoration(color: Colors.greenAccent),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'transferred_successfully'.tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                        buildBox(),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.grey,
                          size: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildBox1(),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'item_number'.tr(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'amount'.tr(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'fees'.tr(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text('022256789'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('${(NumberFormat("#,###").format(
                                  int.parse(widget.sendMoney),
                                ))} baht')
                                    .tr(),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('0.00 baht').tr(),
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: [
                                QrImageView(
                                  data: widget.sendAccount,
                                  version: QrVersions.auto,
                                  size: 150.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('note'.tr()),
                            SizedBox(
                              width: 5,
                            ),
                            Text(widget.note)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 48),
                IconButton(
                    onPressed: () {
                      _capturePng();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePageKBank()));
                      final snackBar = SnackBar(
                        content: Text('save_slip'.tr()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2)),
                      child: Icon(
                        Icons.save_alt,
                        size: 30,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'name_account'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text('xxx-x-xxx-9898')
              ],
            )
          ],
        )
      ],
    );
  }

  Widget buildBox1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'name_transfer'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(widget.sendAccount),
              ],
            )
          ],
        )
      ],
    );
  }
}
