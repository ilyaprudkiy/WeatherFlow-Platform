# Backlog — Weather App

Detailed tasks for continued development. Format: Jira-style epics and stories with acceptance criteria.

**Priority:** P0 = next sprint · P1 = soon · P2 = later

---

## Epic 1 — Architecture: Weather Domain Layer  
**Goal:** Domain must not depend on data or presentation.  
**Priority:** P0  
**Why:** Main gap in Clean Architecture review; blocks tests and feature growth.

### WEATHER-101 — Extract domain value types for hourly forecast
**Type:** Task  
**Priority:** P0  
**Estimate:** 3–4 h

**Description:**  
Move `WeatherHourItem` from `data/models/weather_hours_model.dart` into domain (e.g. `domain/entity/weather_hour_entity.dart` or `domain/value_objects/`). Entity `WeatherHoursEntity` should only reference domain types.

**Acceptance criteria:**
- [ ] `WeatherHoursEntity` has no import from `data/`
- [ ] Mapping `WeatherHourModel` → domain type lives in `WeatherRepositoryImpl` or a dedicated mapper
- [ ] `HourlyForecastWidget` imports domain type only (or receives DTO from cubit state built from domain)
- [ ] App builds and hourly forecast displays correctly

**Files to touch:**
- `lib/feature/weather/domain/entity/weather_hours_entity.dart`
- `lib/feature/weather/data/models/weather_hours_model.dart`
- `lib/feature/weather/data/repositories/weather_repository_impl.dart`
- `lib/feature/weather/presentation/weather_screen/widgets/hourly_forecast_widget.dart`

---

### WEATHER-102 — Extract domain value types for daily forecast
**Type:** Task  
**Priority:** P0  
**Estimate:** 3–4 h

**Description:**  
Same as WEATHER-101 for `WeatherDailyItem` / `WeatherDailyForecastEntity`.

**Acceptance criteria:**
- [ ] `WeatherDailyForecastEntity` has no import from `data/`
- [ ] Daily forecast UI uses domain types only
- [ ] Temperature bar logic unchanged visually

**Files to touch:**
- `lib/feature/weather/domain/entity/weather_daily_forecast_entity.dart`
- `lib/feature/weather/data/models/weather_daily_forecast_model.dart`
- `lib/feature/weather/presentation/weather_screen/widgets/daily_forecast_widget.dart`

---

### WEATHER-103 — Remove LocationModel from domain repository contract
**Type:** Task  
**Priority:** P1  
**Estimate:** 2 h

**Description:**  
`WeatherRepository` currently imports `LocationModel` from data. Introduce `Coordinates` or `LocationEntity` in domain and map in repository.

**Acceptance criteria:**
- [ ] `domain/repository/weather_repository.dart` has zero data imports
- [ ] Geo flow still works end-to-end

---

## Epic 2 — Architecture: Auth & Shared Patterns  
**Goal:** One auth state, one error pattern.  
**Priority:** P0

### AUTH-201 — Single app-scoped AuthCubit
**Type:** Bug / Refactor  
**Priority:** P0  
**Estimate:** 2–3 h

**Description:**  
`AuthCubit` is created in `main.dart` and again in `ScreenFactory` for welcome/login/signup/settings. This can desync session and logout.

**Acceptance criteria:**
- [ ] Only one `AuthCubit` instance for the whole app
- [ ] Remove `BlocProvider<AuthCubit>` from `ScreenFactory` auth/settings screens
- [ ] Login → weather → settings → logout → welcome works in one flow
- [ ] No duplicate session checks

**Files to touch:**
- `lib/main.dart`
- `lib/navigation/factory/screen_factory.dart`
- Auth screens (use `context.read<AuthCubit>()`)

---

### CORE-202 — Unify Result handling (Either vs Result)
**Type:** Task  
**Priority:** P1  
**Estimate:** 4–6 h

**Description:**  
Auth uses sealed `Result<T>`; weather uses `dartz Either`. Pick one pattern for the whole app.

