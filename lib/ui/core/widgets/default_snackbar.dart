import 'package:flutter/material.dart';

import '../../../app/constants.dart';

SnackBar addedToCartSnackbar() {
  return const SnackBar(
      duration: Constants.snackbarDuration,
      content: Text("Item added to Cart successfully"));
}
