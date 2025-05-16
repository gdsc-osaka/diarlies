part of 'page.dart';

@riverpod
HomeSocialAction _homeSocialAction(Ref ref) => HomeSocialAction(ref);

class HomeSocialAction extends FluxAction {
  HomeSocialAction(super.ref);

  Future<void> reloadTimeline() async {
    ref.invalidate(diariesInTimelineProvider);

    // FIXME: wait until diariesInTimelineProvider is loaded
    await Future.delayed(const Duration(milliseconds: 300));
  }
}