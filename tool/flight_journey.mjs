// The verses of « La conquête de Canaan », the journey of « Verset en vol »
// (features/games, domain/flight_journey.dart): one verse per stage, from
// Egypt to Canaan, in the seven languages of the app. Written to
// assets/games/journey_canaan.json.
//
//   node tool/flight_journey.mjs
//
// The texts come from the Free Use Bible API (bible.helloao.org), in the
// Bibles of the app for each language (the ones of the verse of the day).
// The stages and their order are in `stages` below, the same as
// `canaanStages` in the Dart code: keep both in step.

import { writeFileSync, mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const stages = [
  'EXO.2.24', // Egypt: God hears
  'EXO.12.51', // the way out
  'EXO.14.14', // the Red Sea
  'EXO.15.27', // Elim
  'EXO.17.15', // Rephidim
  'EXO.20.2', // Sinai
  'EXO.40.34', // the tabernacle
  'NUM.14.8', // Kadesh
  'DEU.6.5', // the plains of Moab
  'JOS.3.5', // the Jordan
  'JOS.6.2', // Jericho
  'JOS.21.45', // Canaan
];

// language → its Bible in the API, how it is credited, the names of the
// books and how a reference is written (as in assets/verses)
const languages = {
  fr: {
    bible: 'fra_lsg',
    source: 'Louis Segond 1910',
    books: { EXO: 'Exode', NUM: 'Nombres', DEU: 'Deutéronome', JOS: 'Josué' },
    separator: '.',
  },
  en: {
    bible: 'ENGWEBP',
    source: 'World English Bible',
    books: { EXO: 'Exodus', NUM: 'Numbers', DEU: 'Deuteronomy', JOS: 'Joshua' },
    separator: ':',
  },
  de: {
    bible: 'deu_l12',
    source: 'Lutherbibel 1912',
    books: { EXO: '2. Mose', NUM: '4. Mose', DEU: '5. Mose', JOS: 'Josua' },
    separator: ',',
  },
  es: {
    bible: 'spa_r09',
    source: 'Reina-Valera 1909',
    books: { EXO: 'Éxodo', NUM: 'Números', DEU: 'Deuteronomio', JOS: 'Josué' },
    separator: ':',
  },
  ar: {
    bible: 'arb_vdv',
    source: 'ترجمة فاندايك',
    books: { EXO: 'الخروج', NUM: 'العدد', DEU: 'التثنية', JOS: 'يشوع' },
    separator: ':',
  },
  zh: {
    bible: 'cmn_cu1',
    source: '和合本',
    books: { EXO: '出埃及记', NUM: '民数记', DEU: '申命记', JOS: '约书亚记' },
    separator: ':',
  },
  hi: {
    bible: 'HINIRV',
    source:
      'Indian Revised Version, © 2017–2019 Bridge Connectivity Solutions, CC BY-SA 4.0',
    books: { EXO: 'निर्गमन', NUM: 'गिनती', DEU: 'व्यवस्थाविवरण', JOS: 'यहोशू' },
    separator: ':',
  },
};

// a typing mistake of the digital text, put right: « wird », not « wir »
const corrections = {
  'de:JOS.3.5': [['morgen wir der HERR', 'morgen wird der HERR']],
};

const chapters = new Map();

async function chapter(bible, book, number) {
  const key = `${bible}/${book}/${number}`;
  if (!chapters.has(key)) {
    const response = await fetch(`https://bible.helloao.org/api/${key}.json`);
    if (!response.ok) {
      throw new Error(`${key}: ${response.status}`);
    }
    chapters.set(key, await response.json());
  }
  return chapters.get(key);
}

/// The pairs of quotation marks: one left alone (the verse is a piece of a
/// longer speech) is taken away.
const quotes = [
  ['“', '”'],
  ['«', '»'],
  ['「', '」'],
  ['『', '』'],
];

function tidy(text, language) {
  let clean = text.replace(/\s+/g, ' ').trim();
  // the cross-references of the Hindi Bible: « (मत्ती 22:37, लूका 10:27) »
  clean = clean.replace(/\s*\([^()]*\d[^()]*\)\s*$/u, '').trim();
  clean = clean.replace(/\s*।;$/u, '।');
  for (const [open, close] of quotes) {
    const opened = clean.split(open).length - 1;
    const closed = clean.split(close).length - 1;
    if (opened !== closed) {
      clean = clean.replaceAll(open, '').replaceAll(close, '');
    }
  }
  // an opening single quote alone (the closing one is also the apostrophe)
  clean = clean
    .replace(/^[‘『]/u, '')
    .replace(/\s+([.,;:!?。，’”»」』])/gu, '$1');
  if (language !== 'fr') {
    // a verse that stops in the middle of a sentence ends with a full stop
    const stop = { zh: '。', hi: '।' }[language] ?? '.';
    clean = clean.replace(/[;:,，；：]$/u, stop);
  }
  return clean.replace(/\s+/g, ' ').trim();
}

function textOf(content, language) {
  const parts = [];
  for (const piece of content) {
    if (typeof piece === 'string') {
      parts.push(piece);
    } else if (piece && typeof piece.text === 'string') {
      parts.push(piece.text);
    }
  }
  return parts
    .map((part) => part.trim())
    .filter((part) => part)
    .join(language === 'zh' ? '' : ' ');
}

const out = {};
for (const [language, config] of Object.entries(languages)) {
  const verses = [];
  for (const osis of stages) {
    const [book, number, verse] = osis.split('.');
    const data = await chapter(config.bible, book, number);
    const found = data.chapter.content.find(
      (item) => item.type === 'verse' && item.number === Number(verse),
    );
    if (!found) {
      throw new Error(`${language} ${osis}: no such verse`);
    }
    let text = tidy(textOf(found.content, language), language);
    for (const [wrong, right] of corrections[`${language}:${osis}`] ?? []) {
      if (!text.includes(wrong)) {
        throw new Error(`${language} ${osis}: « ${wrong} » is no longer there`);
      }
      text = text.replace(wrong, right);
    }
    verses.push({
      osis,
      ref: `${config.books[book]} ${number}${config.separator}${verse}`,
      text,
    });
  }
  out[language] = { source: config.source, verses };
}

const file = join(
  dirname(fileURLToPath(import.meta.url)),
  '..',
  'assets',
  'games',
  'journey_canaan.json',
);
mkdirSync(dirname(file), { recursive: true });
writeFileSync(file, `${JSON.stringify(out, null, 1)}\n`);
console.log(`${stages.length} stages × ${Object.keys(out).length} languages → ${file}`);
