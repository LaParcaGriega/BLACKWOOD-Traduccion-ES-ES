$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$prefix = 'BLACKWOOD_ES_ES_TIENDA_DVD_SEGURA_V13_payload.zip.'
$zip = Join-Path $root 'BLACKWOOD_ES_ES_TIENDA_DVD_SEGURA_V13_payload.zip'
$parts = 1..5 | ForEach-Object { Join-Path $root ($prefix + ('{0:D3}' -f $_)) }
$out = [System.IO.File]::Create($zip)
try {
    foreach ($part in $parts) {
        if (-not (Test-Path -LiteralPath $part)) { throw "Falta el archivo: $part" }
        $input = [System.IO.File]::OpenRead($part)
        try { $input.CopyTo($out) } finally { $input.Dispose() }
    }
} finally { $out.Dispose() }
$hash = (Get-FileHash -LiteralPath $zip -Algorithm SHA256).Hash.ToLowerInvariant()
if ($hash -ne '88c29acabee2e5c23aa4ed11fa68375ed291ca8338fbaab954ce224ece0f0344') {
    throw "SHA-256 incorrecto. Se ha detenido la instalación para proteger los archivos."
}
$extract = Join-Path $env:TEMP ('BLACKWOOD_ES_V104_' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $extract | Out-Null
Expand-Archive -LiteralPath $zip -DestinationPath $extract -Force
& (Join-Path $extract 'installer.ps1')
