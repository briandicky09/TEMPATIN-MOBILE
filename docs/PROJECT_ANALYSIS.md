# TEMPATIN MOBILE — Project Analysis & Technical Audit

> **Phase 1 Discovery Report** | Reference Source: `C:\Users\Thinkpad\Downloads\TEMPATIN` | Target Workspace: `C:\Users\Thinkpad\Downloads\TEMPATIN MOBILE`

---

## 1. Executive Summary

**TEMPATIN** is a Laravel 12 boarding-house (*kos*) marketplace and property management web platform supporting three user roles: **Customer / Member**, **Property Owner**, and **Superadmin**.

Direct inspection of the reference codebase (`composer.json`, `bootstrap/app.php`, `routes/web.php`, 17 controllers, 15 Eloquent models, 26 migrations, 2 policies, 5 FormRequests, `MidtransService`, `TempatinNotification`, and Blade/CSS views) confirms that the business domain is rich and largely functional on the web, **but the backend is currently 100% session-based Blade MVC with zero REST API layer**.

### Key Readiness Findings
1. **No REST API Layer Yet**: `laravel/sanctum` is not installed, `routes/api.php` does not exist, `User` does not use `HasApiTokens`, and `config/cors.php` is not published.
2. **Database & Runtime**: Local `.env` runs on `DB_CONNECTION=sqlite` (`database/database.sqlite`), while production targets MySQL. Several migrations contain SQLite-specific workarounds that dropped a `UNIQUE` index (`users.google_id`) and a foreign key (`bookings.room_id`) on SQLite.
3. **Documentation vs. Code Drift**: The existing `PROJECT_CONTEXT.md` describes several columns and features (e.g., `rental_contracts.deposit_amount`, `maintenance_reports.priority`, `facilities.icon/category`, `kos.status = 'pending'`, `KTR-` prefix) that **do not exist** in the actual database migrations or models. All mobile architecture and API contracts must follow the verified source code.
4. **Critical Backend Bugs Identified**: The audit uncovered 8 concrete bugs/security gaps in the existing Laravel controllers and `MidtransService` (detailed in Section 5) that must be fixed when introducing the `feature/mobile-api` backend branch.
5. **Local Development Environment**: `git` (`2.53.0`) is installed, but **`flutter` and `dart` SDKs are not currently available in the system `PATH`**. Installing the Flutter SDK (plus Android SDK / emulator) is a prerequisite before Phase 4.

---

## 2. Reference Laravel 12 Architecture Audit

### 2.1 Tech Stack (Verified from `composer.json`)
| Layer | Package / Tool | Version / Notes |
| :--- | :--- | :--- |
| Runtime & Framework | PHP `^8.2`, `laravel/framework` | `^12.0` |
| Payment Gateway | `midtrans/midtrans-php` | `^2.6` (loaded via local path repo `packages/midtrans-php`) |
| PDF Generation | `barryvdh/laravel-dompdf` | `^3.1` (Nota Pembayaran & Kontrak Sewa Digital) |
| Social OAuth | `laravel/socialite` | `^5.31` (Google OAuth web redirect flow) |
| Testing | `phpunit/phpunit` | `^11.0.1` |
| Frontend (Web) | Bootstrap 4 + FontAwesome 5 + `tempatin.css` | Custom Notion-inspired CSS (3,727 lines), jQuery, Owl Carousel, GSAP, Leaflet 1.9.4 + OSM |
| API Auth (Sanctum) | **Not Installed** | Required for Phase 6 (`laravel/sanctum`) |

### 2.2 Application Structure (`app/`)
- **17 Controllers (`app/Http/Controllers/`)**:
  - Auth: `AuthController`, `GoogleAuthController`, `PasswordResetController`
  - Public / Discovery: `HomeController`, `KosController`
  - Customer / Member: `MemberController`, `CustomerKosController` (legacy routes `/customer/*`)
  - Owner: `OwnerKosController`, `OwnerRoomController`, `OwnerBookingController`
  - Shared Transactional / Engagement: `SurveyController`, `MaintenanceReportController`, `ChatController`, `RentalContractController`
  - Webhook & Admin: `MidtransNotificationController`, `AdminController`
- **Middleware**: `EnsureUserHasRole` (aliased as `role` in `bootstrap/app.php`), returning web redirects (`route('login')`) or `403` HTML aborts.
- **Policies**: `KosPolicy` (actively used in `OwnerKosController`, `StoreKosRequest`, `UpdateKosRequest`) and `BookingPolicy` (**defined but never invoked**; controllers use inline IDOR checks instead).
- **FormRequests (5)**: `LoginRequest`, `RegisterRequest`, `StoreBookingRequest`, `StoreKosRequest`, `UpdateKosRequest`. Other controllers use inline `$request->validate(...)`.
- **Services (1)**: `MidtransService` (Snap transaction creation + webhook signature/amount verification).
- **Notifications (1)**: `TempatinNotification` (`database` channel only; stores `title`, `message`, `action_url` as web URL, `category`, `icon`, `created_at`).

