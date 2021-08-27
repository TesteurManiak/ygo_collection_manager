enum CardEditionEnum { first, unlimited }

extension CardEditionEnumModifier on CardEditionEnum {
  String get string {
    switch (this) {
      case CardEditionEnum.first:
        return '1st Edition';
      case CardEditionEnum.unlimited:
        return 'Unlimited';
    }
  }
}
