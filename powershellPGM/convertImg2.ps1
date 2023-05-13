
function convertImg($sourceImgURL, $outFilePath){
#SendKeysを使うため、System.Windows.Forms名前空間読込
Add-Type -AssemblyName System.Windows.Forms
Start-Sleep -m 500

#[ctrl] + [o]
[System.Windows.Forms.SendKeys]::SendWait("^o")
Start-Sleep -m 500

[System.Windows.Forms.SendKeys]::SendWait($sourceImgURL)
Start-Sleep -m 1000

#[enter]
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -m 500

#[ctrl] + [a]
[System.Windows.Forms.SendKeys]::SendWait("{F12}")
Start-Sleep -m 500


[System.Windows.Forms.SendKeys]::SendWait($outFilePath)
Start-Sleep -m 1000

#[tab]
[System.Windows.Forms.SendKeys]::SendWait("{TAB}")
Start-Sleep -m 500

#[down arrow]
[System.Windows.Forms.SendKeys]::SendWait("{DOWN}")
Start-Sleep -m 500

#[up arrow]
[System.Windows.Forms.SendKeys]::SendWait("{UP}")
Start-Sleep -m 500

#[enter]
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -m 500

#[enter]
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -m 500

}

$arr = Get-Content "C:\hogehoge\Desktop\powerShellScript\ImageDownload\test2.txt"

mspaint
foreach ($str1 in $arr) {
  $str2 = $str1.Replace('out1-1', 'out2-2');

  convertImg $str1 $str2
}