### 2.3 File Storage & Asset Path Inconsistency
All uploads write to Laravel's `public` disk (`storage/app/public`, symlinked to `public/storage`), **but path prefixes stored in the database are inconsistent**:
- `kos.thumbnail`: Uploaded thumbnails store `'storage/kos/...'`, whereas seeded/default thumbnails store `'assets/img/kos/1.png'`.
- `kos_photos.photo_path`: Stores `'kos/photos/...'` (no `'storage/'` prefix; resolved via `KosPhoto::getUrlAttribute()`).
- `users.avatar`: Stores `'avatars/...'` (no `'storage/'` prefix).
- `maintenance_reports.photo`: Stores `'maintenance/...'` (no `'storage/'` prefix).
- **Mobile Impact**: The Laravel API Resource layer **must** normalize every image path into a full absolute URL (`https://.../storage/...` or `https://.../assets/...`) so the Flutter app never has to guess path prefixes.

---

## 3. User Roles & Access Control Matrix

| Role (`users.role`) | Web Prefixes | Core Capabilities | Mobile App Priority |
| :--- | :--- | :--- | :--- |
| **Guest** | `/`, `/kos`, `/login`, `/register` | Browse/search/filter active kos, view details/map/reviews, toggle session favorites (web), register/login. | **Core (Phase 5)** |
| **Customer (`customer`)** | `/member/*`, `/customer/*` (legacy), `/kontrak/*`, `/pesan/*` | Favorites (DB), room booking, Midtrans payment, invoices & Nota PDF, digital contract signing & PDF, survey scheduling, maintenance tickets, internal chat, verified reviews, notifications, profile management. | **Core (Phases 5–7, 9)** |
| **Property Owner (`owner`)** | `/owner/*`, `/pesan/*`, `/kontrak/*` | Dashboard KPIs, property CRUD + photos + map pin picker, individual room inventory, booking approve/reject/check-in/check-out, active tenant directory, survey management, maintenance ticket resolution, review replies, revenue & occupancy analytics, chat, notifications. | **Core (Phases 8–9)** |
| **Superadmin (`admin`)** | `/admin/*` | Platform KPI dashboard, kos status moderation (`active`/`inactive`), user directory, global booking audit log, review moderation/deletion. | **Secondary / Web-First** (API contract designed; optional lightweight mobile module in Phase 9+) |

---

## 4. Discrepancies Found Between Existing Docs and Actual Code

To strictly uphold *"Never assume a feature exists without verifying its implementation"*, the following gaps between `TEMPATIN/PROJECT_CONTEXT.md` and actual source code are documented:

| Area | Claimed in `PROJECT_CONTEXT.md` | Actual Verified Implementation |
| :--- | :--- | :--- |
| **Contract Prefix & Columns** | `KTR-`, `tenant_id`, `owner_id`, `deposit_amount`, `tenant_signature`, `owner_signature` | Prefix is **`CTR-YYYYMM-XXXXX`**. Columns are only `booking_id`, `contract_number`, `terms`, `signed_at`, `signer_ip`, `status` (`draft`, `active`, `completed`). Signing is checkbox consent (`agree: accepted`), not a drawn signature image. |
| **Maintenance Reports** | `priority` (`low..urgent`), `resolution_notes`, default status `pending` | **No `priority` column.** Uses `owner_notes` and default status **`open`** (`open`, `in_progress`, `resolved`, `rejected`). Requires `booking_id`. |
| **Rooms Table** | `price`, `description` | Uses **`price_override`** (nullable, currently ignored during booking price calculation) and **`notes`**, plus `room_type`. |
| **Facilities Table** | `icon`, `category` | Only **`id`, `name`, `slug`**. No icon or category columns (mobile will map icons by `slug`). |
| **Kos Photos** | `caption` column | Only **`kos_id`, `photo_path`, `sort_order`**. No caption column. |
| **Kos Status** | `active`, `inactive`, `pending` | DB enum is strictly **`active`, `inactive`** (no `pending` moderation queue yet). |
| **Manual Transfer Proof** | Upload manual transfer proof (`payment_proof`) | **Not implemented** in any controller. Only Midtrans Snap is active; `MemberController::confirmPayment()` is a redirect stub. |
| **Reviews Verification** | `is_verified` | Actual column is **`is_verified_tenant`** + nullable `booking_id`. |
| **Chat Realtime** | Real-time/internal chat | Strictly **DB-backed HTML form POST + full page reload** (no WebSockets, no AJAX polling). |
| **Admin Seeder** | Superadmin role | `DatabaseSeeder` seeds only 1 `owner` and 1 `customer`; **no `admin` user is seeded**. |

---

## 5. Critical Backend Bugs & Security Risks Affecting Mobile Integration

These issues exist in the current Laravel codebase and **must be addressed** in the dedicated `feature/mobile-api` branch:

