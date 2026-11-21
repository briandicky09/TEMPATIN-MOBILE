# TEMPATIN MOBILE — Hybrid Design System Specification

> Preserves TEMPATIN's **"Warm Paper Notebook"** visual identity (`DESIGN.md` & `public/assets/css/tempatin.css`) while adapting layout, typography, touch targets, and navigation for native Android & iOS usability.

---

## 1. Design Philosophy

- **Warm & Editorial, Never Clinical**: Canvas is warm paper (`#f6f5f4`), elevated surfaces are pure white (`#ffffff`) separated by crisp `1px` hairline borders (`rgba(0,0,0,0.08)`) instead of heavy drop shadows.
- **Single Chromatic Anchor**: `#0075de` (TEMPATIN Blue) is reserved strictly for the primary action per screen and active navigation indicators. Secondary actions use soft Sky Tint (`#e6f3fe`) or neutral outlines.
- **Zero Gradients & Zero Clutter**: Flat surfaces, restrained micro-interactions (200ms ease), generous breathing room, and clear visual hierarchy built through ink alpha rather than noisy color palettes.
- **Native Mobile Ergonomics**: Minimum `48x48dp` touch targets, bottom navigation bars, modal bottom sheets for filters/forms, pull-to-refresh, sticky bottom CTA bars on detail/booking screens, and explicit loading/empty/error states.

---

## 2. Color Tokens (`AppColors`)

| Token Name | Hex / Value | Role & Usage |
| :--- | :--- | :--- |
| `primary` | `#0075DE` | Primary CTA fill, active nav tab, active filter chip, links |
| `primaryPressed` | `#0066C4` | Pressed/hover state for primary CTA |
| `primaryTint` (`skyTint`) | `#E6F3FE` | Secondary ghost CTA fill, info badge bg, selected chip bg |
| `canvas` (`paperWarmth`) | `#F6F5F4` | Default `Scaffold.backgroundColor` across all screens |
| `surface` (`pureWhite`) | `#FFFFFF` | Cards, bottom sheets, text fields, bottom nav bar |
| `surfaceDark` | `#191919` | Rare dark contrast cards / snackbars (matches `tempatin.css`) |
| `inkPrimary` | `#000000` | Headings, primary titles, prices |
| `inkCharcoal` | `#111111` | High-contrast body text |
| `inkBody` (`graphite`) | `#615D59` | Warm body copy, descriptions |
| `inkSecondary` (`stone`) | `#757575` | Captions, metadata, inactive nav icons, helper text |
| `inkMuted` | `rgba(0,0,0,0.40)` | Placeholders, disabled labels |
| `borderHairline` | `rgba(0,0,0,0.08)` | Default `1px` border on all cards, inputs, dividers |
| `borderStrong` | `rgba(0,0,0,0.16)` | Focused neutral border, outlined buttons |
| `successBg` / `successText` | `#EDF7EE` / `#166534` | `active`, `confirmed`, `paid`, `available`, `resolved` |
| `warningBg` / `warningText` | `#FEF9C3` / `#854D0E` | `pending`, `in_progress`, `maintenance`, `draft` |
| `dangerBg` / `dangerText` | `#FEE2E2` / `#991B1B` | `rejected`, `cancelled`, `failed`, `expired`, `occupied` |
| `infoBg` / `infoText` | `#E6F3FE` / `#0054A3` | `approved`, `completed`, verified badges |
| `neutralBg` / `neutralText` | `#F1F1EF` / `#37352F` | `inactive`, default category tags |
| `accentMarigold` | `#FFB110` | Star ratings, featured highlight accents |
| `accentCoral` | `#F64932` | Favorite heart active fill, unread notification dot |

---

## 3. Typography (`AppTypography`)

- **Primary Font**: **Inter** (via `google_fonts` or bundled `.ttf` assets in `assets/fonts/Inter-*` for offline reliability) — weights `400`, `500`, `600`, `700`.
- **Editorial Accent Font** *(optional, used sparingly on Hero/Empty-state subheads)*: **Source Serif 4** (`400`), matching `tempatin.css`.
- **Mobile-Adapted Type Scale** (scaled down from desktop `72px/96px` display sizes for 360–430dp screens):

