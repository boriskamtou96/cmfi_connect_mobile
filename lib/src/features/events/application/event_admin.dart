import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/services/image_picking.dart';
import '../domain/event.dart';
import '../domain/event_draft.dart';
import '../infrastructure/events_api.dart';
import 'events_providers.dart';

part 'event_admin.g.dart';

/// Every event for the admins: drafts included, latest first.
@riverpod
Future<List<CommunityEvent>> adminEvents(Ref ref) =>
    ref.watch(eventsApiProvider).adminList();

/// Who registered for an event, with the totals (admins).
@riverpod
Future<EventRegistrations> eventRegistrations(Ref ref, int eventId) =>
    ref.watch(eventsApiProvider).registrations(eventId);

/// What the admins do with the events. Each method throws an AppException on
/// failure; the event the server sends back replaces the one shown
/// everywhere (event page, lists).
class EventAdmin {
  const EventAdmin(this._ref);

  final Ref _ref;

  /// Sends an image picked on the phone (poster, news, gallery).
  Future<EventImage> upload(PickedImage image) => _kept(
    () =>
        _ref.read(eventsApiProvider).upload(image.bytes, filename: image.name),
  );

  Future<CommunityEvent> create(EventDraft draft) =>
      _changing(() => _ref.read(eventsApiProvider).create(draft));

  Future<CommunityEvent> save(int id, EventDraft draft) =>
      _changing(() => _ref.read(eventsApiProvider).update(id, draft));

  Future<CommunityEvent> saveProgram(int id, List<SessionDraft> sessions) =>
      _changing(() => _ref.read(eventsApiProvider).saveProgram(id, sessions));

  /// The next edition, as a draft one year later.
  Future<CommunityEvent> prepareNextEdition(int id) =>
      _changing(() => _ref.read(eventsApiProvider).prepareNextEdition(id));

  Future<CommunityEvent> addPost(
    int id, {
    required String body,
    int? imageId,
    bool pinned = false,
  }) => _changing(
    () => _ref
        .read(eventsApiProvider)
        .addPost(id, body: body.trim(), imageId: imageId, pinned: pinned),
  );

  Future<CommunityEvent> addPhotos(int id, List<int> imageIds) =>
      _changing(() => _ref.read(eventsApiProvider).addPhotos(id, imageIds));

  Future<CommunityEvent> deletePost(CommunityEvent event, int postId) =>
      _changing(() async {
        await _ref.read(eventsApiProvider).deletePost(event.id, postId);
        return event.copyWith(
          posts: [
            for (final post in event.posts)
              if (post.id != postId) post,
          ],
        );
      });

  Future<CommunityEvent> deletePhoto(CommunityEvent event, int photoId) =>
      _changing(() async {
        await _ref.read(eventsApiProvider).deletePhoto(event.id, photoId);
        return event.copyWith(
          photos: [
            for (final photo in event.photos)
              if (photo.id != photoId) photo,
          ],
        );
      });

  Future<void> delete(int id) => _kept(() async {
    await _ref.read(eventsApiProvider).delete(id);
    _ref
      ..invalidate(eventListProvider)
      ..invalidate(adminEventsProvider)
      ..invalidate(eventDetailProvider(id));
  });

  /// Runs [request], then shows the event it gives back.
  Future<CommunityEvent> _changing(Future<CommunityEvent> Function() request) =>
      _kept(() async {
        final event = await request();
        if (_ref.exists(eventDetailProvider(event.id))) {
          await _ref
              .read(eventDetailProvider(event.id).notifier)
              .replace(event);
        } else {
          _ref.invalidate(eventListProvider);
        }
        _ref.invalidate(adminEventsProvider);
        return event;
      });

  /// The answer is used even if the admin left the page meanwhile.
  Future<T> _kept<T>(Future<T> Function() action) async {
    final link = _ref.keepAlive();
    try {
      return await action();
    } finally {
      link.close();
    }
  }
}

@riverpod
EventAdmin eventAdmin(Ref ref) => EventAdmin(ref);
