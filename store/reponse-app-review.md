# Réponse à App Review (première soumission, 26/10/2026)

À coller dans App Store Connect › App Review › répondre au message, en joignant la vidéo,
puis à recopier dans « Informations pour l'examen › Notes ». Remplacer les `[…]` avant l'envoi.

```text
Hello, and thank you for reviewing CMFI Connect. Here is the information you asked for.

1. SCREEN RECORDING
Attached: a recording made on an iPhone [modèle] running iOS [version], with TestFlight build 1.0.0 ([numéro de build]). It starts with launching the app and shows account creation, sign-in, the daily report, hymns, prayer, events, reporting and blocking a member, and account deletion.

2. PURPOSE AND AUDIENCE
CMFI Connect is the app of the Christian Missionary Fellowship International (CMFI), a Christian missionary community present in 154 nations. It is for its members and for any Christian who wants a simple daily routine with God.
The problem it solves: members kept their daily spiritual report (Bible reading, prayer time, fasting) on paper and sent it by hand to the leaders who accompany them, and the hymn books existed only in print. The app lets a member fill in the day in a minute, follow their progress, send a weekly or monthly report to the leaders they choose, read the hymn books offline, pray with guided 15-minute retreats and follow community events.
Anyone can create an account: the app is open to the public, not limited to a company or its employees.

3. SETUP AND ACCESS
No setup or sample file is needed.
Demo account (member, with data on several days):
- Phone: [numéro de démo] (type the full number with its "+": the country selector switches by itself)
- Password: [mot de passe de démo]
New account: "Create an account" on the welcome screen (phone number, name, password).
Main features (bottom tabs):
- Home: today's report, goals ring, upcoming events.
- Report: Today, History, Summary.
- Hymns: hymn books available offline, search, projection mode.
- Prayer: 15-minute retreats, prayer topics, prayer lists.
- More: spiritual leaders, "Send to my authorities", events, Our ministry, settings, sign out, delete account.
Account deletion: More > bottom of the page > "Delete my account" > confirm with the password. The account and its data are deleted at once.
Report and block: an invitation from another member to pray for a topic (Prayer tab) has a menu with "Report" (reason and comment, sent to the community administrators, who handle reports in their back office) and "Block". Blocked members can be unblocked in More > "Blocked members".
In-app purchases: none in this version; every feature is free. Some in-person events (conferences, retreats) have a registration fee paid by mobile money: it is a real-world service used outside the app (guideline 3.1.3(e)) and unlocks no content in the app.

4. EXTERNAL SERVICES
- Our own API, hosted on Render; PostgreSQL database on Neon; images on object storage (media.cmfi-connect.com).
- Firebase (Google): Cloud Messaging (announcements), Crashlytics (crash reports), Remote Config.
- Free Use Bible API (bible.helloao.org): public-domain Bible translations (Louis Segond 1910, King James Version, World English Bible…).
- Bibleserver (bibleserver.com): opened in the browser for La Bible du Semeur, which the app neither stores nor displays.
- KPay: mobile money payment of paid in-person event registrations.
- RevenueCat: SDK included for future subscriptions; nothing is sold in this version.
No AI service, no advertising, no third-party sign-in.

5. REGIONAL DIFFERENCES
The app works the same way in every region. The interface follows the device language (7 languages). Only the mobile money payment of paid events depends on the operators available in the event's country.

6. THIRD-PARTY MATERIAL
- The hymn books (Christ the Victor, Christ est vainqueur, Rendons ministère au Seigneur, Chants d'édification) are published by CMFI, which provides them for this app. Authorization letter attached.
- The Bible texts shown in the app are public-domain translations; a copyrighted translation is only opened on the website its publisher allows.
- The app does not operate in a regulated industry.

Contact during review: [nom], [e-mail], [téléphone]
```