| Token | Size | Weight | Line Height | Letter Spacing | Usage |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `displaySm` | `28sp` | `700` | `1.18` | `-0.8px` | Onboarding / Hero headline |
| `headingLg` | `22sp` | `700` | `1.25` | `-0.4px` | Screen titles, Kos detail title |
| `headingMd` | `18sp` | `600` | `1.30` | `-0.2px` | Section headers, modal sheet titles |
| `headingSm` | `16sp` | `600` | `1.35` | `-0.1px` | Card titles, price highlights |
| `body` | `15sp` | `400` | `1.50` | `0` | Standard body text, descriptions |
| `bodySm` | `14sp` | `400` | `1.43` | `0` | Card metadata, list subtitles |
| `label` | `14sp` | `500` | `1.20` | `0` | Buttons, form labels, tabs |
| `caption` | `12sp` | `500` | `1.33` | `+0.1px` | Status pills, timestamps, bottom nav labels |

---

## 4. Spacing, Radii & Elevation

- **Base Grid**: `4dp` (`4, 8, 12, 16, 20, 24, 32`).
- **Screen Horizontal Padding**: `16dp` standard (`20dp` on auth/forms).
- **Card Padding**: `16dp` (adapted from `24px` desktop for mobile density).
- **Section Vertical Gap**: `24dp` (`12dp` between stacked cards).
- **Border Radius (`AppRadii`)**:
  - `small`: `4dp` (compact inline tags)
  - `button` / `input`: `8dp` (buttons, text fields, thumbnails)
  - `card`: `12dp` (all content cards, bottom sheet top corners `16dp`)
  - `pill`: `9999dp` (status badges, filter chips, avatars)
- **Elevation**:
  - Content cards: **`elevation: 0`**, `1px` `borderHairline`.
  - Sticky AppBar / BottomNav / Sticky Bottom CTA Bar: subtle `1px` top/bottom hairline border + optional ultra-soft shadow (`rgba(0,0,0,0.04)`, blur `8dp`, offset `(0, -2)`).

---

## 5. Core Reusable Flutter Components (`lib/core/widgets/`)

1. **`TempatinButton`**: Variants `primary` (`#0075DE` fill, `#FFFFFF` text), `secondary` (`#E6F3FE` fill, `#0075DE` text), `outlined` (transparent, `borderStrong`), `ghost` (text-only), `danger` (`#FEE2E2` fill, `#991B1B` text). Height `48dp`, radius `8dp`, built-in loading spinner state.
2. **`TempatinCard`**: White `#FFFFFF` container, radius `12dp`, `1px` `borderHairline`, `elevation: 0`, optional `onTap` InkWell.
3. **`StatusBadge`**: Pill (`9999dp`), `12sp` medium, semantic bg/text pairs + hairline border, mapping directly to backend status enums (`Booking`, `Invoice`, `Payment`, `Room`, `Survey`, `Maintenance`, `Contract`, `Kos`).
4. **`KosCard`**: Two layouts — **Vertical Card** (for Home horizontal carousels & grids) and **Compact List Card** (for Explore & Favorites): 16:10 rounded image with `CachedNetworkImage`, type pill (`Putra/Putri/Campur/Eksklusif`), favorite heart toggle, title, city, star rating + review count, and bold IDR/bulan price.
5. **`TempatinTextField`**: White surface, `8dp` radius, `1px` `borderHairline` (turns `#0075DE` on focus, `#991B1B` on error), clear inline validation error text.
6. **`AppEmptyState` & `AppErrorState`**: Centered minimalist icon/illustration on warm canvas, concise Indonesian title & helper text, and single primary retry/action button.
7. **`KosCardSkeleton` / `ListSkeleton`**: Subtle warm-gray shimmer placeholders (`#ECEAE7` -> `#F6F5F4`) matching exact card geometry.
8. **`AppBottomSheet`**: Standard draggable modal sheet (`#FFFFFF`, top radius `16dp`, grab handle) for Filters, Review submission, Survey scheduling, and Owner status actions.

---

## 6. Brand Assets & Iconography Strategy

- **Migrated Brand Assets** (copied from `TEMPATIN/public/assets/img/` into `assets/images/` during Phase 4):
  - `logo.png` (wordmark for Splash, Auth, AppBar)
  - `logo-symbol.png` (app launcher icon & compact avatar fallback)
  - `city-skyline.svg` (subtle hero/onboarding architectural accent)
- **Iconography**: Replace the web's mixed FontAwesome 5 + Iconify Lucide setup with a **single consistent icon family**: **`lucide_icons_flutter`** (clean 1.75px stroke geometric icons that match Notion's editorial aesthetic far better than heavy FontAwesome solids).
- **Language & Formatting**:
  - Primary UI language: **Bahasa Indonesia** (matching existing TEMPATIN web copy, status labels, and legal contract templates).
  - Currency: `Rp 850.000` (dot thousands separator, `/ bulan`).
  - Dates: `dd MMM yyyy` (`id_ID` locale via `intl`).
