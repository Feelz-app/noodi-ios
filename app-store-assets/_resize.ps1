Add-Type -AssemblyName System.Drawing
$srcDir = "C:\Users\maasv\OneDrive\Documents\New project 3\app-store-assets\raw"
$dstDir = "C:\Users\maasv\OneDrive\Documents\New project 3\app-store-assets\ios-6.7"
$targetW = 1290
$targetH = 2796
Get-ChildItem -Path $srcDir -File | ForEach-Object {
  $img = [System.Drawing.Image]::FromFile($_.FullName)
  try {
    $scale = [Math]::Min($targetW / $img.Width, $targetH / $img.Height)
    $newW = [int][Math]::Round($img.Width * $scale)
    $newH = [int][Math]::Round($img.Height * $scale)
    $bmp = New-Object System.Drawing.Bitmap($targetW, $targetH)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    try {
      $g.Clear([System.Drawing.Color]::FromArgb(3,3,4))
      $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
      $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
      $x = [int](($targetW - $newW) / 2)
      $y = [int](($targetH - $newH) / 2)
      $g.DrawImage($img, $x, $y, $newW, $newH)
      $outPath = Join-Path $dstDir ($_.BaseName + "-1290x2796.png")
      $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
    } finally {
      $g.Dispose()
      $bmp.Dispose()
    }
  } finally {
    $img.Dispose()
  }
}