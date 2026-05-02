# -----------------------------------------------------------------------------
# Cross-Platform Ported Functions (Linux -> Windows)
# -----------------------------------------------------------------------------

# --- Navigation ---

# Go to Dotfiles root
function dot { Set-Location "$HOME\workspace\repos\dotfiles-2024" }

# Go to Repos root
function repos { Set-Location "$HOME\workspace\repos" }

# Up N levels (up 3)
function up {
    param([int]$levels = 1)
    $path = ".\"
    for ($i = 0; $i -lt $levels; $i++) { $path += "..\" }
    Set-Location $path
}

# --- Development Utils ---

# Universal Cleanup (node_modules, pycache, etc.)
function cleanup {
    Write-Host "Starting development cleanup..." -ForegroundColor Cyan
    
    $targets = @("node_modules", "__pycache__", ".pytest_cache", ".mypy_cache", "build", "dist")
    foreach ($target in $targets) {
        Get-ChildItem -Path . -Filter $target -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
            Write-Host "Removing: $($_.FullName)" -ForegroundColor Yellow
            Remove-Item -Path $_.FullName -Recurse -Force
        }
    }
    
    Write-Host "Cleanup completed!" -ForegroundColor Green
}

# --- Git FZF Helpers (Minimalist ports) ---

# Interactive Git Add
function gafzf {
    $files = git status -s | fzf -m --preview "git diff --color=always {2}" | ForEach-Object { $_.Substring(3) }
    if ($files) { git add $files }
}

# Interactive Branch Switch
function gbfzf {
    $branch = git branch --all | fzf --preview "git log --graph --color=always {1}" | ForEach-Object { $_.Trim().Replace("remotes/origin/", "") }
    if ($branch) { git checkout $branch }
}

# --- Extra Ported Aliases ---
function win { Set-Location $HOME }
function dev { Set-Location "D:\Escritorio 2\Cursos-Yordy\00 - Cursos Programacion" }
