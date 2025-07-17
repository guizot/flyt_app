import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyt_app/presentation/core/helper/number_input_formatter.dart';
import '../constant/form_type.dart';
import '../handler/dialog_handler.dart';
import 'package:intl/intl.dart';

class TextFieldItem extends StatefulWidget {
  const TextFieldItem({
    super.key,
    required this.title,
    this.formType = FormType.text,
    this.inputType = TextInputType.text,
    this.preText = "",
    required this.controller
  });

  final String title;
  final FormType formType;
  final TextInputType inputType;
  final String preText;
  final TextEditingController controller;

  @override
  State<TextFieldItem> createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {

  @override
  void initState() {
    super.initState();
    setState(() {
      switch(widget.formType) {
        case FormType.text:
          textValue = widget.controller.text;
        case FormType.switcher:
          switchValue = widget.controller.text == 'true' ? true : false;
          widget.controller.text = switchValue.toString();
        case FormType.date:
          try {
            DateFormat format = DateFormat('dd MMM yyyy - HH:mm');
            DateTime dateTime = format.parse(widget.controller.text);
            dateTempValue = dateTime;
          } catch(e) {
            dateTempValue = DateTime.now();
          }
          String formattedDate = DateFormat('dd MMM yyyy - HH:mm').format(dateTempValue!);
          widget.controller.text = formattedDate;
      }
    });
  }

  // region TEXT WIDGET

  String textValue = "";

  Widget textWidget(BuildContext context) {
    return ClipPath(
        clipper: const ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))
            )
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                widget.preText != "" ? Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    widget.preText,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ) : Container(),
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'input ${widget.title.toLowerCase()}',
                      hintStyle: TextStyle(
                          color: Theme.of(context).iconTheme.color?.withAlpha(70),
                          fontWeight: FontWeight.normal
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: widget.inputType,
                    maxLines: widget.inputType == TextInputType.multiline ? null : 1,
                    inputFormatters: widget.inputType == TextInputType.number
                        ? [FilteringTextInputFormatter.digitsOnly, NumberInputFormatter()]
                        : []
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  // endregion

  // region SWITCHER WIDGET

  bool switchValue = false;

  Widget switchItem({
    required String text,
    required Color color,
    required GestureTapCallback onTap
  }) {
    return Expanded(
        child: GestureDetector(
            onTap: onTap,
            child: ClipPath(
              clipper: const ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0))
                  )
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
        )
    );
  }

  Widget switcherWidget(BuildContext context) {
    return Row(
      children: [
        switchItem(
            text: "Confirmed",
            color: switchValue ? Colors.green : Theme.of(context).highlightColor,
            onTap: () {
              setState(() {
                switchValue = true;
                widget.controller.text = switchValue.toString();
              });
            }
        ),
        const SizedBox(width: 8),
        switchItem(
            text: "Unconfirmed",
            color: !switchValue ? Colors.green : Theme.of(context).highlightColor,
            onTap: () {
              setState(() {
                switchValue = false;
                widget.controller.text = switchValue.toString();
              });
            }
        ),
      ],
    );
  }

  // endregion

  // region DATE WIDGET

  DateTime? dateTempValue;

  void datePicker(BuildContext context) {
    DialogHandler.showBottomSheet(
        context: context,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 5.0,
                    width: MediaQuery.of(context).size.width / 4,
                    decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor,
                        borderRadius: const BorderRadius.all(Radius.circular(25.0))
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                          height: 215,
                          color: Theme.of(context).colorScheme.surface,
                          child: CupertinoDatePicker(
                            initialDateTime: dateTempValue,
                            mode: CupertinoDatePickerMode.dateAndTime,
                            onDateTimeChanged: (DateTime newDate) {
                              dateTempValue = newDate;
                            },
                          )
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          String formattedDate = DateFormat('dd MMM yyyy - HH:mm').format(dateTempValue ?? DateTime.now());
                          widget.controller.text = formattedDate;
                        });
                        Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).iconTheme.color,
                        padding: const EdgeInsets.all(16.0),
                      ),
                      child: const Text("Done"),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }

  Widget dateWidget(BuildContext context) {
    return Row(
      children: [
        switchItem(
            text: widget.controller.text,
            color: Theme.of(context).highlightColor,
            onTap: () {
              datePicker(context);
            }
        )
      ],
    );
  }

  // endregion

  Widget formWidget(BuildContext context) {
    if(widget.formType == FormType.text) {
      return textWidget(context);
    }
    else if(widget.formType == FormType.switcher) {
      return switcherWidget(context);
    }
    else if(widget.formType == FormType.date) {
      return dateWidget(context);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipPath(
            clipper: const ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))
                )
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).hoverColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_circle_right_rounded,
                        size: 18,
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                          child: Text(
                            widget.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16
                            ),
                          )
                      ),
                      const SizedBox(width: 8.0),
                    ],
                  ),
                  const SizedBox(height: 8.0,),
                  formWidget(context)
                ],
              ),
            )
        ),
        const SizedBox(height: 16),
      ],
    );

  }

}