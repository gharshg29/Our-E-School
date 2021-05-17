import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ourESchool/core/enums/ViewState.dart';
import 'package:ourESchool/core/services/AnnouncementServices.dart';
import 'package:ourESchool/core/viewmodel/BaseModel.dart';
import 'package:ourESchool/locator.dart';

class AnnouncementPageModel extends BaseModel {
  AnnouncementServices _announcementServices = locator<AnnouncementServices>();

  AnnouncementPageModel();

  List<DocumentSnapshot> get postSnapshotList =>
      _announcementServices.postDocumentSnapshots;

  // ignore: non_constant_identifier_names
  getAnnouncements(String stdDiv_Global) async {
    setState(ViewState.Busy);
    await _announcementServices.getAnnouncements(stdDiv_Global);
    setState(ViewState.Idle);
  }

  // ignore: non_constant_identifier_names
  onRefresh(String stdDiv_Global) async {
    _announcementServices.postDocumentSnapshots.clear();
    _announcementServices.lastPostSnapshot = null;
    await getAnnouncements(stdDiv_Global);
  }

  @override
  void dispose() {
    _announcementServices.lastPostSnapshot = null;
    _announcementServices.postDocumentSnapshots.clear();
    super.dispose();
  }
}
