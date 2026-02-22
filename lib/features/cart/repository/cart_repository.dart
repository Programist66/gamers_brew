class CartRepository {
  Future<double> validatePromoCode(String code) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (code.toLowerCase() == 'gamer') return 0.2;
    return 0.0;
  }
}