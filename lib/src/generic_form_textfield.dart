part of flutter_generic_widgets;

enum TextFieldType {
  username,
  name,
  email,
  password,
  mobile,
  corodinate,
  license,
  id,
  number,
  date,
  datetime,
  radio,
}

final List<Map> gender = [
  {'value': 'male', 'display': 'Male'},
  {'value': 'female', 'display': 'Female'}
];

class GenericFormTextField {
  final Map<String, dynamic> formData;
  TextEditingController textController;

  GenericFormTextField({@required this.formData});

  Widget genericTextField(
      {@required String labelText,
      @required String labelHint,
      @required String formName,
      @required TextFieldType validationType,
      @required TextInputType keyboardType,
      TextEditingController textEditingController,
      BuildContext context}) {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        child: (validationType == TextFieldType.date) ||
                (validationType == TextFieldType.datetime)
            ? datetimeFormField(
                labelText: labelText,
                labelHint: labelHint,
                formName: formName,
                validationType: validationType,
                context: context,
                controller: textEditingController)
            : validationType == TextFieldType.radio
                ? radioFormField(
                    labelText: labelText,
                    labelHint: labelHint,
                    formName: formName,
                    data: gender,
                    validationType: validationType,
                    context: context)
                : textFormField(
                    keyboardType: keyboardType,
                    validationType: validationType,
                    labelText: labelText,
                    labelHint: labelHint,
                    formName: formName,
                    textController: textEditingController));
  }

  Widget datetimeFormField(
      {String labelText,
      String labelHint,
      String formName,
      TextFieldType validationType,
      BuildContext context,
      TextEditingController controller}) {
    final format = validationType == TextFieldType.date
        ? DateFormat("yyyy-MM-dd")
        : DateFormat("yyyy-MM-dd HH:mm");

    return DateTimeField(
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        helperText: labelHint,
        suffixIcon: Icon(
          Icons.event,
        ),
      ),
      controller: controller,
      // initialValue: controller != null ? null : DateTime.parse(controller.text),
      format: format,
      onShowPicker: validationType == TextFieldType.date
          ? (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime.now());
            }
          : (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime.now());
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                return DateTimeField.combine(date, time);
              } else {
                return currentValue;
              }
            },
      onSaved: (value) {
        formData[formName] =
            value != null ? value.toIso8601String() : controller.text;
      },
      onChanged: (DateTime value) {
        formData[formName] =
            value != null ? value.toIso8601String() : controller.text;
      },
      textInputAction: TextInputAction.next,
    );
  }

  Widget textFormField(
      {TextInputType keyboardType,
      TextFieldType validationType,
      String labelText,
      String labelHint,
      String formName,
      TextEditingController textController}) {
    return TextFormField(
      controller: textController,
      keyboardType: keyboardType,
      obscureText: validationType == TextFieldType.password ? true : false,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.bold),
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
        hintText: labelHint,
      ),
      style: TextStyle(color: Colors.black),
      validator: (String value) {
        return validator(value, validationType);
      },
      // inputFormatters: validationType == TextFieldType.number
      //     ? <TextInputFormatter>[
      //         FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      //       ]
      //     : [],
      // initialValue: validationType == TextFieldType.number ? 0.toString() : "",
      onSaved: (String value) {
        if (validationType == TextFieldType.number) {
          formData[formName] = (value == null || value == "")
              ? 0.toString()
              : num.parse(value).toString();
        } else {
          formData[formName] = value;
        }
      },
      textInputAction: validationType == TextFieldType.password
          ? TextInputAction.done
          : TextInputAction.next,
    );
  }

  Widget radioFormField(
      {String labelText,
      String labelHint,
      String formName,
      List<Map> data,
      TextFieldType validationType,
      BuildContext context}) {
    return Column(
      children: [
        Text(labelText,
            style: TextStyle(
                color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold)),
        Container(
            child: RadioButtonFormField(
          toggleable: true,
          padding: EdgeInsets.all(8),
          context: context,
          value: 'value',
          display: 'display',
          data: data,
          onSaved: (value) {
            formData[formName] = value;
          },
        ))
      ],
    );
  }

  String validator(String value, TextFieldType type) {
    if (type == TextFieldType.name) {
      if (value.isEmpty || value.length < 5) {
        return 'Please enter a valid Name with atleast 5 character';
      }
    } else if (type == TextFieldType.password) {
      if (value.isEmpty) {
        return 'Please enter password';
      }
      if (value.length < 6) {
        return 'Password minimum 6 character';
      }
    } else if (type == TextFieldType.email) {
      if (value.isEmpty ||
          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
        return 'Please enter a valid email';
      }
    } else if (type == TextFieldType.mobile) {
      if (value.isEmpty ||
          !RegExp(r"[0][1-9][0-9]{9}").hasMatch(value) ||
          value.length < 11 ||
          value.length > 11) {
        return 'Please enter a valid mobile number';
      }
    } else if (type == TextFieldType.corodinate) {
    } else if (type == TextFieldType.license) {
      if (value.isEmpty || value.length < 15) {
        return 'Please enter a valid License';
      }
    } else if (type == TextFieldType.id) {
      if (value.isEmpty || value.length < 9 || value.length > 9) {
        return 'Please enter a valid ID';
      }
    } else if (type == TextFieldType.number) {
      if (value.isEmpty || value.length <= 0) {
        return 'Please enter a valid Number';
      }
    }
    return null;
  }
}
