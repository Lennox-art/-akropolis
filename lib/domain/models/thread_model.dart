
import 'package:akropolis/data/models/remote_models/remote_models.dart';

class Thread implements Comparable<Thread>{
  final ThreadRemote threadRemote;
  final AppUser participant1;
  final AppUser participant2;

  Thread(this.threadRemote, this.participant1, this.participant2);

  @override
  int compareTo(Thread other) {
    return threadRemote.compareTo(other.threadRemote);
  }


}