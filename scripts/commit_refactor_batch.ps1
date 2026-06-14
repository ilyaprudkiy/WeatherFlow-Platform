# Logical refactor commits with delay between each commit.
# Usage: .\scripts\commit_refactor_batch.ps1
# Optional: .\scripts\commit_refactor_batch.ps1 -DelayMinutes 15

param(
    [int]$DelayMinutes = 15
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

function Invoke-LogicalCommit {
    param(
        [string]$Message,
        [string[]]$Paths
    )

    Write-Host ""
    Write-Host "=== $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===" -ForegroundColor Cyan
    Write-Host "Commit: $Message" -ForegroundColor Yellow

    foreach ($path in $Paths) {
        if (Test-Path $path) {
            git add -- "$path"
        } else {
            Write-Host "Skip missing path: $path" -ForegroundColor DarkYellow
        }
    }

    $status = git status --porcelain
    if (-not $status) {
        Write-Host "Nothing to commit, skipping." -ForegroundColor DarkYellow
        return
    }

    git commit -m $Message
    git log -1 --format=fuller
    Write-Host "Done." -ForegroundColor Green
}

function Wait-BetweenCommits {
    param([int]$Minutes)

    if ($Minutes -le 0) { return }

    Write-Host ""
    Write-Host "Waiting $Minutes minute(s) before next commit..." -ForegroundColor Magenta
    Start-Sleep -Seconds ($Minutes * 60)
}

$commits = @(
    @{
        Message = "feat(core): add shared theme and reusable widgets"
        Paths = @(
            "lib/core/theme",
            "lib/core/widgets",
            "lib/core/buttons/app_buttons.dart",
            "lib/main.dart"
        )
    },
    @{
        Message = "fix(auth): register AuthCubit as singleton and simplify ScreenFactory"
        Paths = @(
            "lib/core/di/service_locator.dart",
            "lib/navigation/factory/screen_factory.dart",
            "lib/feature/auth/presentation/cubit/auth_cubit.dart"
        )
    },
    @{
        Message = "fix(navigation): clear auth stack and normalize route names"
        Paths = @(
            "lib/core/navigation/auth_navigation.dart",
            "lib/navigation/navigation.dart",
            "lib/feature/auth/presentation/login_screen/login_screen.dart",
            "lib/feature/auth/presentation/welcome_screen/welcome_screen.dart"
        )
    },
    @{
        Message = "refactor(auth): split sign up screen and adopt shared widgets"
        Paths = @(
            "lib/feature/auth/presentation/sign_up_screen",
            "lib/feature/auth/presentation/login_screen/widgets/form_login_and_password_widget.dart",
            "lib/feature/auth/presentation/login_screen/widgets/form_button_login_forgot_widget.dart",
            "lib/feature/auth/presentation/login_screen/widgets/text_welcome_widget.dart",
            "lib/feature/auth/presentation/welcome_screen/widgets/start_button_widget.dart"
        )
    },
    @{
        Message = "refactor(settings): split settings screen into widget files"
        Paths = @(
            "lib/feature/settings/presentation/screens/settings_screen"
        )
    },
    @{
        Message = "refactor(weather): extract widgets, remove dead code and fix cubit typo"
        Paths = @(
            "lib/feature/weather/presentation/weather_screen/weather_screen.dart",
            "lib/feature/weather/presentation/weather_screen/cubit/weather_screen_cubit.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/geo_permission_dialog.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/temperature_widget.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/app_bar_widget.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/card_current_weather.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/lower_app_bar_widget.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/weather_detail_card_widget.dart",
            "lib/feature/auth/presentation/welcome_screen/widgets/main_information_widget.dart"
        )
    },
    @{
        Message = "refactor(weather): adopt shared theme in forecast and metrics widgets"
        Paths = @(
            "lib/feature/weather/presentation/weather_screen/widgets/hourly_forecast_widget.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/daily_forecast_widget.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/weather_metrics_card_widget.dart",
            "lib/feature/weather/presentation/weather_screen/widgets/weather_bottom_nav_bar.dart",
            "lib/core/constant/widgets/custom_painter.dart"
        )
    }
)

Write-Host "Starting batch: $($commits.Count) commits, $DelayMinutes min between each." -ForegroundColor Cyan
Write-Host "Branch: $(git branch --show-current)" -ForegroundColor Cyan

for ($i = 0; $i -lt $commits.Count; $i++) {
    $entry = $commits[$i]
    Invoke-LogicalCommit -Message $entry.Message -Paths $entry.Paths

    if ($i -lt ($commits.Count - 1)) {
        Wait-BetweenCommits -Minutes $DelayMinutes
    }
}

Write-Host ""
Write-Host "Batch complete at $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor Cyan
git status
git log --oneline -8
