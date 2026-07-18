#!/usr/bin/env node
// Content audit — adapted from Uncle Nobody's audit.ts pattern (same hard/soft
// distinction, same em-dash/banned-phrase mechanics), rewritten for this site's
// plain-JS/Eleventy stack instead of TypeScript/Next.js, and with Uncle Nobody's
// finance-specific rules (disclaimer, pillar links, YMYL citations) stripped out
// in favor of the one check that matters for THIS site's business model:
// every template page must actually have a download CTA, not just copy.

const fs = require("fs");
const path = require("path");

const CONFIG = JSON.parse(fs.readFileSync(path.join(__dirname, "..", "audit.config.json"), "utf8"));
const SRC_DIR = path.join(__dirname, "..", "src");
const EXCLUDE_DIRS = new Set([...CONFIG.excludeDirs, "_includes", "_data"]);

let hardFailures = [];
let softWarnings = [];

function walk(dir) {
  const entries = fs.readdirSync(dir, { withFileTypes: true });
  let files = [];
  for (const entry of entries) {
    if (entry.isDirectory()) {
      if (EXCLUDE_DIRS.has(entry.name)) continue;
      files = files.concat(walk(path.join(dir, entry.name)));
    } else if (CONFIG.contentFileExts.some((ext) => entry.name.endsWith(ext))) {
      files.push(path.join(dir, entry.name));
    }
  }
  return files;
}

function checkFile(filePath) {
  const rel = path.relative(path.join(__dirname, ".."), filePath);
  const content = fs.readFileSync(filePath, "utf8");

  // em dashes — hard, matches Uncle Nobody's rule exactly
  if (CONFIG.checks.emDashes === "hard" && /—/.test(content)) {
    hardFailures.push(`${rel}: contains an em dash (—)`);
  }

  // hard banned phrases
  for (const phrase of CONFIG.hardBannedPhrases) {
    if (content.toLowerCase().includes(phrase.toLowerCase())) {
      hardFailures.push(`${rel}: contains banned phrase "${phrase}"`);
    }
  }

  // soft banned phrase regexes
  for (const rule of CONFIG.softBannedPhraseRegexes) {
    const re = new RegExp(rule.pattern, rule.flags);
    if (re.test(content)) {
      softWarnings.push(`${rel}: ${rule.label}`);
    }
  }

  // Only apply page-level checks (title/meta/H1/schema/CTA) to actual page files,
  // i.e. ones with front matter — skip partials/macros that don't have it, and skip
  // utility templates (sitemap.xml, etc.) marked eleventyExcludeFromCollections,
  // since those aren't real pages with title/meta/H1 to check.
  const frontMatterMatch = content.match(/^---\n([\s\S]*?)\n---/);
  if (!frontMatterMatch) return;
  const frontMatter = frontMatterMatch[1];
  if (/^eleventyExcludeFromCollections:\s*true/m.test(frontMatter)) return;

  const titleMatch = frontMatter.match(/^title:\s*"(.*)"/m);
  const descMatch = frontMatter.match(/^description:\s*"(.*)"/m);

  if (CONFIG.checks.titlePresence === "hard" && !titleMatch) {
    hardFailures.push(`${rel}: missing title in front matter`);
  }
  if (CONFIG.checks.metaPresence === "hard" && !descMatch) {
    hardFailures.push(`${rel}: missing description in front matter`);
  }
  if (titleMatch && CONFIG.checks.titleLength === "soft") {
    const len = titleMatch[1].length;
    if (len > CONFIG.titleMaxChars) {
      softWarnings.push(`${rel}: title is ${len} chars (max ${CONFIG.titleMaxChars})`);
    }
  }
  if (descMatch && CONFIG.checks.metaLength === "soft") {
    const len = descMatch[1].length;
    if (len > CONFIG.metaMaxChars || len < CONFIG.metaMinChars) {
      softWarnings.push(`${rel}: description is ${len} chars (want ${CONFIG.metaMinChars}-${CONFIG.metaMaxChars})`);
    }
  }

  const body = content.slice(frontMatterMatch[0].length);

  if (CONFIG.checks.singleH1 === "hard") {
    const h1Count = (body.match(/<h1[\s>]/g) || []).length;
    if (h1Count !== 1) {
      hardFailures.push(`${rel}: has ${h1Count} <h1> tags (must be exactly 1)`);
    }
  }

  if (CONFIG.checks.jsonLdSchema === "soft" && !/^schema:/m.test(frontMatter)) {
    softWarnings.push(`${rel}: no schema block in front matter`);
  }

  // Site-specific hard check: template pages (under src/templates/) must have
  // an actual download CTA, not just descriptive copy about the template.
  if (CONFIG.checks.downloadCtaPresent === "hard" && filePath.includes(`${path.sep}templates${path.sep}`)) {
    if (!/download-block/.test(body)) {
      hardFailures.push(`${rel}: template page has no .download-block (no actual CTA)`);
    }
  }

  if (CONFIG.checks.noInternalNofollow === "hard" && /href="\/[^"]*"[^>]*rel="[^"]*nofollow/.test(body)) {
    hardFailures.push(`${rel}: internal link has rel="nofollow" (should never nofollow our own pages)`);
  }
}

const files = walk(SRC_DIR);
files.forEach(checkFile);

console.log(`Audited ${files.length} files.`);

if (softWarnings.length) {
  console.log(`\n${softWarnings.length} SOFT warning(s):`);
  softWarnings.forEach((w) => console.log(`  ⚠ ${w}`));
}

if (hardFailures.length) {
  console.log(`\n${hardFailures.length} HARD failure(s):`);
  hardFailures.forEach((f) => console.log(`  ✗ ${f}`));
  console.log("\nAudit FAILED — commit blocked.");
  process.exit(1);
}

console.log("\nAudit passed" + (softWarnings.length ? " (with soft warnings above)." : "."));
