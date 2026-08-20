# WeatherFlow

Flutter weather app — portfolio / learning project with **Clean Architecture**, Supabase auth, and a dark **glass** auth UI.

Current weather · hourly & 7-day forecast · city search · guest & email auth

---

## Auth screens (WeatherFlow glass UI)

<p align="center">
  <img src="docs/screenshots/welcome.png" width="240" alt="Welcome" />
  &nbsp;
  <img src="docs/screenshots/login.png" width="240" alt="Login" />
  &nbsp;
  <img src="docs/screenshots/sign_up.png" width="240" alt="Sign up" />
</p>

| Screen | What’s new |
|--------|------------|
| **Welcome** | Full-bleed night city background, WeatherFlow wordmark, brand sun/cloud icon, Log in / Sign up CTAs, Google · Instagram · Facebook row, Continue as guest |
| **Login** | Glass email & password fields, show/hide password, Forgot password, primary Log in button, social continue, link to Sign up |
| **Sign up** | Full name, email, password, confirm password, Terms & Privacy checkbox, Create account CTA, social continue, link to Log in |

Shared building blocks: `AuthScaffold`, `AuthGlassField`, `AuthGlassButton`, `AuthSocialRow`.

---

## Weather & settings

<p align="center">
  <img src="docs/screenshots/weather.png" width="240" alt="Weather" />
  &nbsp;
  <img src="docs/screenshots/settings.png" width="240" alt="Settings" />
  &nbsp;
  <img src="docs/screenshots/location_permission.png" width="240" alt="Location permission" />
</p>

---

## What’s in this update

- Redesigned **Welcome / Login / Sign up** (dark atmospheric backgrounds + glass controls)
- WeatherFlow brand assets (icon, backgrounds, social icons)
- Auth route cleanup (`/welcome`); guest & successful auth enter the weather flow
- **City search** feature (domain / data / presentation + Cubit)
- **WeatherMainShell** with bottom navigation (weather + search tabs)
- GetIt wiring for city search

---

## Status

### Done
- WeatherFlow auth UI + Supabase sign up / login / logout
- Weather hero, current conditions, metrics, hourly & 7-day forecast
- Geo permission → location weather or default city
- City search with recent / popular cards
- Settings screen (incl. log out)
- GetIt, repositories, use cases, named routes + `ScreenFactory`

### In progress
- Remaining bottom-nav tabs (favorites / details placeholders)
- Settings toggles → real app behavior
- Domain boundaries & unified error handling (`Result` vs `Either`)

### Next
- Domain entities free of data models · saved cities persistence · °C/°F  
- Unit tests · move API keys to env · fix `DefaultCityService` locale bug  
- Real social providers (buttons are UI-ready)

---

## Tech stack

| Area | Packages |
|------|----------|
| State | `bloc`, `flutter_bloc` |
| Network | `http` |
| Backend | `supabase_flutter` |
| Location | `geolocator` |
| DI | `get_it` |
| Functional | `dartz` |
| UI | `google_fonts`, `lottie`, `weather_icons_animated`, `intl` |

SDK: `>=3.3.1 <4.0.0`

---

## Structure

```text
lib/
├── core/            # DI, config, errors, validators, theme
├── feature/
│   ├── auth/        # WeatherFlow glass UI
│   ├── weather/     # forecast UI + WeatherMainShell
│   ├── city_search/ # search flow
│   └── settings/
└── navigation/      # routes, ScreenFactory
```

---

## Run

```bash
flutter pub get
flutter run
```

> OpenWeather & Supabase keys currently live in  
> `lib/core/config/configuration/configuration.dart` — will move to local env before public release.

---

## Branch

Default: `master`  
Active feature work: `feature/weather-flow`  
(merged: `feature/auth-glass-ui`, `feature/city-search`)
