import 'package:viz_transaction/viz_transaction.dart';

void main() {
  int refBlockNum = BlockchainUtils.getRefBlockNum(7097393);
  int refBlockPrefix = BlockchainUtils.getRefBlockPrefix(
      "006c4c314a0c19918caa3187abdebfeeb56724b1");

  print('ref_block_num: $refBlockNum');
  print('ref_block_prefix: $refBlockPrefix');
}
