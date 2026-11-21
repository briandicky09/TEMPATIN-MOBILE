# TEMPATIN MOBILE — REST API Contract (`/api/v1`)

> **Backend Target**: Existing Laravel 12 app (`C:\Users\Thinkpad\Downloads\TEMPATIN`) on a dedicated Git branch (`feature/mobile-api`).
> **Strict Rule**: Preserve all existing `routes/web.php` Blade behavior. Implement API controllers under `App\Http\Controllers\Api\V1\` with Eloquent API Resources (`App\Http\Resources\V1\`).

---

## 1. Global API Conventions

- **Base URL**: `{APP_URL}/api/v1`
- **Authentication**: **Laravel Sanctum** Personal Access Tokens via `Authorization: Bearer <token>` header.
- **Headers**: `Accept: application/json` (required on all requests).
- **Standard Success Envelope**:
```json
{
  "success": true,
  "message": "Data berhasil dimuat.",
  "data": { ... },
  "meta": {
    "current_page": 1,
    "last_page": 5,
    "per_page": 10,
    "total": 48
  }
}
```
- **Standard Error Envelope (`400`, `401`, `403`, `404`, `422`, `500`)**:
```json
{
  "success": false,
  "message": "Validasi gagal.",
  "errors": {
    "email": ["Email sudah terdaftar."]
  }
}
```
- **Asset URL Normalization**: Every API Resource MUST return full absolute URLs for `avatar_url`, `thumbnail_url`, `photo_url`, etc., abstracting away the mixed `storage/` vs `assets/` paths in the database.
- **`kos.rooms` Disambiguation**: Serialize the string column as `rooms_summary` and the `HasMany<Room>` relation as `room_inventory`.

---

## 2. Endpoint Specifications

### 2.1 Authentication (`/api/v1/auth`)
| Method | Endpoint | Auth / Role | Request Body / Params | Response `data` | Validation Errors / Entities |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `POST` | `/auth/login` | Public | `{email, password, device_name?}` | `{token, user}` | `422` invalid format; `401` bad credentials. Works for `customer`, `owner`, `admin`. Entity: `users`, `personal_access_tokens`. |
| `POST` | `/auth/register` | Public | `{name, phone, email, role: "customer"\|"owner", password, password_confirmation, agree: true}` | `{token, user}` (`201`) | `email` unique, `password` min:8 confirmed, `agree` accepted. Entity: `users`. |
| `POST` | `/auth/google` | Public | `{id_token, role?: "customer"\|"owner", device_name?}` | `{token, user, is_new_user}` | Verifies Google ID token server-side; returns `409` if email exists without `google_id` (matching web policy) or links if approved. Entity: `users`. |
| `POST` | `/auth/forgot-password` | Public | `{email}` | `{}` | `email` required\|email. Entity: `password_reset_tokens`. |
| `POST` | `/auth/reset-password` | Public | `{token, email, password, password_confirmation}` | `{}` | `password` min:8 confirmed, valid token. Entity: `users`, `password_reset_tokens`. |
| `GET` | `/auth/me` | Sanctum / Any | — | `{user, unread_notifications_count, unread_messages_count}` | `401` if token invalid/revoked. Entity: `users`, `notifications`, `messages`. |
| `POST` | `/auth/logout` | Sanctum / Any | — | `{}` | Revokes current access token. Entity: `personal_access_tokens`. |

### 2.2 Profile & Notifications
| Method | Endpoint | Auth / Role | Request Body / Params | Response `data` | Notes / Entities |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `GET` | `/profile` | Sanctum / Any | — | `{user}` | Available to `customer`, `owner`, `admin`. Entity: `users`. |
| `POST` | `/profile` | Sanctum / Any | Multipart: `name`, `phone?`, `avatar?` (`jpeg,png,jpg,webp`, max 2MB, **no SVG**), `current_password?`, `password?` (`min:8`, confirmed) | `{user}` | Deletes old avatar on `public` disk. Entity: `users`. |
| `GET` | `/notifications` | Sanctum / Any | `?page=1&per_page=20` | Paginated `NotificationResource[]` + `unread_count` | **Does NOT auto-mark read.** Includes structured `category`, `action_type`, `action_id`, `action_url`. Entity: `notifications`. |
| `POST` | `/notifications/{id}/read` | Sanctum / Any | — | `{id, read_at}` | Marks single notification read. Entity: `notifications`. |
| `POST` | `/notifications/read-all` | Sanctum / Any | — | `{marked_count}` | Marks all user notifications read. Entity: `notifications`. |

### 2.3 Public / Customer Discovery & Reviews
| Method | Endpoint | Auth / Role | Query / Body | Response `data` | Notes / Entities |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `GET` | `/home` | Optional Auth | — | `{featured_kos[], popular_cities[], facilities[]}` | 6 latest active kos + city counts. Entities: `kos`, `facilities`, `reviews`. |
| `GET` | `/facilities` | Public | — | `FacilityResource[]` (`id`, `name`, `slug`) | Ordered by `name`. Entity: `facilities`. |
| `GET` | `/kos` | Optional Auth | `?keyword=&type=&city=&min_price=&max_price=&facilities[]=1&sort=newest\|price_asc\|price_desc\|rating_desc&page=1&per_page=10` | Paginated `KosSummaryResource[]` | Active kos only; includes `is_favorited` if auth token present. Entities: `kos`, `facilities`, `kos_photos`, `reviews`, `favorites`. |
| `GET` | `/kos/{slug}` | Optional Auth | — | `KosDetailResource` (owner summary, photos, facilities, `available_rooms[]`, coords, rating, `can_review`, `is_favorited`, `similar_kos[]`) | `404` if inactive/deleted. Entities: `kos`, `kos_photos`, `facilities`, `rooms`, `reviews`, `users`. |
| `GET` | `/kos/{slug}/reviews` | Public | `?rating=1..5&page=1&per_page=10` | Paginated `ReviewResource[]` + rating breakdown | Entities: `reviews`, `users`. |
| `POST` | `/kos/{slug}/reviews` | Sanctum / `customer` | `{rating: 1..5, comment: string(5..1000)}` | `ReviewResource` (`201`) | Requires `confirmed`/`active`/`completed` booking; 1 review per user per kos; notifies owner. Entities: `reviews`, `bookings`, `notifications`. |

### 2.4 Favorites
| Method | Endpoint | Auth / Role | Body | Response `data` | Notes / Entities |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `GET` | `/favorites` | Sanctum / `customer` | `?page=1&per_page=10` | Paginated `KosSummaryResource[]` | Active favorited kos only. Entities: `favorites`, `kos`. |
| `POST` | `/favorites/toggle` | Sanctum / `customer` | `{kos_slug}` | `{is_favorite: bool, favorites_count: int}` | Validates active kos exists. Entity: `favorites`. |

### 2.5 Bookings, Payments, Invoices & Contracts (Customer)
| Method | Endpoint | Auth / Role | Request Body / Params | Response `data` | Notes / Entities |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `GET` | `/bookings` | Sanctum / `customer` | `?status=&page=1` | Paginated `BookingSummaryResource[]` | Customer's own bookings. Entities: `bookings`, `kos`, `rooms`, `invoices`. |
| `POST` | `/bookings` | Sanctum / `customer` | `{kos_slug, room_id?, tenant_name, tenant_phone, tenant_email, start_date, duration_months(1..12), notes?}` | `BookingDetailResource` (`201`) | **Owner Approval First**: Server calculates `subtotal`, `admin_fee` (`25000`), `total_amount`, `end_date`; 5-min duplicate guard; creates `Booking (pending)` + `Invoice (unpaid)`; notifies owner. Does **not** initiate Midtrans yet. Entities: `bookings`, `invoices`, `rooms`, `notifications`. |
| `GET` | `/bookings/{code}` | Sanctum / `customer` | — | `BookingDetailResource` (with `invoice`, `latest_payment`, `contract_summary`, `room`) | Anti-IDOR check (`customer_id === auth.id`). Entities: `bookings`, `invoices`, `payments`, `rental_contracts`. |
| `PATCH` | `/bookings/{code}/cancel` | Sanctum / `customer` | `{reason?}` | `BookingDetailResource` | Allowed only when `status === 'pending'`; cancels unpaid invoice. Entities: `bookings`, `invoices`. |
| `POST` | `/bookings/{code}/pay` | Sanctum / `customer` | — | `{payment_code, order_id, amount, snap_token, snap_redirect_url, client_key, is_production}` | **Strictly requires `booking.status === 'approved'`** and `invoice.status === 'unpaid'` (returns `422` if still `pending`, `rejected`, `cancelled`, or already paid). Reuses <15-min pending Snap token or creates new via `MidtransService`. Entities: `payments`, `invoices`, `bookings`. |
| `GET` | `/payments/{payment_code}/sync` | Sanctum / `customer` | — | `{payment_status, invoice_status, booking_status, paid_at}` | Calls new `MidtransService::syncTransactionStatus()` server-to-server (idempotent). Transitions `approved -> confirmed` on settlement/capture. Entities: `payments`, `invoices`, `bookings`. |
| `POST` | `/payment/midtrans/notification` | Public (Webhook) | Midtrans JSON payload | `{message: "OK"}` | **Existing route preserved**; fix `MidtransService` to transition `approved -> confirmed` (idempotent, SHA-512 signature + amount verified). |
| `GET` | `/invoices` | Sanctum / `customer` | `?status=&page=1` | Paginated `InvoiceResource[]` | Entities: `invoices`, `bookings`, `kos`. |
| `GET` | `/invoices/{invoice_number}` | Sanctum / `customer` | — | `InvoiceDetailResource` (with `payments[]`) | Anti-IDOR check. Entities: `invoices`, `payments`. |
| `GET` | `/bookings/{code}/nota-pdf` | Sanctum / `customer` | — | `application/pdf` binary stream | Requires `invoice.status === 'paid'`. Uses existing DomPDF view `member.booking.nota_pdf`. |
| `GET` | `/bookings/{code}/contract` | Sanctum / `customer`\|`owner`\|`admin` | — | `RentalContractResource` | Requires booking in `confirmed`/`active`/`completed`; calls `firstOrCreateForBooking()`. Entity: `rental_contracts`. |
| `POST` | `/contracts/{contract_number}/sign` | Sanctum / `customer` | `{agree: true}` | `RentalContractResource` | Customer-only; sets `signed_at`, `signer_ip`, `status = 'active'`; notifies owner. Entity: `rental_contracts`. |
| `GET` | `/contracts/{contract_number}/pdf` | Sanctum / `customer`\|`owner`\|`admin` | — | `application/pdf` binary stream | Uses existing DomPDF view `contracts.pdf`. |

### 2.6 Surveys, Maintenance & Chat
| Method | Endpoint | Auth / Role | Request Body / Params | Response `data` | Notes / Entities |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `GET` | `/surveys` | Sanctum / `customer` | `?status=&page=1` | Paginated `SurveyResource[]` | Entity: `surveys`. |
| `POST` | `/kos/{slug}/surveys` | Sanctum / `customer` | `{survey_date (>= today), survey_time, notes?}` | `SurveyResource` (`201`) | Blocks duplicate `pending` survey; enforces active kos; notifies owner. Entity: `surveys`. |
| `PATCH` | `/surveys/{id}/cancel` | Sanctum / `customer` | — | `SurveyResource` | Only when `status === 'pending'`. Entity: `surveys`. |
| `GET` | `/maintenance-reports` | Sanctum / `customer` | `?status=&page=1` | Paginated `MaintenanceReportResource[]` | Entity: `maintenance_reports`. |
| `POST` | `/maintenance-reports` | Sanctum / `customer` | Multipart: `booking_id`, `title (max:150)`, `description (max:1000)`, `photo? (max:3MB)` | `MaintenanceReportResource` (`201`) | Requires owned booking in `confirmed`/`active`; notifies owner. Entities: `maintenance_reports`, `bookings`. |
| `GET` | `/conversations` | Sanctum / `customer`\|`owner` | `?page=1&per_page=20` | Paginated `ConversationResource[]` (with `last_message`, `unread_count`, `kos`, `counterpart`) | Queries `customer_id` or `owner_id` (or both if needed) without loading all messages. Entities: `conversations`, `messages`. |
| `POST` | `/kos/{slug}/conversations` | Sanctum / `customer` | `{message?: string(1..2000)}` | `ConversationResource` | Blocks messaging own kos; `firstOrCreate` conversation; optionally sends initial message & notifies owner. |
| `GET` | `/conversations/{id}/messages` | Sanctum / `customer`\|`owner` | `?page=1&per_page=30&after_id=` | Paginated `MessageResource[]` | Participant check; marks counterpart messages `is_read = true`; supports `after_id` for lightweight incremental polling. |
| `POST` | `/conversations/{id}/messages` | Sanctum / `customer`\|`owner` | `{message: string(1..2000)}` | `MessageResource` (`201`) | Participant check; strips tags; touches conversation; notifies counterpart. |

### 2.7 Owner Management (`/api/v1/owner`, Auth: Sanctum + `role:owner`)
| Method | Endpoint | Request Body / Params | Response `data` | Notes / Entities |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/owner/dashboard` | — | `{total_kos, active_kos, inactive_kos, avg_price, pending_bookings_count, pending_surveys_count, open_maintenance_count, recent_kos[]}` | Entities: `kos`, `bookings`, `surveys`, `maintenance_reports`. |
| `GET` | `/owner/kos` | `?status=&search=&page=1` | Paginated `OwnerKosResource[]` | Scoped to `owner_id`. Entity: `kos`. |
| `POST` | `/owner/kos` | Multipart: `title`, `type`, `city`, `price`, `address?`, `area?`, `rooms?`, `bathrooms?`, `bedrooms?`, `garages?`, `latitude?`, `longitude?`, `description?`, `thumbnail?`, `facilities[]?`, `photos[]?` | `OwnerKosResource` (`201`) | Reuses `StoreKosRequest` rules. Entities: `kos`, `kos_photos`, `facility_kos`. |
| `GET` | `/owner/kos/{slug}` | — | `OwnerKosDetailResource` (with `photos`, `facilities`, `rooms_count`) | `KosPolicy::view`. |
| `POST` | `/owner/kos/{slug}` | Multipart (`_method=PUT` or `POST`): same fields + `status?`, `delete_photos[]?` | `OwnerKosResource` | `KosPolicy::update`; only syncs `facilities` if key is present; cleans old thumbnail. |
| `DELETE` | `/owner/kos/{slug}` | — | `{}` | Soft-deletes `Kos` (`KosPolicy::delete`). |
| `GET` | `/owner/kos/{slug}/rooms` | — | `RoomResource[]` | Scoped to owner's kos. Entity: `rooms`. |
| `POST` | `/owner/kos/{slug}/rooms` | `{room_number, floor?, room_type?, price_override?, status, notes?}` | `RoomResource` (`201`) | Unique `room_number` per `kos_id`. |
| `PUT` | `/owner/kos/{slug}/rooms/{room}` | Same as POST | `RoomResource` | Validates room belongs to kos. |
| `DELETE` | `/owner/kos/{slug}/rooms/{room}` | — | `{}` | Blocks if room has `approved`/`confirmed`/`active` bookings. |
| `GET` | `/owner/bookings` | `?status=&search=&page=1` | Paginated `OwnerBookingResource[]` + `status_counts` | Entity: `bookings`. |
| `GET` | `/owner/bookings/{code}` | — | `OwnerBookingDetailResource` + `available_rooms[]` | Anti-IDOR check. |
| `POST` | `/owner/bookings/{code}/approve` | `{room_id?}` | `OwnerBookingDetailResource` | Validates `room_id` belongs to `$booking->kos_id` & is available; transitions `pending -> approved`; ensures invoice; notifies customer. |
| `POST` | `/owner/bookings/{code}/reject` | `{rejection_reason (3..500)}` | `OwnerBookingDetailResource` | Cancels unpaid invoice; notifies customer. |
| `POST` | `/owner/bookings/{code}/checkin` | — | `OwnerBookingDetailResource` | `confirmed -> active`; sets `room.status = 'occupied'`; notifies customer. |
| `POST` | `/owner/bookings/{code}/checkout` | — | `OwnerBookingDetailResource` | `active -> completed`; sets `room.status = 'available'`; notifies customer. |
| `GET` | `/owner/tenants` | `?status=active\|confirmed\|completed\|all&page=1` | Paginated `OwnerBookingResource[]` + `counts` | Active tenant directory. |
| `GET` | `/owner/surveys` | `?status=&page=1` | Paginated `SurveyResource[]` | Owner's incoming surveys. |
| `PATCH` | `/owner/surveys/{id}/status` | `{status: "approved"\|"rejected"\|"completed", rejection_reason?}` | `SurveyResource` | Blocks if `cancelled`; notifies customer. |
| `GET` | `/owner/maintenance-reports` | `?status=&page=1` | Paginated `MaintenanceReportResource[]` | Owner's incoming damage reports. |
| `PATCH` | `/owner/maintenance-reports/{id}/status` | `{status: "open"\|"in_progress"\|"resolved"\|"rejected", owner_notes?}` | `MaintenanceReportResource` | Notifies customer. |
| `GET` | `/owner/reviews` | `?kos_id=&page=1` | Paginated `ReviewResource[]` + `rating_summary` | All reviews across owner's kos. |
| `POST` | `/owner/reviews/{id}/reply` | `{reply: string(3..1000)}` | `ReviewResource` | Owner check; notifies reviewer. |
| `GET` | `/owner/analytics` | — | `{total_revenue, total_bookings, occupancy_rate, revenue_growth_pct, monthly_revenue[], kos_performance[]}` | Mirrors `OwnerKosController@statistik`. |

