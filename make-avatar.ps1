# Renders the WinSoftLabs30 "WS" avatar as a square PNG.
# Deterministic: no network, no downloaded fonts. Draws each glyph separately so the
# pair is optically kerned instead of using the font's default advance widths.
param(
  [string]$FontName = 'Arial Black',
  [string]$Background = '#12161C',
  [string]$Foreground = '#F5F7FA',
  [int]$Size = 1024,
  [double]$Tracking = 0.005,   # positive = looser, fraction of the em size
  [string]$Out = (Join-Path $PSScriptRoot 'avatar.png')
)

Add-Type -AssemblyName System.Drawing

$glyphs = @('W', 'S')

# GenericTypographic returns tight ink bounds; the default format pads every string,
# which is what made the W and S look far apart.
$measureFmt = [System.Drawing.StringFormat]::GenericTypographic.Clone()
$measureFmt.Alignment = [System.Drawing.StringAlignment]::Near
$measureFmt.LineAlignment = [System.Drawing.StringAlignment]::Near

$drawFmt = [System.Drawing.StringFormat]::GenericTypographic.Clone()
$drawFmt.Alignment = [System.Drawing.StringAlignment]::Near
$drawFmt.LineAlignment = [System.Drawing.StringAlignment]::Near

$bmp = New-Object System.Drawing.Bitmap($Size, $Size)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

$maxWidth = $Size * 0.68
$maxHeight = $Size * 0.68
$px = [int]($Size * 0.46)
$font = $null

while ($px -gt 20) {
  if ($font) { $font.Dispose() }
  $font = New-Object System.Drawing.Font($FontName, $px, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)

  $widths = @()
  $heights = @()
  foreach ($ch in $glyphs) {
    $s = $g.MeasureString($ch, $font, [int]($Size * 2), $measureFmt)
    $widths += $s.Width
    $heights += $s.Height
  }
  $totalWidth = ($widths | Measure-Object -Sum).Sum + ($Tracking * $px * $glyphs.Count)
  $maxH = ($heights | Measure-Object -Maximum).Maximum

  if ($totalWidth -le $maxWidth -and $maxH -le $maxHeight) { break }
  $px = [int]($px * 0.96)
}

$g.Clear([System.Drawing.ColorTranslator]::FromHtml($Background))
$brush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($Foreground))

$x = ($Size - $totalWidth) / 2
$y = ($Size - $maxH) / 2

for ($i = 0; $i -lt $glyphs.Count; $i++) {
  $rect = New-Object System.Drawing.RectangleF([float]($x - 2), [float]($y - 2), [float]($widths[$i] + 8), [float]($maxH + 8))
  $g.DrawString($glyphs[$i], $font, $brush, $rect, $drawFmt)
  $x += $widths[$i] + ($Tracking * $px)
}

$g.Dispose()
$bmp.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
$bmp.Dispose()
$font.Dispose()
$brush.Dispose()
$drawFmt.Dispose()
$measureFmt.Dispose()

$info = Get-Item $Out
Write-Output ("ok  {0}  {1}x{2}  {3} bytes  font={4} {5}px  ink={6:n0}px" -f $info.Name, $Size, $Size, $info.Length, $FontName, $px, $totalWidth)
