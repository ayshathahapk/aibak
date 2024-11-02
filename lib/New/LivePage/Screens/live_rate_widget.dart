import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aibak/Core/app_export.dart';

class ValueDisplayWidgetSilver1 extends StatefulWidget {
  final double value;

  const ValueDisplayWidgetSilver1({super.key, required this.value});

  @override
  State createState() => _ValueDisplayWidgetSilver1State();
}

class _ValueDisplayWidgetSilver1State extends State<ValueDisplayWidgetSilver1> {
  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;
  bool _isChanging = false;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  // @override
  // void didUpdateWidget(ValueDisplayWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.value != oldWidget.value) {
  //     _updateColor();
  //   }
  // }
  @override
  void didUpdateWidget(ValueDisplayWidgetSilver1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    setState(() {
      if (widget.value > _lastValue) {
        _containerColor = appTheme.mainGreen;
        _isChanging = true;
      } else if (widget.value < _lastValue) {
        _containerColor = appTheme.red700;
        _isChanging = true;
      }
      _lastValue = widget.value;
    });

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_isChanging) {
        setState(() {
          _containerColor = appTheme.mainWhite;
          _isChanging = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 100.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(2),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}

///

class ValueDisplayWidgetSilver2 extends StatefulWidget {
  final double value;

  const ValueDisplayWidgetSilver2({super.key, required this.value});

  @override
  _ValueDisplayWidgetSilver2State createState() =>
      _ValueDisplayWidgetSilver2State();
}

class _ValueDisplayWidgetSilver2State extends State<ValueDisplayWidgetSilver2> {
  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;
  bool _isChanging = false;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  // @override
  // void didUpdateWidget(ValueDisplayWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.value != oldWidget.value) {
  //     _updateColor();
  //   }
  // }
  @override
  void didUpdateWidget(ValueDisplayWidgetSilver2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    setState(() {
      if (widget.value > _lastValue) {
        _containerColor = appTheme.mainGreen;
        _isChanging = true;
      } else if (widget.value < _lastValue) {
        _containerColor = appTheme.red700;
        _isChanging = true;
      }
      _lastValue = widget.value;
    });

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_isChanging) {
        setState(() {
          _containerColor = appTheme.mainWhite;
          _isChanging = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  // Color _containerColor = Colors.white;
  // Timer? _debounceTimer;
  // double _lastValue = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _lastValue = widget.value;
  // }
  //
  // @override
  // void didUpdateWidget(ValueDisplayWidgetSilver2 oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.value != oldWidget.value) {
  //     _updateColor();
  //   }
  // }
  //
  // void _updateColor() {
  //   if (_debounceTimer?.isActive ?? false) {
  //     _debounceTimer!.cancel();
  //   }
  //
  //   _debounceTimer = Timer(const Duration(milliseconds: 100), () {
  //     setState(() {
  //       if (widget.value > _lastValue) {
  //         _containerColor = appTheme.mainGreen;
  //       } else if (widget.value < _lastValue) {
  //         _containerColor = appTheme.red700;
  //       } else {
  //         _containerColor = appTheme.mainWhite;
  //       }
  //       _lastValue = widget.value;
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _debounceTimer?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 100.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(2),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}

///

class ValueDisplayWidget extends StatefulWidget {
  final double value;

  const ValueDisplayWidget({Key? key, required this.value}) : super(key: key);

  @override
  _ValueDisplayWidgetState createState() => _ValueDisplayWidgetState();
}

class _ValueDisplayWidgetState extends State<ValueDisplayWidget> {
  // Color _containerColor = Colors.white;
  // Timer? _debounceTimer;
  // double _lastValue = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _lastValue = widget.value;
  // }
  //
  // @override
  // void didUpdateWidget(ValueDisplayWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.value != oldWidget.value) {
  //     _updateColor();
  //   }
  // }
  //
  // void _updateColor() {
  //   if (_debounceTimer?.isActive ?? false) {
  //     _debounceTimer!.cancel();
  //   }
  //
  //   _debounceTimer = Timer(const Duration(milliseconds: 100), () {
  //     setState(() {
  //       if (widget.value > _lastValue) {
  //         _containerColor = appTheme.mainGreen;
  //       } else if (widget.value < _lastValue) {
  //         _containerColor = appTheme.red700;
  //       } else {
  //         _containerColor = appTheme.mainWhite;
  //       }
  //       _lastValue = widget.value;
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _debounceTimer?.cancel();
  //   super.dispose();
  // }

  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;
  bool _isChanging = false;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  // @override
  // void didUpdateWidget(ValueDisplayWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.value != oldWidget.value) {
  //     _updateColor();
  //   }
  // }
  @override
  void didUpdateWidget(ValueDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    setState(() {
      if (widget.value > _lastValue) {
        _containerColor = appTheme.mainGreen;
        _isChanging = true;
      } else if (widget.value < _lastValue) {
        _containerColor = appTheme.red700;
        _isChanging = true;
      }
      _lastValue = widget.value;
    });

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_isChanging) {
        setState(() {
          _containerColor = appTheme.mainWhite;
          _isChanging = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 100.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(2),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}

///

class ValueDisplayWidget2 extends StatefulWidget {
  final double value;

  const ValueDisplayWidget2({Key? key, required this.value}) : super(key: key);

  @override
  _ValueDisplayWidget2State createState() => _ValueDisplayWidget2State();
}

class _ValueDisplayWidget2State extends State<ValueDisplayWidget2> {
  // Color _containerColor = Colors.white;
  // Timer? _debounceTimer;
  // double _lastValue = 0;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _lastValue = widget.value;
  // }
  //
  // @override
  // void didUpdateWidget(ValueDisplayWidget2 oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.value != oldWidget.value) {
  //     _updateColor();
  //   }
  // }
  //
  // void _updateColor() {
  //   if (_debounceTimer?.isActive ?? false) {
  //     _debounceTimer!.cancel();
  //   }
  //
  //   _debounceTimer = Timer(const Duration(milliseconds: 100), () {
  //     setState(() {
  //       if (widget.value > _lastValue) {
  //         _containerColor = appTheme.mainGreen;
  //       } else if (widget.value < _lastValue) {
  //         _containerColor = appTheme.red700;
  //       } else {
  //         _containerColor = appTheme.mainWhite;
  //       }
  //       _lastValue = widget.value;
  //     });
  //   });
  // }
  //
  // @override
  // void dispose() {
  //   _debounceTimer?.cancel();
  //   super.dispose();
  // }

  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;
  bool _isChanging = false;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  // @override
  // void didUpdateWidget(ValueDisplayWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.value != oldWidget.value) {
  //     _updateColor();
  //   }
  // }
  @override
  void didUpdateWidget(ValueDisplayWidget2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    setState(() {
      if (widget.value > _lastValue) {
        _containerColor = appTheme.mainGreen;
        _isChanging = true;
      } else if (widget.value < _lastValue) {
        _containerColor = appTheme.red700;
        _isChanging = true;
      }
      _lastValue = widget.value;
    });

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_isChanging) {
        setState(() {
          _containerColor = appTheme.mainWhite;
          _isChanging = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 100.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(2),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}
