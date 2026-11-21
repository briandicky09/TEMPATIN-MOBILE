# TEMPATIN MOBILE — Technical Decisions (ADRs) & Package Selection

> Documents key architectural choices, alternatives evaluated, and recommended stable Flutter/Dart package versions.

---

## 1. Architecture Decision Records (ADRs)

### ADR-001: State Management — Riverpod (`flutter_riverpod` + `riverpod_annotation`)
- **Decision**: Use **Riverpod 2.x** with `AsyncNotifier` / `Notifier` (and `riverpod_generator` for clean provider boilerplate).
- **Rationale**: Compile-time safety, zero `BuildContext` coupling, effortless provider composition (e.g., `dioProvider` -> `authRepositoryProvider` -> `authSessionProvider`), and native `AsyncValue` support for loading/error/data states.

### ADR-002: Navigation — `go_router` with Role-Aware `StatefulShellRoute`
- **Decision**: Use **GoRouter** with two independent `StatefulShellRoute.indexedStack` shells (Customer 5-tab shell and Owner 5-tab shell) controlled by a reactive `refreshListenable` bound to `authSessionProvider`.
- **Rationale**: Preserves tab scroll state, handles role-based redirects declaratively, and supports deep linking for Midtrans return URLs, password resets, and notifications.

### ADR-003: Immutability & Serialization — `freezed` + `json_serializable`
- **Decision**: Use **Freezed** for all domain entities, API DTOs, and complex UI states (such as `AuthState` and `FilterState`).
- **Rationale**: Eliminates manual `copyWith`, equality (`==`/`hashCode`), and JSON parsing bugs; guarantees immutable state updates for Riverpod.

### ADR-004: Authentication — Laravel Sanctum + Mobile Google ID Token Flow
- **Decision**: Install **Laravel Sanctum** on the backend (`personal_access_tokens`) and store Bearer tokens in `flutter_secure_storage` (Android Keystore / iOS Keychain). For Google Sign-In, use the native `google_sign_in` Flutter package to obtain a Google `idToken`, send it to `POST /api/v1/auth/google`, and verify it server-side before issuing a Sanctum token.
- **Rationale**: Native Google Sign-In avoids fragile in-app OAuth browser redirects while keeping all token verification and user provisioning securely on the Laravel backend.

