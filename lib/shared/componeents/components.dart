import 'package:flutter/material.dart';

TextFormField defaultTextFormFieled(
    {@required TextEditingController controller,
    @required TextInputType textInputType,
    @required IconData iconPrefix,
    Widget iconSuffix,
    @required String text,
    @required Function validator,
    Function onTap,
    Function onChanged,
    bool obscure=false,
    Function onSubmitted}) {
  return TextFormField(
    
    controller: controller,
    keyboardType: textInputType,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(width: 0.5,color: Colors.black)),
      prefixIcon: Icon(iconPrefix),
      suffixIcon: iconSuffix != null ? iconSuffix : null,
      hintText: text,
      labelText: text,
     // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
    ),
    validator: validator,
    onTap: onTap,
    onFieldSubmitted: onSubmitted,
    onChanged: onChanged,
    obscureText: obscure,
    
  );
}

Widget imageNetworkCached(String url) {
  return Image.network(
    url,
    fit: BoxFit.fill,
    errorBuilder: (context, error, stackTrace) => Center(
        child: Text(
      'لا توجد صورة',
      overflow: TextOverflow.ellipsis,
    )),
  );
}
Widget buildItemSettings(BuildContext context,{ String name,
  final IconData iconData,
  final Function ontap})
  {
    return ListTile(
      leading: Icon(iconData),
      title: Text(name),
      onTap:ontap,
    );
  }