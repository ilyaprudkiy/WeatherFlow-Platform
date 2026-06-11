## Weather App (Flutter) — Work in Progress

A Flutter weather application I am building in my free time as a learning and portfolio project.

The app shows current weather, hourly and 7-day forecasts, and includes auth via Supabase. I am gradually moving the codebase toward **Clean Architecture** and improving layer boundaries between features.

---

## Screenshots

**Auth**

| Welcome | Login | Sign up |
|:---:|:---:|:---:|
| <img src="docs/screenshots/welcome.png" width="220" alt="Welcome screen" /> | <img src="docs/screenshots/login.png" width="220" alt="Login screen" /> | <img src="docs/screenshots/sign_up.png" width="220" alt="Sign up screen" /> |

**Weather & settings**

| Main weather | Settings | Location permission |
|:---:|:---:|:---:|
| <img src="docs/screenshots/weather.png" width="220" alt="Weather screen with hourly forecast" /> | <img src="docs/screenshots/settings.png" width="220" alt="Settings screen" /> | <img src="docs/screenshots/location_permission.png" width="220" alt="Location permission dialog" /> |

---

## Current Status

### Done

**Auth**
- Welcome screen (Sign up / Log in / Continue as guest)
- Login and Sign up screens with custom UI
- Supabase auth integration (sign up, login, logout)
- Auth flow fixes (validation, navigation)

**Weather**
- Weather screen with hero (city image + gradient overlay)
- Current weather card (city, temperature, feels like)
- Metrics card (humidity, wind, UV index)
- Hourly forecast (selectable cards)
- 7-day forecast (container with dividers and temperature bars)
- Monthly forecast button (UI stub, no navigation yet)
- Custom bottom navigation bar (visual selection only)
- Geo permission dialog → weather by location or default city
- OpenWeather hourly/daily timeline API integration

**Settings**
- Settings screen (card-based UI)
- Weather-related menu items (saved cities, location, forecast details, help)
- Log out

**Core**
- GetIt service locator
- Repository + use case pattern (auth and weather)
- Error mapping (`Failure`, Supabase/weather mappers)
- Named routes + `ScreenFactory`

### In Progress

- Wiring bottom navigation tabs to real screens (search, favorites, details)
- Connecting settings toggles to app behavior
- Architecture cleanup (domain layer boundaries, unified error handling)

### Planned Next

**Short-term**
- Fix weather domain layer (entities independent of data models)
- Single app-scoped `AuthCubit` lifecycle
- City search screen
- Saved cities with local persistence
- Settings actions with real navigation / state

**Mid-term**
- Monthly / extended forecast screen
- Celsius / Fahrenheit toggle
- Weather alerts notifications
- Dark mode

**Architecture & quality**
- Unify `Result<T>` vs `Either` across features
- Bring settings into data/domain layers
- Unit tests for use cases, repositories, cubits
- Move API keys to environment config (not committed)
- Fix `DefaultCityService` locale logic bug

**Optional (later)**
- Pro subscription / premium features
- Guest mode polish

---

## Tech Stack

**Flutter / Dart** — SDK `>=3.3.1 <4.0.0`

| Area | Packages |
|------|----------|
| State | bloc, flutter_bloc |
| Networking | http |
| Backend | supabase_flutter |
| Location | geolocator |
| Functional | dartz |
| DI | get_it |
| UI | google_fonts, lottie, weather_icons_animated, intl |

---

## Project Structure

```
lib/
├── core/                 # DI, config, errors, validators
├── feature/
│   ├── auth/             # data / domain / presentation
│   ├── weather/          # data / domain / presentation
│   └── settings/         # presentation (to be expanded)
└── navigation/           # routes, ScreenFactory
```

---

## Getting Started

```bash
flutter pub get
flutter run
```

**Note:** API keys for OpenWeather and Supabase are currently in `lib/core/config/configuration/configuration.dart`. I plan to move them to a local env setup before public release.

---

## Branch

Active development: `feature/weather-flow`
