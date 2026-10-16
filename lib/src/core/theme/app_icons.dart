import 'package:phosphor_flutter/phosphor_flutter.dart';

// Two-tone icons (the `…Tile` ones) are drawn with PhosphorIcon
export 'package:phosphor_flutter/phosphor_flutter.dart' show PhosphorIcon;

/// Every icon of the app (Phosphor): screens use these names, never `Icons.*`,
/// so changing the pack only touches this file.
/// Regular in the UI, Fill for active states (selected tab, favorite…),
/// Duotone (`…Tile`) for a module icon on a tinted tile, with `PhosphorIcon`.
abstract final class AppIcons {
  // Tabs, Fill when selected
  static const home = PhosphorIconsRegular.house;
  static const homeActive = PhosphorIconsFill.house;
  static const reports = PhosphorIconsRegular.clipboardText;
  static const reportsActive = PhosphorIconsFill.clipboardText;
  static const hymns = PhosphorIconsRegular.musicNotes;
  static const hymnsActive = PhosphorIconsFill.musicNotes;
  static const prayer = PhosphorIconsRegular.handsPraying;
  static const prayerActive = PhosphorIconsFill.handsPraying;
  static const bible = PhosphorIconsRegular.bookBookmark;
  static const bibleActive = PhosphorIconsFill.bookBookmark;

  // Modules and settings
  static const events = PhosphorIconsRegular.calendarDots;
  static const announcements = PhosphorIconsRegular.megaphone;
  static const notifications = PhosphorIconsRegular.bell;
  static const ministry = PhosphorIconsRegular.globeHemisphereWest;
  static const journeyPlay = PhosphorIconsFill.play;
  static const journeyPause = PhosphorIconsFill.pause;
  static const region = PhosphorIconsRegular.mapPin;
  static const authorities = PhosphorIconsRegular.usersThree;
  static const admin = PhosphorIconsRegular.shieldCheck;
  static const hymnBook = PhosphorIconsRegular.bookOpenText;
  static const items = PhosphorIconsRegular.slidersHorizontal;
  static const reminder = PhosphorIconsRegular.bellRinging;
  static const goal = PhosphorIconsRegular.flag;
  static const streak = PhosphorIconsFill.flame;
  static const offline = PhosphorIconsRegular.cloudSlash;

  // Module icons on a tinted tile (home cards, Plus, empty states)
  static const hymnsTile = PhosphorIconsDuotone.musicNotes;
  static const prayerTile = PhosphorIconsDuotone.handsPraying;
  static const eventsTile = PhosphorIconsDuotone.calendarDots;
  static const announcementsTile = PhosphorIconsDuotone.megaphone;
  static const notificationsTile = PhosphorIconsDuotone.bell;
  static const ministryTile = PhosphorIconsDuotone.globeHemisphereWest;
  static const proclaimTile = PhosphorIconsDuotone.megaphone;
  static const trainTile = PhosphorIconsDuotone.bookOpenText;
  static const intercedeTile = PhosphorIconsDuotone.handsPraying;
  static const purposeTile = PhosphorIconsDuotone.compass;
  static const missionariesTile = PhosphorIconsDuotone.airplaneTilt;
  static const heroesTile = PhosphorIconsDuotone.medal;
  static const premiumTile = PhosphorIconsDuotone.crownSimple;
  static const homeWidgetTile = PhosphorIconsDuotone.squaresFour;
  static const progressTile = PhosphorIconsDuotone.chartLineUp;
  static const supportTile = PhosphorIconsDuotone.heart;
  static const authoritiesTile = PhosphorIconsDuotone.usersThree;
  static const disciplesTile = PhosphorIconsDuotone.plant;
  static const adminTile = PhosphorIconsDuotone.shieldCheck;
  static const hymnBookTile = PhosphorIconsDuotone.bookOpenText;
  static const itemsTile = PhosphorIconsDuotone.slidersHorizontal;
  static const shareTile = PhosphorIconsDuotone.export;

  // Navigation
  static const back = PhosphorIconsRegular.caretLeft;
  static const chevronLeft = PhosphorIconsRegular.caretLeft;
  static const chevronRight = PhosphorIconsRegular.caretRight;
  static const chevronDown = PhosphorIconsRegular.caretDown;
  static const expand = PhosphorIconsRegular.caretUpDown;
  static const close = PhosphorIconsRegular.x;
  static const moreOptions = PhosphorIconsRegular.dotsThreeVertical;

  // Actions
  static const add = PhosphorIconsRegular.plus;
  static const addCircle = PhosphorIconsRegular.plusCircle;
  static const remove = PhosphorIconsRegular.minus;
  static const search = PhosphorIconsRegular.magnifyingGlass;
  static const concordance = PhosphorIconsRegular.listMagnifyingGlass;
  static const share = PhosphorIconsRegular.export;
  static const verse = PhosphorIconsFill.bookOpenText;

