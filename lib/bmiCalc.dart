import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BMICalculator extends StatefulWidget {
  bool clrFlds;
  BMICalculator({super.key, required this.clrFlds});

  @override
  State<BMICalculator> createState() => BMICalculatorState();
}

class BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  final TextEditingController _metersController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();

  double feets = 0;
  double inches = 0;
  double weight = 0;
  double height = 0;
  double bmi = 0.0;

  int val = 0;
  int heightVal = 0;
  String selectedWeightUnit = "Pounds";
  String selectedHeightUnit = "Feets/Inches";

  bool _feetTextField = false;
  bool _inchesTextField = false;
  bool _metersTextField = false;
  bool _weightTextField = false;

  void clearfields() {
    setState(() {
      _feetController.clear();
      _inchesController.clear();
      _metersController.clear();
      _weightController.clear();
      _bmiController.clear();
      FocusScope.of(context).unfocus();
      print(widget.clrFlds);
    });
  }

  void calculateBMI() {
    setState(() {
      if (selectedHeightUnit == "Meters") {
        if (_metersController.text.isEmpty ||
            !isNumeric(_metersController.text)) {
          _metersTextField = true;
        } else {
          height = double.parse(_metersController.text) * 39.3700787;
          _metersTextField = false;
        }
      } else {
        if ((_feetController.text.isEmpty ||
                !isNumeric(_feetController.text)) &&
            (_inchesController.text.isEmpty ||
                !isNumeric(_inchesController.text))) {
          _feetTextField = true;
          _inchesTextField = true;
        } else if (_feetController.text.isEmpty ||
            !isNumeric(_feetController.text)) {
          _feetTextField = true;
          _inchesTextField = false;
        } else if (_inchesController.text.isEmpty ||
            !isNumeric(_inchesController.text)) {
          _inchesTextField = true;
          _feetTextField = false;
        } else {
          height = (double.parse(_feetController.text) * 12) +
              double.parse(_inchesController.text);
          _feetTextField = false;
          _inchesTextField = false;
        }
      }

      if (selectedWeightUnit == "Kilograms") {
        if (_weightController.text.isEmpty ||
            !isNumeric(_weightController.text)) {
          _weightTextField = true;
        } else {
          weight = double.parse(_weightController.text) * 2.20462262;
          _weightTextField = false;
        }
      } else {
        if (_weightController.text.isEmpty ||
            !isNumeric(_weightController.text)) {
          _weightTextField = true;
        } else {
          weight = double.parse(_weightController.text);
          _weightTextField = false;
        }
      }
      if (selectedHeightUnit == "Feets/Inches") {
        if (_weightController.text.isEmpty ||
            !isNumeric(_weightController.text) &&
                (_feetController.text.isEmpty ||
                    !isNumeric(_feetController.text)) &&
                (_inchesController.text.isEmpty ||
                    !isNumeric(_inchesController.text))) {
          _bmiController.text = '';
        } else if (height != 0) {
          double bmi = (weight * 703) / (height * height);
          _bmiController.text = bmi.toStringAsFixed(1);
        }
      } else if (selectedHeightUnit == "Meters") {
        if (_weightController.text.isEmpty ||
            !isNumeric(_weightController.text) &&
                _metersController.text.isEmpty ||
            !isNumeric(_metersController.text)) {
          _bmiController.text = '';
        } else if (height != 0) {
          double bmi = (weight * 703) / (height * height);
          _bmiController.text = bmi.toStringAsFixed(1);
        }
      } else if (height != 0) {
        double bmi = (weight * 703) / (height * height);
        _bmiController.text = bmi.toStringAsFixed(1);
      } else {
        _bmiController.text = '';
      }
    });
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clrFlds == true) {
      clearfields();
      widget.clrFlds = false;
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        padding: const EdgeInsets.all(12),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Enter Your Height:",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Container(
                  width: 160,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Select Unit"),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text("Select Unit"),
                        value: selectedHeightUnit,
                        onChanged: (newValue) {
                          setState(() {
                            selectedHeightUnit = newValue!;
                            if (newValue == "Meters") {
                              heightVal = 1;
                            } else {
                              heightVal = 0;
                            }
                            _feetController.text = "";
                            _inchesController.text = "";
                            _metersController.text = "";
                            _bmiController.text = "";
                          });
                        },
                        items: <String>['Feets/Inches', 'Meters']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
            heightVal == 0
                ? Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _feetController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "feets",
                              errorText: _feetTextField
                                  ? "Field Can't be empty"
                                  : null,
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                if (_feetController.text.isEmpty) {
                                  _feetTextField = true;
                                } else {
                                  _feetTextField = false;
                                }
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextField(
                          controller: _inchesController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Inches",
                            errorText: _inchesTextField
                                ? "Field Can't be empty"
                                : null,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              if (_inchesController.text.isEmpty) {
                                _inchesTextField = true;
                              } else {
                                _inchesTextField = false;
                              }
                            });
                          },
                        )),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _metersController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Meters",
                          errorText:
                              _metersTextField ? "Field Can't be empty" : null,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (_metersController.text.isEmpty) {
                              _metersTextField = true;
                            } else {
                              _metersTextField = false;
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Enter Your Weight:",
                  style: TextStyle(fontSize: 16),
                ),
                const Spacer(),
                Container(
                  width: 160,
                  child: InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: "Select Unit",
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text("Select Unit"),
                        value: selectedWeightUnit,
                        onChanged: (newValue) {
                          setState(() {
                            selectedWeightUnit = newValue!;
                            if (newValue == "Kilograms") {
                              val = 1;
                            } else {
                              val = 0;
                            }
                            _weightController.text = "";
                            _bmiController.text = "";
                          });
                        },
                        items:
                            <String>['Pounds', 'Kilograms'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: val == 0 ? "Pounds" : "Kilograms",
                errorText: _weightTextField ? "Field Can't be empty" : null,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if (_weightController.text.isEmpty) {
                    _weightTextField = true;
                  } else {
                    _weightTextField = false;
                  }
                });
              },
            ),
            const SizedBox(width: 7),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SizedBox(
                height: 50,
                child: TextButton(
                  onPressed: () {
                    calculateBMI();
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                  },
                  child: const Center(
                    child: Text(
                      "Calculate",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _bmiController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: "Calculated BMI",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom)
          ],
        ),
      ),
    );
  }
}
