# Commits 2-7 of refactor batch (commit 1 is done manually).
# Usage: .\scripts\commit_refactor_remaining.ps1
# Optional: .\scripts\commit_refactor_remaining.ps1 -DelayMinutes 12

param(
    [int]$DelayMinutes = 15
)

$ErrorActionPreference = "Stop"
Set-Location (Split-Path $PSScriptRoot -Parent)

$logFile = Join-Path $PSScriptRoot "commit_refactor_batch.log"

function Write-Log {
    param([string]$Text)
    $line = "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')] $Text"
    Add-Content -Path $logFile -Value $line
    Write-Host $line
}

function Invoke-LogicalCommit {
    param(
        [string]$Message,
        [string[]]$Paths
    )

    Write-Log "Commit: $Message"

    foreach ($path in $Paths) {
        git add -- "$path" 2>$null
    }

    $status = git status --porcelain
    if (-not $status) {
        Write-Log "Nothing to commit, skipping."
        return
    }

    git commit -m $Message
    $hash = git log -1 --format=%h
    Write-Log "Created $hash"
}

$commits = @(
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

Write-Log "Batch start. $($commits.Count) commits, ${DelayMinutes}m delay."

for ($i = 0; $i -lt $commits.Count; $i++) {
    if ($i -gt 0) {
        Write-Log "Waiting ${DelayMinutes} minute(s)..."
        Start-Sleep -Seconds ($DelayMinutes * 60)
    }

    $entry = $commits[$i]
    Invoke-LogicalCommit -Message $entry.Message -Paths $entry.Paths
}

Write-Log "Batch complete."
git status >> $logFile
git log --oneline -8 >> $logFile