  // Notre but: the means of the crusade, fasting and intercession
  static const mediaBooks = PhosphorIconsDuotone.bookOpenText;
  static const mediaTracts = PhosphorIconsDuotone.scroll;
  static const mediaMagazines = PhosphorIconsDuotone.newspaper;
  static const mediaCds = PhosphorIconsDuotone.disc;
  static const mediaDvds = PhosphorIconsDuotone.filmStrip;
  static const mediaRadio = PhosphorIconsDuotone.radio;
  static const mediaTv = PhosphorIconsDuotone.television;
  static const mediaInternet = PhosphorIconsDuotone.globeHemisphereWest;
  static const fasting = PhosphorIconsDuotone.forkKnife;
  static const intercession = PhosphorIconsDuotone.handsPraying;
  static const prayNow = PhosphorIconsFill.handsPraying;
  static const whatsApp = PhosphorIconsRegular.whatsappLogo;
  static const email = PhosphorIconsRegular.envelopeSimple;
  static const sendReport = PhosphorIconsRegular.paperPlaneTilt;
  static const sendReportTile = PhosphorIconsDuotone.paperPlaneTilt;
  static const settings = PhosphorIconsRegular.gearSix;
  static const copy = PhosphorIconsRegular.copy;
  static const projection = PhosphorIconsRegular.presentation;
  static const textSize = PhosphorIconsRegular.textAa;
  static const numberPad = PhosphorIconsRegular.dotsNine;
  static const erase = PhosphorIconsRegular.backspace;
  static const userAdd = PhosphorIconsRegular.userPlus;
  static const userRemove = PhosphorIconsRegular.userMinus;
  static const report = PhosphorIconsRegular.flagBanner;
  static const block = PhosphorIconsRegular.prohibit;
  static const visible = PhosphorIconsRegular.eye;
  static const hidden = PhosphorIconsRegular.eyeSlash;

  // Dates and files
  static const calendar = PhosphorIconsRegular.calendarBlank;
  static const dateRange = PhosphorIconsRegular.calendarDots;
  static const calendarCheck = PhosphorIconsRegular.calendarCheck;
  static const time = PhosphorIconsRegular.clock;
  static const pdf = PhosphorIconsRegular.filePdf;
  static const csv = PhosphorIconsRegular.fileCsv;
  static const message = PhosphorIconsRegular.chatCircleText;

  // States
  static const user = PhosphorIconsRegular.user;
  static const verified = PhosphorIconsRegular.sealCheck;
  static const check = PhosphorIconsRegular.check;
  static const checkCircle = PhosphorIconsRegular.checkCircle;
  static const checkCircleFilled = PhosphorIconsFill.checkCircle;
  static const xCircleFilled = PhosphorIconsFill.xCircle;
  static const radioOn = PhosphorIconsRegular.radioButton;
  static const radioOff = PhosphorIconsRegular.circle;
  static const star = PhosphorIconsRegular.star;
  static const starFilled = PhosphorIconsFill.star;
  static const error = PhosphorIconsRegular.warningCircle;
  static const info = PhosphorIconsRegular.info;

  // Events
  static const place = PhosphorIconsRegular.mapPin;
  static const directions = PhosphorIconsRegular.navigationArrow;
  static const addToCalendar = PhosphorIconsRegular.calendarPlus;
  static const countdown = PhosphorIconsRegular.clockCountdown;
  static const people = PhosphorIconsRegular.users;
  static const speaker = PhosphorIconsRegular.microphoneStage;
  static const lodging = PhosphorIconsRegular.bed;
  static const departure = PhosphorIconsRegular.signpost;
  static const fees = PhosphorIconsRegular.ticket;
  static const phone = PhosphorIconsRegular.phone;
  static const pinned = PhosphorIconsFill.pushPin;
  static const pin = PhosphorIconsRegular.pushPin;
  static const image = PhosphorIconsRegular.image;
  static const camera = PhosphorIconsRegular.camera;
  static const imageBroken = PhosphorIconsRegular.imageBroken;
  static const photos = PhosphorIconsRegular.images;
  static const hymn = PhosphorIconsRegular.musicNote;
  static const edit = PhosphorIconsRegular.pencilSimple;
  static const delete = PhosphorIconsRegular.trash;
  static const download = PhosphorIconsRegular.downloadSimple;
  static const arrowRight = PhosphorIconsRegular.arrowRight;

  // Prayer: the four retreats, the guided minute, topics and lists
  static const retreatMorning = PhosphorIconsFill.sunHorizon;
  static const retreatNoon = PhosphorIconsFill.sun;
  static const retreatEvening = PhosphorIconsFill.cloudSun;
  static const retreatNight = PhosphorIconsFill.moonStars;
  static const play = PhosphorIconsFill.play;
  static const pause = PhosphorIconsFill.pause;
  static const previous = PhosphorIconsFill.skipBack;
  static const next = PhosphorIconsFill.skipForward;
  static const soundOn = PhosphorIconsRegular.speakerHigh;
  static const soundOff = PhosphorIconsRegular.speakerSlash;
  static const done = PhosphorIconsFill.checkFat;
  static const private = PhosphorIconsRegular.lockSimple;
  static const premiumLock = PhosphorIconsFill.lockSimple;
  static const answeredTile = PhosphorIconsDuotone.sparkle;
  static const importunityGoal = PhosphorIconsRegular.target;
  static const churchTile = PhosphorIconsDuotone.church;
  static const nationsTile = PhosphorIconsDuotone.globeHemisphereEast;
  static const sickTile = PhosphorIconsDuotone.handHeart;
  static const fastingTile = PhosphorIconsDuotone.hourglassMedium;
  static const listsTile = PhosphorIconsDuotone.userList;

  // Bible: the reader, the marks, the offline copy
  static const bibleTile = PhosphorIconsDuotone.bookBookmark;
  static const highlight = PhosphorIconsRegular.highlighter;
  static const bookmark = PhosphorIconsRegular.bookmarkSimple;
  static const bookmarkFilled = PhosphorIconsFill.bookmarkSimple;
  static const bookmarksTile = PhosphorIconsDuotone.bookmarksSimple;
  static const downloadOffline = PhosphorIconsRegular.cloudArrowDown;
  static const downloaded = PhosphorIconsRegular.cloudCheck;
  static const chapters = PhosphorIconsRegular.listNumbers;
  static const bibleVersion = PhosphorIconsRegular.translate;
}
