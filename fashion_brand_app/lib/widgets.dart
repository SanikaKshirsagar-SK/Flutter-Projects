import "package:flutter/material.dart";
import "package:get/get.dart";

TextStyle textStyleHeadingData({Color? color}) {
  return TextStyle(
    fontFamily: "acme",
    fontSize: 30,
    fontWeight: FontWeight.w600,
    height: 36 / 36,
    color: color ?? const Color.fromRGBO(13, 13, 14, 1),
  );
}

TextStyle textStyleData(
    double fSize, int fWeight, double fHeight, List<dynamic> colors) {
  return TextStyle(
      fontFamily: "acme",
      fontSize: fSize,
      fontWeight: FontWeight.values[(fWeight ~/ 100) - 1],
      height: fHeight / fSize,
      color: Color.fromRGBO(
          colors[0], colors[1], colors[2], colors[3].toDouble()));
}

Container customTextField(
  String hintText, {
  required TextEditingController controller,
  String? label,
  bool obscureText = false,
}) {
  return Container(
    decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
              color: Color.fromRGBO(0, 0, 0, 0.15)),
        ]),
    child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontFamily: "acme",
          fontSize: 14,
        ),
        decoration: InputDecoration(
            labelText: label,
            labelStyle: label != null
                ? textStyleData(12, 400, 18, [0, 0, 0, 0.4])
                : null,
            hintText: hintText,
            hintStyle: textStyleData(12, 400, 18, [0, 0, 0, 0.4]),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none))),
  );
}

SizedBox sizedBox20() {
  return const SizedBox(
    height: 20,
  );
}

SizedBox sizedBox10() {
  return const SizedBox(
    height: 10,
  );
}

SizedBox sizedBoxWidth10() {
  return const SizedBox(
    width: 10,
  );
}

SizedBox sizedBoxWidth20() {
  return const SizedBox(
    width: 10,
  );
}

TextStyle textStyleData16() {
  return const TextStyle(
      fontFamily: "acme", fontSize: 16, fontWeight: FontWeight.w400);
}

TextStyle textStyleData18({Color? color}) {
  return TextStyle(
    fontFamily: "acme",
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: color ?? const Color.fromRGBO(13, 13, 14, 1),
  );
}

TextStyle textStylAppBarData({Color? textColor}) {
  return TextStyle(
    fontFamily: "acme",
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: textColor ?? const Color.fromRGBO(13, 13, 14, 1),
  );
}

TextStyle textStyleData16grey() {
  return const TextStyle(
      fontFamily: "acme",
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color.fromRGBO(121, 119, 128, 1));
}

Container customTextFormField(
  String hintText, {
  required TextEditingController controller,
  String? label,
  bool obscureText = false,
  String? validatorText,
  required String? validator,
}) {
  return Container(
    decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
              color: Color.fromRGBO(0, 0, 0, 0.15)),
        ]),
    child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontFamily: "acme",
          fontSize: 14,
        ),
        decoration: InputDecoration(
            labelText: label,
            labelStyle: label != null
                ? textStyleData(12, 400, 18, [0, 0, 0, 0.4])
                : null,
            hintText: hintText,
            hintStyle: textStyleData(12, 400, 18, [0, 0, 0, 0.4]),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none)),
        validator: (value) {
          if (value!.isEmpty) {
            return validatorText;
          }
          return null;
        }),
  );
}

Container customButton(
    {required void Function()? onPressed, required String buttonText}) {
  return Container(
      height: 49,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: const Color.fromRGBO(76, 61, 59, 1)),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: textStyleData(25, 700, 30, [255, 255, 255, 1]),
        ),
      ));
}

SizedBox customButtonRounded(
    {Color? color,
    List<dynamic>? textColor,
    required void Function()? onPressed,
    required String buttonText}) {
  return SizedBox(
    height: 62,
    width: 170,
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                color ?? const Color.fromRGBO(76, 61, 59, 1)),
            shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90))),
            alignment: Alignment.center),
        onPressed: onPressed,
        child: Text(buttonText,
            style:
                textStyleData(18, 400, 18, textColor ?? [255, 255, 255, 1]))),
  );
}

SizedBox customButtonMovetoCart(
    {Color? color,
    List<dynamic>? textColor,
    required void Function()? onPressed,
    required String buttonText}) {
  return SizedBox(
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                color ?? const Color.fromRGBO(76, 61, 59, 1)),
            shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            alignment: Alignment.center),
        onPressed: onPressed,
        child: Text(buttonText,
            style:
                textStyleData(18, 400, 18, textColor ?? [255, 255, 255, 1]))),
  );
}

AppBar customAppBar({
  required String title,
  Color? backgroundColor,
  Color? textColor,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(
      title,
      style: textStylAppBarData(textColor: textColor),
    ),
    centerTitle: true,
    backgroundColor: backgroundColor ?? const Color.fromRGBO(255, 255, 255, 1),
    leading: leading,
    actions: actions,
    automaticallyImplyLeading: false,
  );
}

SizedBox customButtonReorder(
    {Color? color,
    List<dynamic>? textColor,
    Color? borderColor,
    required void Function()? onPressed,
    required String buttonText}) {
  return SizedBox(
    height: 30,
    width: Get.width / 3.5,
    child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
                color ?? const Color.fromRGBO(255, 255, 255, 1)),
            shape: WidgetStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                        color:
                            borderColor ?? const Color.fromRGBO(76, 61, 59, 1),
                        width: 1.5))),
            alignment: Alignment.center),
        onPressed: onPressed,
        child: Text(buttonText,
            style: textStyleData(18, 400, 18, textColor ?? [76, 61, 59, 1]))),
  );
}

Widget shadedContainer(Widget child,
    {List<PositionedPosition> positions = const []}) {
  return Stack(
    children: [
      child,
      if (positions.contains(PositionedPosition.bottomLeft)) bottomLeft(),
      if (positions.contains(PositionedPosition.bottomRight)) bottomRight(),
      if (positions.contains(PositionedPosition.topLeft)) topLeft(),
      if (positions.contains(PositionedPosition.topRight)) topRight(),
    ],
  );
}

enum PositionedPosition { none, bottomLeft, bottomRight, topLeft, topRight }

Positioned bottomLeft() {
  return Positioned(
    bottom: 0,
    left: 0,
    child: ClipRect(
      child: Transform.translate(
        offset: const Offset(-75, 95),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(76, 61, 59, 0.8), // Orange color
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6), // Faint border
                spreadRadius: 40,
                blurRadius: 20,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Positioned bottomRight() {
  return Positioned(
    bottom: 0,
    right: 0,
    child: ClipRect(
      child: Transform.translate(
        offset: const Offset(100, 125),
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(76, 61, 59, 0.8), // Orange color
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6), // Faint border
                spreadRadius: 40,
                blurRadius: 20,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Positioned topLeft() {
  return Positioned(
    top: 0,
    left: 0,
    child: ClipRect(
      child: Transform.translate(
        offset: const Offset(-70, -90),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(76, 61, 59, 0.8), // Orange color
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9), // Faint border
                spreadRadius: 40,
                blurRadius: 40,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Positioned topRight() {
  return Positioned(
    top: 0,
    right: 0,
    child: ClipRect(
      child: Transform.translate(
        offset: const Offset(100, -125),
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(76, 61, 59, 0.8), // Orange color
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9), // Faint border
                spreadRadius: 40,
                blurRadius: 40,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
