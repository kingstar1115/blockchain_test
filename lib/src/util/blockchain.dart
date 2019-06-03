class BlockchainUtils {
  ///Returns a ref\_block\_num from any block number(height)
  static int getRefBlockNum(int block) {
    return block & 0xffff;
  }

  ///Return a ref\_block\_prefix from any block id
  static int getRefBlockPrefix(String blockId) {
    List<String> n = [];

    for (int i = 0; i < blockId.length; i += 2) {
      n.add(blockId.substring(i, i + 2));
    }

    String hex = n[7] + n[6] + n[5] + n[4];
    int refBlockPrefix = int.tryParse(hex, radix: 16);

    return refBlockPrefix;
  }
}