### 2.8 Superadmin Moderation (`/api/v1/admin`, Optional Phase 9+, Auth: Sanctum + `role:admin`)
- `GET /admin/dashboard` — Global counts (`customers`, `owners`, `kos`, `bookings`, `total_revenue`) + recent items.
- `GET /admin/kos`, `PATCH /admin/kos/{slug}/status` (`active` | `inactive`).
- `GET /admin/users` (`?role=&search=&page=1`).
- `GET /admin/bookings` (`?status=&page=1`).
- `GET /admin/reviews`, `DELETE /admin/reviews/{id}`.

---

## 3. Required Laravel Backend Changes (Phase 6 — Branch `feature/mobile-api`)

1. Run `php artisan install:api` in `TEMPATIN` (installs `laravel/sanctum`, creates `routes/api.php`, adds `personal_access_tokens` migration, registers API routes in `bootstrap/app.php`).
2. Add `HasApiTokens` trait to `App\Models\User`.
3. Update `EnsureUserHasRole` middleware to return JSON `401`/`403` when `$request->expectsJson()`.
4. Fix `MidtransService`:
   - Enforce **Owner Approval First**: `POST /api/v1/bookings/{code}/pay` only permits `booking.status === 'approved'`; `handleNotification()` transitions `approved -> confirmed` idempotently after SHA-512 signature & gross amount verification.
   - Add `syncTransactionStatus(Payment $payment)` for authenticated server-to-server status checks (also idempotent, transitioning `approved -> confirmed`).
5. Fix security/validation bugs identified in `PROJECT_ANALYSIS.md` (room ownership check on approve, unpaid nota guard, contract booking-status guard, SVG upload block, `facilities` partial update guard).
6. Add `App\Http\Controllers\Api\V1\*` and `App\Http\Resources\V1\*` with PHPUnit Feature Tests covering auth, role guards, booking/payment flow, and owner CRUD.
