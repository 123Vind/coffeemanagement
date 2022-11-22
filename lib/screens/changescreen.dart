import 'package:coffeemanagement/dbhelper/dbhelper.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ChangeScreen extends StatelessWidget {
  ChangeScreen({Key? key,
  required this.homepage,
  required this.noitem
  }) : super(key: key);
  Widget homepage;
  Widget noitem;
  @override
  Widget build(BuildContext context) {
    DbHelper _dbhelper = Provider.of<DbHelper>(context);
    return _dbhelper.checkitemlist()?noitem:homepage;

  }
}