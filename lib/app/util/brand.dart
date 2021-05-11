import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/brand.dart';
import '../resources/theme.dart';

extension BrandContext on BuildContext {
  Brand get brand => Provider.of<Brand>(this, listen: false);
}

extension ThemeOfBrand on Brand {
  BrandTheme get theme {
    if (isVialer) {
      return const VialerTheme();
    } else if (isVoys || isVoysFreedom) {
      return const VoysTheme();
    }

    throw UnsupportedError('Unknown brand: $this');
  }
}