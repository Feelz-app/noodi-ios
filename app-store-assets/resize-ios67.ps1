Add-Type -AssemblyName System.Drawing
$srcDir = "C:\Users\maasv\OneDrive\Documents\New project 3\app-store-assets\raw"
$dstDir = "C:\Users\maasv\OneDrive\Documents\New project 3\app-store-assets\ios-6.7"
$targetW = 1290
$targetH = 2796
$i = 1
Get-ChildItem -Path $srcDir -File | Sort-Object Name | ForEach-Object {
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
      $outName = ('noodi-ios67-{0:00}.png' -f $i)
      $outPath = Join-Path $dstDir $outName
      $bmp.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
      $i++
    } finally {
      $g.Dispose()
      $bmp.Dispose()
    }
  } finally {
    $img.Dispose()
  }
}
Get-ChildItem -Path $dstDir -File | Select-Object Name,Length