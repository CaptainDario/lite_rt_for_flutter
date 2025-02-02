


/// Simple singleton that keeps track of which library packages are installed
class InstalledLibs {

  static final InstalledLibs _singleton = InstalledLibs._internal();
  
  bool libsInstalled = false;

  factory InstalledLibs() {
    return _singleton;
  }
  
  InstalledLibs._internal();
}
