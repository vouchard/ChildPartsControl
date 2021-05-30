#partsChecking
function findFeederLoc{
param($bcd)
$fl = import-csv "$masterPath\feederdb\feederdb.csv"
$res = $fl|Where-Object {$_.'1' -eq $bcd}
$res = $res.'0'
if ($res -eq $null){
    $res  ="NG"
    }
$res
   
}


function CheckParts{
param($model)
$frm = makeform -size_x 440 -size_y 410
$frm.startPosition = "CenterScreen"
$frm.BACKcOLOR = "lIGHTbLUE"

$lb3 = makeLAbel -size_x 400 -size_y 30 -loc_x 10 -loc_y 10 -text "PARTS CHECKING"
$tb1 = maketextbox -size_x 400 -size_y 150 -loc_x 10 -loc_y 80
$lb1 = makeLAbel -size_x 200 -size_y 20 -loc_x 10 -loc_y 60 -text "Feeder Location"
$tb2 = maketextbox -size_x 400 -size_y 150 -loc_x 10 -loc_y 170
$lb2 = makeLAbel -size_x 100 -size_y 20 -loc_x 10 -loc_y 150 -text "Part Barcode"
$lbjudge= makeLAbel -size_x 400 -size_y 120 -loc_x 10 -loc_y 220 -text "OK"
$lbLoc = makeLAbel -size_x 200 -size_y 20 -loc_x 200 -loc_y 60 -text "0"
$lbPN = makeLAbel -size_x 100 -size_y 20 -loc_x 130 -loc_y 150 -text "Part No."





$lb3.BorderStyle = 0
$lb2.BorderStyle = 0
$lb1.BorderStyle = 0
$lbLoc.BorderStyle = 0
$lbPN.BorderStyle = 0
$Lb1.Font =New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Italic)
$Lb2.Font =New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Italic)
$lb1.TextAlign = "MiddleLeft"
$lb2.TextAlign = "MiddleLeft"
$lb3.TextAlign = "MiddleLeft"
$lbLoc.TextAlign = "MiddleLeft"
$lbPN.TextAlign = "MiddleLeft"
$lbjudge.TEXTALIGN = "MiddleCenter"
$lbjudge.Font =New-Object System.Drawing.font("Century Gothic",70,[System.Drawing.FontStyle]::BOLD)
$lbLoc.Font =New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Italic)
$lbPN.Font =New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Italic)
$lbjudge.visible = $false
$tb1.TabStop = $false
$tb2.tabindex = 0

$csv = Import-Csv "$masterPath\modeldb\$model.txt" -Header "0","1","2","3","4","5","7","8"
$tb1.ReadOnly = $true
$csv_index = [int]$lbLoc.text
$tb1.Text = $csv[$csv_index].0

$tb2.text = "asd"
$tb2.focus()
<#
$tb1.add_textchanged({
$tx = $tb1.text
#$frm.backColor = "LightBlue"
if($tx.length -ge 10){
$lbjudge.visible = $false
$lbLoc.text = findfeederloc -bcd $tx
$tb2.focus()
}
})
#>

$tb2.add_textchanged({
$tx2 = $tb2.text
    $csv_index = [int]$lbLoc.text
    if($tx2.length -ge 10){
    $res = ""
    $fdrDb = import-csv "$masterPath\feederdb\feederdb.csv"
    $bcd = ($fdrDb|Where-Object{$_.'0' -eq $tb1.text}).'2'

    if ($bcd -ne $tx2){$res = "Wrong Feeder Part|"} # NG Trigger

        if (test-path "E:\Shared\Barcodes\$tx2.txt"){
            $pn = Get-Content "E:\Shared\Barcodes\$tx2.txt"
            $lbPn.text = $pn
            }else{$res = "$res barcode NG|"}
        
    #$ln = $csv|Where-Object{$_.'0' -eq $lbLoc.text}
    $ln = $csv[$csv_index]
    $tst = $true
    $iss = $pn
    write-host("Scanned: $iss | Index:$csv_index")

    if ($iss -ne "DEFAULT"){
        $tst = ($ln.'1' -eq $iss) -or ($ln.'2' -eq $iss) -or ($ln.'3' -eq $iss) -or ($ln.'4' -eq $iss) -or ($ln.'5' -eq $iss) -or ($ln.'6' -eq $iss) -or ($ln.'7' -eq $iss) -or ($ln.'8' -eq $iss)
    }

    if ($tst -eq $false){$res = "$res Not in Bom"}

    $logpath  = "E:\Shared\logs\partschecking\"
  

    if ($res -eq ""){
    $lbjudge.visible = $true
    if ($frm.backColor -eq "LightGreen"){$frm.backColor  = "Lime"}else{$frm.backColor ="lightGreen"}
    $lbjudge.text = "OK"
    $res = "OK"
    $frm.text = "OK"    
    $lbLoc.text = [int]$lbLoc.text + 1
    }else{

    $lbjudge.visible = $true
    $frm.backColor = "Red"
    $lbjudge.text = "NG"
    $frm.text = $res    
    msgbox $res
    }

      $now = get-date
    $feederBarcode = $tb1.text
    $feederLoc = $lbLoc.Text
    $currentPartBarcode = $bcd
    $scannedPartBarcode = $tb2.text
    $jud = $lbjudge.text
    $pic = $Global:userNow
    $line = "$now,$feederBarcode,$feederLoc,$currentPartBarcode,$scannedPartBarcode,$res,$pic"
    outlogs -loc $logpath -line "$line"


    $tb1.Text = $csv[([int]$lbLoc.text)].0




#        $tb1.text = ""
        $tb2.text = ""

      
       
    }
 
})



$frm.controls.add($lbPN)
$frm.controls.add($lbLoc)
$frm.controls.add($lbjudge)
$frm.controls.add($lb2)
$frm.controls.add($tb2)
$frm.controls.add($lb3)
$frm.controls.add($lb1)
$frm.controls.add($tb1)
$frm.showdialog()

}