**Acceptance criteria:**
- [ ] One result type used in all repositories/use cases
- [ ] Remove unused dependency if dropping `dartz`
- [ ] Cubits updated with consistent `fold` / pattern matching

**Recommendation:** Keep `Result<T>` (already in auth, native Dart 3 style).

---

### AUTH-203 — Remove Supabase Session from domain interface
**Type:** Task  
**Priority:** P1  
**Estimate:** 2 h

**Description:**  
`AuthRepository.getCurrentSession` returns Supabase `Session`. Domain should expose `AuthUser` or similar.

**Acceptance criteria:**
- [ ] Domain defines `AuthUser` (id, email, displayName?)
- [ ] Mapping in `AuthRepositoryImpl`
- [ ] `AuthCubit` does not import `supabase_flutter`

---

## Epic 3 — Weather Use Case Layer  
**Goal:** Use cases add value, not just pass-through.  
**Priority:** P1

### WEATHER-301 — Enrich WeatherUseCase with orchestration
**Type:** Task  
**Priority:** P1  
**Estimate:** 3 h

**Description:**  
Add e.g. `loadWeatherBundle()` that loads current weather + hourly + daily in one call, or validate city name before API request.

**Acceptance criteria:**
- [ ] Cubit calls fewer use case methods for initial load
- [ ] Empty/invalid city name handled in use case, not widget
- [ ] `_loadForecasts` logic moved out of cubit into use case (optional but preferred)

---

### WEATHER-302 — Fix DefaultCityService locale bug
**Type:** Bug  
**Priority:** P1  
**Estimate:** 1 h

**Description:**  
In `default_city_service.dart`, `languageCode.contains(languageCode)` is always true; wrong key used for fallback.

**Acceptance criteria:**
- [ ] Correct fallback: country → language → timezone → Berlin
- [ ] Manual test for `locale.countryCode == 'UA'` etc.

---

## Epic 4 — Bottom Navigation Features  
**Goal:** Icons do something useful.  
**Priority:** P0 (portfolio visibility)

### NAV-401 — Search tab: city search screen
**Type:** Story  
**Priority:** P0  
**Estimate:** 6–8 h

**Description:**  
Tapping Search opens a screen/modal with TextField, search button, calls `getWeatherByName`, returns to home with new data.

**Acceptance criteria:**
- [ ] Bottom nav index 1 opens search UI
- [ ] Valid city loads weather and switches to home tab
- [ ] Error shown via SnackBar
- [ ] Loading state on button

**Note:** Can reuse stub from earlier `WeatherSearchTab` pattern.

---

### NAV-402 — Favorites tab: saved cities list
**Type:** Story  
**Priority:** P0  
**Estimate:** 8 h

**Description:**  
Persist favorite city names locally (`shared_preferences` or `hive`). List, add current city, remove, tap to load weather.

**Acceptance criteria:**
- [ ] Data survives app restart
- [ ] Service in data layer + optional use case
- [ ] Favorites tab shows list or empty state
- [ ] No direct file I/O in widgets

---

### NAV-403 — Details tab: extended forecast view
**Type:** Story  
**Priority:** P1  
**Estimate:** 4 h

**Description:**  
Tab 4 shows full hourly + daily + metrics (content already exists; wire navigation only).

**Acceptance criteria:**
- [ ] Bottom nav switches body content without losing cubit state
- [ ] Home tab still shows summary; details tab shows full forecasts

---

## Epic 5 — Settings Feature  
**Goal:** Settings match architecture and app behavior.  
**Priority:** P1

### SET-501 — Introduce SettingsCubit
**Type:** Task  
**Priority:** P1  
**Estimate:** 4 h

**Description:**  
Move toggles (weather alerts, °C, dark mode) to cubit + persistent storage. Remove direct `Supabase.instance` from settings UI for profile; use auth use case/repository.

