import 'package:flutter/material.dart';

class ConfigSwitch extends StatefulWidget {

  final bool configVar;
  final ValueChanged<bool> onChanged;

  const ConfigSwitch({super.key, required this.configVar, required this.onChanged});

  @override
  State<ConfigSwitch> createState() => _DownloaderConfigState();
}

class _DownloaderConfigState extends State<ConfigSwitch> {

  bool _value;

  _DownloaderConfigState() : _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.configVar;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
        value: _value,
        activeColor: Theme
            .of(context)
            .primaryColor,
        thumbIcon: MaterialStateProperty.resolveWith<Icon>((states) {
          return Icon(
              (states.contains(MaterialState.selected)) ? Icons.check : Icons
                  .close);
        }),
        onChanged: (bool value) {
          setState(() {
            _value = value;
          });
          widget.onChanged(value);
        }
    );
  }
}