class Danka {
  // Danka(this.dankaId, this.name, this.address, this.buppanFlg, this.others);

  int _fDankaId = 0;
  String _fName = "";
  String _fAddress = "";
  int _fBuppanFlg = 1;
  String _fOthers = "";

  int get dankaId => _fDankaId;

  set dankaId(int value) {
    _fDankaId = value;
  }

  String get name => _fName;

  set name(String value) {
    _fName = value;
  }

  String get address => _fAddress;

  set address(String value) {
    _fAddress = value;
  }

  int get buppanFlg => _fBuppanFlg;

  set buppanFlg(int value) {
    _fBuppanFlg = value;
  }

  String get others => _fOthers;

  set others(String value) {
    _fOthers = value;
  }
}