**Acceptance criteria:**
- [ ] `settings_screen.dart` under ~200 lines (split widgets)
- [ ] Profile email/name from auth layer
- [ ] Toggles persist locally

---

### SET-502 — Wire settings rows to screens or dialogs
**Type:** Story  
**Priority:** P2  
**Estimate:** 6 h

**Description:**  
Replace SnackBar stubs with real screens: Account, Default Location, Saved Cities, Location & Permissions, Help.

**Acceptance criteria:**
- [ ] Each row navigates somewhere meaningful
- [ ] Back navigation works

---

## Epic 6 — Monthly Forecast & UI Polish  
**Priority:** P2

### WEATHER-601 — Monthly forecast button navigation
**Type:** Story  
**Priority:** P2  
**Estimate:** 8+ h (depends on API)

**Description:**  
`MonthlyForecastButton` opens a new screen. Requires API support or mock data for portfolio.

**Acceptance criteria:**
- [ ] Button navigates to monthly screen
- [ ] Placeholder UI if API not available, marked WIP in README

---

### UI-602 — Dark mode
**Type:** Story  
**Priority:** P2  
**Estimate:** 6 h

**Description:**  
Connect settings toggle to `ThemeMode` at app root.

**Acceptance criteria:**
- [ ] Light / dark themes defined
- [ ] Weather screen readable in both modes

---

## Epic 7 — Quality & Security  
**Priority:** P0–P1 before public portfolio

### SEC-701 — Move secrets out of source code
**Type:** Task  
**Priority:** P0  
**Estimate:** 2 h

**Description:**  
OpenWeather + Supabase keys in `configuration.dart` should use `--dart-define` or `.env` (not committed).

**Acceptance criteria:**
- [ ] Example config file in repo without real keys
- [ ] README documents how to run locally

---

### QA-702 — Unit tests for weather repository / use case
**Type:** Task  
**Priority:** P1  
**Estimate:** 6 h

**Description:**  
Mock `WeatherRemoteDataSource`, test success and failure paths.

**Acceptance criteria:**
- [ ] At least 5 meaningful tests
- [ ] CI-ready `flutter test` passes

---

### QA-703 — Fix / replace default widget_test
**Type:** Task  
**Priority:** P2  
**Estimate:** 1 h

**Description:**  
Default counter test is stale; replace with smoke test for `WeatherScreenWidget` or app bootstrap.

---

## Epic 8 — Auth Completion (from earlier audit)  
**Priority:** P1

### AUTH-801 — Complete login button wiring
**Type:** Bug  
**Priority:** P1  
**Estimate:** 1 h

**Verify:** Login form submits email/password from controllers to cubit (if not already fixed in your branch).

---

### AUTH-802 — Guest flow
**Type:** Story  
**Priority:** P2  
**Estimate:** 3 h

**Description:**  
"Continue as guest" skips auth and opens weather with default city.

**Acceptance criteria:**
- [ ] No Supabase session required
- [ ] Weather loads default city

---

## Suggested Sprint Order (mentor recommendation)

| Sprint | Focus | Tasks |
|--------|--------|-------|
| **Sprint 1** | Stability + architecture base | AUTH-201, WEATHER-101, WEATHER-102, SEC-701 |
| **Sprint 2** | Navigation features | NAV-401, NAV-402, WEATHER-302 |
| **Sprint 3** | Settings + use case | SET-501, WEATHER-301, CORE-202 |
| **Sprint 4** | Quality + polish | QA-702, NAV-403, AUTH-203, UI-602 |

---

## Definition of Done (project-wide)

- [ ] Code follows layer imports: presentation → domain ← data
- [ ] No new direct SDK calls in widgets (Supabase, HTTP)
- [ ] User-facing errors via `Failure.message`, not raw exceptions
- [ ] Manual test on Android (or your target device)
- [ ] Commit message: `type(scope): description` (existing convention)

---

*Last updated: after weather UI + settings redesign push to `feature/weather-flow`.*
