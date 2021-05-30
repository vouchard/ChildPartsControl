#model Library
function showPartsLib{
$frm_modelLib  = makeform -size_x 600 -size_y 700
$frm_modelLib.startPosition = "CenterScreen"
$dgv_modelLib = makeGridView -size_x 450 -size_y 500 -loc_x 50 -loc_y 80
$dgv_modelLib.ColumnCount = 3
#$dgv_modelLib.columns[0].Name = "Request"
$dgv_modelLib.columns[0].Name = "PART NO"
$dgv_modelLib.columns[1].Name = "MFG PART NO"
$dgv_modelLib.columns[2].Name = "QUANTITY"
$dgv_modelLib.columns[0].width = 110
$dgv_modelLib.columns[1].width = 200
$dgv_modelLib.columns[2].width = 110
$dgv_modelLib.ColumnHeadersHeight = 70

$dgv_modelLib.font =  New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)
$dgv_modelLib.SELECTIONMODE = "fuLLROWSELECT"
$dgv_modelLib.multiselect = $false
$header = "0","1","2"
$btn_save = makeButton -size_x 100 50 400 10 "SAVE"
$db = import-csv "$masterShared\partsdb\partsdb.csv" -Header $header 
    foreacH($aa in $db){

        $ln = $aa.'0',$aa.'1',$aa.'2'
        if ($ln -ne ""){$dgv_modelLib.rows.add($ln)}
        
            }




$btn_save.add_click({
""|out-file "$masterShared\partsdb\partsdb.csv"
$rw  =($dgv_modelLib.rowcount) - 1
for ($i = 0;$i -le $rw;$i++){
$pn = $dgv_modelLib.rows[$i].cells[0].value
$mpn = $dgv_modelLib.rows[$i].cells[1].value
$qt = $dgv_modelLib.rows[$i].cells[2].value

$lin = -join($pn,",",$mpn,",",$qt)
$lin|out-file "$masterShared\partsdb\partsdb.csv" -Append

#$lin|out-file C:\users\110049\Desktop\sample.txt -Append
}

$msg = "modify parts library"
$now = get-date
$usr = $global:UserNow
outLogs -loc "$masterShared\logs\libAccess\" -line "$now,$msg,$usr"


})






 




$frm_modelLib.controls.add($btn_save)
$frm_modelLib.controls.add($cb_choose)
$frm_modelLib.controls.add($dgv_modelLib)
$frm_modelLib.showdialog()
}