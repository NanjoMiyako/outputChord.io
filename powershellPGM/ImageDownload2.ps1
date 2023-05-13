Invoke-WebRequest -Uri "https://www.ady.co.jp/song-chord/piano-guitar/C.gif" -OutFile "C:\hogehoge\Desktop\powerShellScript\ImageDownload\out2.jpg"

$matubi1 = @("", "7", "minor", "minor7", "major7", "minormajor7", "sus4", "7sus4", "dim", "minor7-5", "aug", "add9", "6", "minor6")
$root1 = @("C", "D", "E", "F", "G", "A", "B");
$sharp_flat_matubi2 = @("sharp", "flat");



function makeCodeName($matubi1, $root1, $sharp_flat_matubi2){

    $out1 = @();

    for($i=0; $i -lt $root1.Length; $i++){

        for($j=0; $j -lt $matubi1.Length; $j++){

            $out2 = "";
            $out2 += $root1[$i];
            $out2 += $matubi1[$j];

            $out1 +=  $out2
        }
    }


    Write-output $out1
}

function makeCodeName2($matubi1, $root1, $sharp_flat_matubi2){
    $out1 = @();


    for($i=0; $i -lt 2; $i++){
        for($j=0; $j -lt $matubi1.Length; $j++){
            $sR = $root1[$i];
            $fR = $root1[($i + 1)];


            $out2 = "";
            $out2 += $sR
            $out2 +="sharp"
            $out2 += $matubi1[$j]
            $out2 += "_"
            $out2 += $fR
            $out2 +="flat"
            $out2 += $matubi1[$j]

            $out1 += $out2;
        }
    }

    for($i=3; $i -lt 6; $i++){
        for($j=0; $j -lt $matubi1.Length; $j++){
            $sR = $root1[$i];
            $fR = $root1[($i + 1)];

            $out2 = "";
            $out2 += $sR
            $out2 +="sharp"
            $out2 += $matubi1[$j]
            $out2 += "_"
            $out2 += $fR
            $out2 += "flat"
            $out2 += $matubi1[$j]

            $out1 += $out2;

        }
    }

    Write-Output $out1
}
$ret = makeCodeName $matubi1 $root1 $sharp_flat_matubi2

Write-Host $ret

write-host "---"

$ret2 = makeCodeName2 $matubi1 $root1 $sharp_flat_matubi2

Write-Host $ret2

for($i=0; $i -lt $ret.Length; $i++){
    $outFname  = "C:\hogehoge\Desktop\powerShellScript\ImageDownload\out1-1\"
    $outFname += $ret[$i];
    $outFname += ".jpg"

    $dUri =  "https://www.ady.co.jp/song-chord/piano-guitar/";
    $dUri += $ret[$i];
    $dUri += ".gif"

    # write-host $dUri
    # write-host $outFname
    Invoke-WebRequest -Uri $dUri -OutFile $outFname

}

for($i=0; $i -lt $ret2.Length; $i++){
    $outFname  = "C:\hogehoge\Desktop\powerShellScript\ImageDownload\out1-2\"
    $outFname += $ret2[$i];
    $outFname += ".jpg"

    $dUri =  "https://www.ady.co.jp/song-chord/piano-guitar/";
    $dUri += $ret[$i];
    $dUri += ".gif"

    # write-host $dUri
    # write-host $outFname
    Invoke-WebRequest -Uri $dUri -OutFile $outFname

}