### ADR-005: Maps — `flutter_map` + OpenStreetMap (with Nominatim Geocoding)
- **Decision**: Use **`flutter_map`** + `latlong2` rendering OpenStreetMap tiles (`https://tile.openstreetmap.org/{z}/{x}/{y}.png`), matching the existing web app's Leaflet + OSM + Nominatim stack, paired with `url_launcher` for "Buka di Google Maps" turn-by-turn navigation.
- **Alternative Considered**: `google_maps_flutter` (requires Google Cloud billing account, API keys per platform, and diverges from the web's OSM stack).
- **Rationale**: Zero billing friction, 100% parity with web TEMPATIN, lightweight, and works identically on Android and iOS. *(Note: Include a compliant custom `User-Agent` header per OSM tile usage policy.)*

### ADR-006: Midtrans Payments — Server Snap URL in Controlled WebView + Webhook + Server Sync
- **Decision**: Keep all Midtrans Server Key operations strictly in Laravel (`MidtransService`). Mobile requests `POST /api/v1/bookings/{code}/pay`, loads `snap_redirect_url` inside `webview_flutter`, intercepts finish/error callbacks, and verifies final settlement via `GET /api/v1/payments/{code}/sync` alongside the existing Midtrans webhook (`POST /payment/midtrans/notification`).
- **Alternative Considered**: Third-party community Midtrans native SDK wrappers (`midtrans_sdk`), which frequently lag behind Flutter/Gradle/Xcode upgrades.
- **Rationale**: Supports every Midtrans channel (VA, QRIS, GoPay, ShopeePay, Credit Card) with zero native SDK breakage and full server-side security verification.

### ADR-007: Chat & Notifications — Paginated REST + Incremental Polling (Extensible to Reverb/FCM)
- **Decision**: Because the existing Laravel backend uses DB-backed `conversations`/`messages` and `database` notifications with no WebSocket server, Phase 9 will implement paginated REST endpoints with lightweight `after_id` incremental polling (every 5–8s only while `ChatDetailScreen` is mounted).
- **Rationale**: Requires zero extra infrastructure (Redis/Reverb/Pusher) to ship reliably, while abstracting `ChatRepository` behind a stream/polling interface so Laravel Reverb + Firebase Cloud Messaging (FCM) can be added cleanly in a future phase.

### ADR-008: PDF Handling (Nota & Rental Contract) — Server DomPDF Stream + Native Viewer/Share
- **Decision**: Continue generating legally formatted Nota and Rental Contract PDFs on the Laravel backend via existing `barryvdh/laravel-dompdf` views, downloaded via authenticated Dio (`ResponseType.bytes`) into temporary storage, previewed in-app, and shareable via `share_plus`.
- **Rationale**: Single source of truth for legal contract wording and receipt layouts across web and mobile.

### ADR-009: Superadmin Role Scope on Mobile
- **Decision**: Prioritize **Customer** and **Property Owner** for the mobile application. Keep **Superadmin** moderation web-first, while defining its `/api/v1/admin/*` endpoints in `API_CONTRACT.md` so a lightweight admin mobile view can be added in Phase 9+ if desired.
- **Rationale**: Superadmin tasks (bulk user/booking/review auditing) are desktop-optimized; focusing mobile engineering on Customer & Owner maximizes product polish.

---

## 2. Recommended Stable Package Stack (`pubspec.yaml` Target)

*(Target SDK: Flutter `>=3.24.0 <4.0.0`, Dart `>=3.5.0 <4.0.0` — exact minor versions will be locked via `flutter pub add` during Phase 4.)*

| Category | Package | Target Version | Purpose |
| :--- | :--- | :--- | :--- |
| **State Management** | `flutter_riverpod` | `^2.6.1` | Reactive state management |
| **State Codegen** | `riverpod_annotation` | `^2.6.1` | Typed Riverpod providers |
| **Routing** | `go_router` | `^14.6.2` | Declarative routing & bottom nav shells |
| **Networking** | `dio` | `^5.7.0` | HTTP client, interceptors, multipart, PDF bytes |
| **Serialization** | `freezed_annotation` | `^2.4.4` | Immutable models & unions |
| **JSON** | `json_annotation` | `^4.9.0` | JSON serialization annotations |
| **Secure Storage** | `flutter_secure_storage` | `^9.2.2` | Encrypted Sanctum token storage |
| **Preferences** | `shared_preferences` | `^2.3.3` | Non-sensitive preferences & recent searches |
| **Typography** | `google_fonts` | `^6.2.1` | Inter & Source Serif 4 (or bundled fonts) |
| **Icons** | `lucide_icons_flutter` | `^3.0.0` | Clean editorial 1.75px stroke icons |
| **Images** | `cached_network_image` | `^3.4.1` | Cached kos/avatar images |
| **SVG** | `flutter_svg` | `^2.0.16` | `city-skyline.svg` & vector assets |
| **Image Picker** | `image_picker` | `^1.1.2` | Camera/gallery for avatar, kos, maintenance |
| **Image Compress** | `flutter_image_compress` | `^2.3.0` | Client-side resize/compress before upload |
| **Maps** | `flutter_map` + `latlong2` | `^7.0.2` / `^0.9.1` | OpenStreetMap viewer & owner pin picker |
| **Payments WebView** | `webview_flutter` | `^4.10.0` | Midtrans Snap checkout container |
| **PDF & Share** | `printing` + `share_plus` + `path_provider` | `^5.13.4` / `^10.1.3` / `^2.1.5` | In-app PDF preview, print & OS share |
| **Charts (Owner)** | `fl_chart` | `^0.69.2` | 6-month revenue & occupancy charts |
| **Google Sign-In** | `google_sign_in` | `^6.2.2` | Native Google ID token acquisition |
| **Formatting** | `intl` | `^0.19.0` | IDR currency & `id_ID` date formatting |
| **External Links** | `url_launcher` | `^6.3.1` | Open Google Maps / WhatsApp / Support |
| **Dev Dependencies** | `build_runner`, `freezed`, `json_serializable`, `riverpod_generator`, `mocktail`, `flutter_lints` | Latest compatible | Codegen, mocking & static analysis |
