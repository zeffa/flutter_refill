import 'package:flutter/material.dart';
import 'package:uji/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:uji/core/utils/colors.dart';

Widget loginPasswordInput(LoginController controller) {
  return TextFormField(
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: RefillStationColors.skyBlue()),
            borderRadius: BorderRadius.circular(10)),
        labelText: "Password",
        prefixIcon: Icon(Icons.lock)),
    keyboardType: TextInputType.visiblePassword,
    obscureText: true,
    controller: controller.passwordController,
    onSaved: (value) {
      controller.password.value = value!;
    },
    validator: (password) {
      return controller.validatePassword(password!);
    },
  );
}

Widget loginEmailInput(LoginController controller) {
  return TextFormField(
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        labelText: "Email Address",
        prefixIcon: Icon(Icons.email)),
    keyboardType: TextInputType.emailAddress,
    controller: controller.emailController,
    onSaved: (value) {
      controller.email.value = value!;
    },
    validator: (email) {
      return controller.validatePhone(email!);
    },
  );
}

Widget loginPhoneInput(LoginController controller) {
  return TextFormField(
    decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)),
        labelText: "Phone number",
        prefixIcon: Icon(Icons.call)),
    keyboardType: TextInputType.phone,
    controller: controller.emailController,
    onSaved: (value) {
      controller.email.value = value!;
    },
    validator: (email) {
      return controller.validatePhone(email!);
    },
  );
}

Widget loginButton({required LoginController controller, required Function onLoginPressed}) {
  return ConstrainedBox(
    constraints: BoxConstraints.tightFor(width: double.infinity),
    child: ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
            RefillStationColors.skyBlue()),
        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
      ),
      child: Text(
        "Login",
        style: TextStyle(fontSize: 14, color: Colors.white),
      ),
      onPressed: () => onLoginPressed(),
    ),
  );
}
