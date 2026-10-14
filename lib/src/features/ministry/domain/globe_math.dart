import 'dart:math' as math;

/// A point of the unit sphere: x to the right, y up, z towards the viewer
/// once turned.
typedef SpherePoint = ({double x, double y, double z});

/// Latitude and longitude (degrees) on the unit sphere, before any turn:
/// longitude 0 faces the viewer.
SpherePoint spherePoint(double latitude, double longitude) {
  final lat = latitude * math.pi / 180;
  final lon = longitude * math.pi / 180;
  return (
    x: math.cos(lat) * math.sin(lon),
    y: math.sin(lat),
    z: math.cos(lat) * math.cos(lon),
  );
}

/// How the globe is turned: [longitude] and [latitude] (degrees) of the point
/// in the middle of the disc.
typedef GlobeView = ({double latitude, double longitude});

/// [point] as seen with [view]: z > 0 on the visible face.
SpherePoint turned(SpherePoint point, GlobeView view) {
  final lon = -view.longitude * math.pi / 180;
  final lat = view.latitude * math.pi / 180;
  // around the vertical axis (longitude), then the horizontal one (latitude)
  final x1 = point.x * math.cos(lon) + point.z * math.sin(lon);
  final z1 = -point.x * math.sin(lon) + point.z * math.cos(lon);
  final y2 = point.y * math.cos(lat) - z1 * math.sin(lat);
  final z2 = point.y * math.sin(lat) + z1 * math.cos(lat);
  return (x: x1, y: y2, z: z2);
}

/// The point between [a] and [b] at [t] (0 to 1) on the shortest arc
/// (spherical interpolation), lifted by [height] in the middle: the arcs that
/// go from Yaoundé to the nations.
SpherePoint arcPoint(SpherePoint a, SpherePoint b, double t, double height) {
  final dot = (a.x * b.x + a.y * b.y + a.z * b.z).clamp(-1.0, 1.0);
  final angle = math.acos(dot);
  final double wa;
  final double wb;
  if (angle < 1e-6) {
    wa = 1 - t;
    wb = t;
  } else {
    wa = math.sin((1 - t) * angle) / math.sin(angle);
    wb = math.sin(t * angle) / math.sin(angle);
  }
  final lift = 1 + height * math.sin(math.pi * t) * angle / math.pi;
  return (
    x: (a.x * wa + b.x * wb) * lift,
    y: (a.y * wa + b.y * wb) * lift,
    z: (a.z * wa + b.z * wb) * lift,
  );
}

/// The turn that brings ([latitude], [longitude]) to the middle of the disc;
/// the globe never tips over the poles.
GlobeView viewOn(double latitude, double longitude) =>
    (latitude: latitude.clamp(-60.0, 60.0), longitude: longitude);

/// From [from] to [to] by the short way round: the longitudes differ by 180°
/// at most (350° → 10° turns by 20°, not 340°).
GlobeView shortestTarget(GlobeView from, GlobeView to) {
  var delta = (to.longitude - from.longitude) % 360;
  if (delta > 180) {
    delta -= 360;
  }
  return (latitude: to.latitude, longitude: from.longitude + delta);
}
