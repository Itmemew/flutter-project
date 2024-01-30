import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_run_app/k_bank/num_pad_code/CodeUnlock%20.dart';

class NumPad extends StatefulWidget {
  final int length;
  final Function(String) onChange;

  const NumPad({super.key, required this.length, required this.onChange});

  @override
  State<NumPad> createState() => _NumPadState();
}

class _NumPadState extends State<NumPad> {
  String number = '';

  setValue(String val) {
    if (number.length < widget.length) {
      setState(() {
        number += val;
        widget.onChange(number);
      });
    }
  }

  backspace(String text) {
    if (text.isNotEmpty) {
      setState(() {
        number = text.split('').sublist(0, text.length - 1).join('');
        widget.onChange(number);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                  alignment: Alignment.topRight,
                  child: CloseButton()),
            ),
            SizedBox(height: 50),
            Text(
              'please_input_your_pin_code'.tr(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Preview(
              text: number,
              length: widget.length,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumPadButton(text: '1', onPressed: () => setValue('1')),
                NumPadButton(text: '2', onPressed: () => setValue('2')),
                NumPadButton(text: '3', onPressed: () => setValue('3')),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumPadButton(text: '4', onPressed: () => setValue('4')),
                NumPadButton(text: '5', onPressed: () => setValue('5')),
                NumPadButton(text: '6', onPressed: () => setValue('6')),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumPadButton(text: '7', onPressed: () => setValue('7')),
                NumPadButton(text: '8', onPressed: () => setValue('8')),
                NumPadButton(text: '9', onPressed: () => setValue('9')),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumPadButton(
                  haveBorder: false,
                ),
                NumPadButton(text: '0', onPressed: () => setValue('0')),
                NumPadButton(
                    icon: Icons.backspace, onPressed: () => backspace(number)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
