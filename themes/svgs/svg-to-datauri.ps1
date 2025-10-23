# Skrypt konwertujący plik SVG na Data URI dla CSS
# Użycie: .\svg-to-datauri.ps1 "sciezka/do/pliku.svg"

param(
    [Parameter(Mandatory=$true)]
    [string]$SvgPath
)

if (-not (Test-Path $SvgPath)) {
    Write-Error "Plik nie istnieje: $SvgPath"
    exit 1
}

# Wczytaj zawartość SVG
$svgContent = Get-Content -Path $SvgPath -Raw -Encoding UTF8

# Usuń zbędne białe znaki i nowe linie (opcjonalne, dla mniejszego rozmiaru)
$svgContent = $svgContent -replace '\s+', ' '
$svgContent = $svgContent.Trim()

# Zakoduj URL
$encodedSvg = [System.Web.HttpUtility]::UrlEncode($svgContent)

# Wygeneruj Data URI
$dataUri = "url(`"data:image/svg+xml,$encodedSvg`")"

# Wyświetl wynik
Write-Host "`nData URI gotowy do użycia w CSS:`n" -ForegroundColor Green
Write-Host $dataUri
Write-Host "`n"

# Zapisz do pliku tekstowego
$outputPath = [System.IO.Path]::ChangeExtension($SvgPath, ".datauri.txt")
$dataUri | Out-File -FilePath $outputPath -Encoding UTF8
Write-Host "Zapisano również do pliku: $outputPath" -ForegroundColor Cyan

# Skopiuj do schowka
$dataUri | Set-Clipboard
Write-Host "Data URI skopiowano do schowka!" -ForegroundColor Yellow