1. **CRITICAL — Booking Payment State Machine Deadlock (`MidtransService.php`)**:
   - `MidtransService::handleNotification()` only transitions `booking.status` to `'confirmed'` if `$booking->status === 'pending'`. If an owner approves a booking first (`status = 'approved'`), Midtrans marks `invoice = paid` and `payment = success`, **leaving `booking.status` stuck at `'approved'`** so the owner can never check the tenant in.
   - Meanwhile, `MemberController::store()` creates a Snap token while `booking.status === 'pending'`, bypassing the owner approval gate.
   - **Recommendation**: Update `MidtransService` to allow transitioning `in_array($booking->status, ['pending', 'approved'])` -> `'confirmed'`, and standardize whether payment occurs immediately or after owner approval.
2. **CRITICAL — Broken Midtrans Status Auto-Sync (`MemberController.php`)**:
   - `MemberController::show()`, `downloadNota()`, and `invoiceDetail()` call `Transaction::status($orderId)` and feed the response into `handleNotification()`, which rejects it because Midtrans's Status API does not include `signature_key`.
   - **Recommendation**: Add `MidtransService::syncTransactionStatus(Payment $payment)` for authenticated server-to-server polling from mobile.
3. **CRITICAL — Admin Login Redirect Bug (`AuthController.php`)**:
   - `AuthController::login()` lacks an `admin` branch and redirects admins to `member.home` (`403`). Mobile API `/api/v1/auth/login` will return JSON with `user.role` and Sanctum token cleanly for all roles.
4. **HIGH — Room IDOR & Double-Booking Risk (`OwnerBookingController::approve`)**:
   - Passing a `room_id` belonging to another kos skips availability validation because `$room` resolves to `null`, yet still assigns `room_id`. Also, approving a booking does not reserve the room, permitting double-assignment before check-in.
5. **HIGH — Unpaid Nota Download & Unvalidated Contract Signing**:
   - `downloadNota()` allows downloading a receipt for unpaid `'approved'` bookings (should require `invoice.status === 'paid'`).
   - `RentalContractController::forBooking()` / `sign()` do not verify that the booking is `'confirmed'` or `'active'`.
6. **MEDIUM — Missing Role & Input Guards**:
   - `SurveyController::store()` lacks `role:customer` and `kos.status === 'active'` checks.
   - `ChatController::start()` allows owners to message other owners' kos, creating conversations invisible in `ChatController::index()`, and omits `max:2000` validation.
   - `MemberController::updateProfile()` accepts `svg` uploads (stored XSS risk), enforces `min:6` password instead of `min:8`, does not verify `current_password`, and is unavailable to `owner`/`admin` users.
   - `OwnerKosController::update()` wipes all `facilities` if the `facilities` key is omitted from the request.
7. **MEDIUM — `kos.rooms` Column Name Collision**:
   - `kos` table has a string column `rooms` (e.g., `"10 Kamar"`) AND an Eloquent `HasMany` relationship `Kos::rooms()`. In API Resources, these must be serialized distinctly as `rooms_summary` (string) and `room_inventory` (array of `Room` objects).
8. **MEDIUM — Mobile UX Gaps in Existing Controllers**:
   - `notifikasi()` auto-marks all unread notifications as read on `GET`. Mobile requires explicit `POST /notifications/{id}/read` and `POST /notifications/read-all`.
   - `ChatController` eager-loads all messages for all conversations without pagination.
   - No customer booking cancellation endpoint exists even though `'cancelled'` is a supported status.
   - `GoogleAuthController` relies on web browser OAuth redirects and rejects linking existing email accounts.

---

## 6. Implementation Risks & Recommendations

| Risk | Severity | Mitigation Strategy |
| :--- | :--- | :--- |
| **Flutter SDK not installed in PATH** | High | Install Flutter stable SDK + Android Studio/SDK before Phase 4; verify `flutter doctor`. |
| **Web regressions when adding API** | High | Create a dedicated Git branch (`feature/mobile-api`) in `C:\Users\Thinkpad\Downloads\TEMPATIN`. Keep all new API controllers under `App\Http\Controllers\Api\V1\` and reuse shared service/domain logic without altering `routes/web.php` behavior. |
| **Midtrans Mobile Payment UX & Security** | High | Never embed Midtrans Server Key in Flutter. Use server-generated `snap_token` / `snap_redirect_url` rendered in a controlled Flutter WebView (intercepting finish/unfinish/error URLs) backed by existing Midtrans webhook + new `GET /api/v1/payments/{id}/sync` endpoint. |
| **SQLite vs MySQL Schema Drift** | Medium | Test the `feature/mobile-api` branch against MySQL (target production DB) and add a corrective migration if `bookings.room_id` FK or `users.google_id` unique index is missing in local SQLite. |
| **Chat Latency without WebSockets** | Medium | Start with paginated REST + lightweight interval polling (e.g., every 5–10s while chat screen is active) in Phase 9, designed behind a `ChatRepository` interface so Laravel Reverb / WebSockets + Firebase Cloud Messaging (FCM) can be dropped in later without UI rewrites. |
| **Dual-Role App Complexity** | Medium | Use role-aware `GoRouter` shell routes: Customers get a 5-tab Customer bottom bar; Owners get a 5-tab Owner bottom bar. Keep Customer and Owner feature modules strictly separated under `lib/features/`. |
