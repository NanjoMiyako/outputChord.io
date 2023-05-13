$line= "A#mM7"
$line="CmM7"

function ReplaceOneChord($ChordName){

    $line = $ChordName

    $repline = $line
    if($repline.Length -ge 2){
        $subStr1 = $repline.Substring(1,1)
    }else{
        return $repline
    }
    $repline2 = $line
    $repline2 = $repline2.Replace("#", "");
    $repline2 = $repline2.Replace("♭","")
    if($repline2.Length -ge 2){
        $subStr2 = $repline2.Substring(1,$repline2.Length-1)
    }else{
        $subStr2 =""
    }

    if($subStr1 -eq "#"){
        $repline = $repline.Replace("C#", "C#_D♭")
        $repline = $repline.Replace("D#", "D#_E♭")
        $repline = $repline.Replace("F#", "F#_G♭")
        $repline = $repline.Replace("G#", "G#_A♭")
        $repline = $repline.Replace("A#", "A#_B♭")

        $repline = $repline.Substring(0,5)

        $addStr = "#"+$subStr2
        $repline = $repline.Replace("#", $addStr);

        $addStr = "♭"+$subStr2
        $repline = $repline.Replace("♭", $addStr);

        $repline = $repline.Replace("m","minor");
        $repline = $repline.Replace("M", "major");


    }elseif($subStr1 -eq "♭"){
        $repline = $repline.Replace("D♭", "C#_D♭")
        $repline = $repline.Replace("E♭", "D#_E♭")
        $repline = $repline.Replace("G♭", "F#_G♭")
        $repline = $repline.Replace("A♭", "G#_A♭")
        $repline = $repline.Replace("B♭", "A#_B♭")

        $repline = $repline.Substring(0,5)

        $addStr = "#"+$subStr2
        $repline = $repline.Replace("#", $addStr);

        $addStr = "♭"+$subStr2
        $repline = $repline.Replace("♭", $addStr);

        $repline = $repline.Replace("m","minor");
        $repline = $repline.Replace("M", "major");

    }else{
        $repline = $repline.Replace("m","minor");
        $repline = $repline.Replace("M", "major");
    }


    $repline = $repline.Replace("#", "sharp")
    $repline = $repline.Replace("♭", "flat")
    return $repline

}

$val1 = ReplaceOneChord $line

$inputfilePath = "C:\hogehoge\Desktop\powerShellScript\replaceGakufu\TestGakufu2.TXT"
$outputfilePath = "C:\hogehoge\Desktop\powerShellScript\replaceGakufu\outputTest2.TXT"
$arr = Get-Content $inputfilePath

foreach($line in $arr){
    $repline2 = ReplaceOneChord $line
    Add-Content $outputfilePath $repline2
}