#model Library
function showModelLib{
$frm_modelLib  = makeform -size_x 1000 -size_y 700
$frm_modelLib.startPosition = "CenterScreen"
$dgv_modelLib = makeGridView -size_x 900 -size_y 500 -loc_x 50 -loc_y 80
$dgv_modelLib.ColumnCount = 9
#$dgv_modelLib.columns[0].Name = "Request"
$dgv_modelLib.columns[0].Name = "Feeder Location"
$dgv_modelLib.columns[1].Name = "Main Part No."
$dgv_modelLib.columns[2].Name = "Alernate Part No. 1"
$dgv_modelLib.columns[3].Name = "Alernate Part No. 2"
$dgv_modelLib.columns[4].Name = "Alernate Part No. 3"
$dgv_modelLib.columns[5].Name = "Alernate Part No. 4"
$dgv_modelLib.columns[6].Name = "Alernate Part No. 5"
$dgv_modelLib.columns[7].Name = "Alernate Part No. 6"
$dgv_modelLib.columns[8].Name = "Alernate Part No. 7"
$dgv_modelLib.columns[0].width = 70
$dgv_modelLib.columns[1].width = 80
$dgv_modelLib.columns[2].width = 110
$dgv_modelLib.columns[3].width = $dgv_modelLib.columns[2].width
$dgv_modelLib.columns[4].width = $dgv_modelLib.columns[2].width
$dgv_modelLib.columns[5].width = $dgv_modelLib.columns[2].width
$dgv_modelLib.columns[6].width = $dgv_modelLib.columns[2].width
$dgv_modelLib.columns[7].width = $dgv_modelLib.columns[2].width
$dgv_modelLib.columns[8].width = $dgv_modelLib.columns[2].width
#$dgv_modelLib.columns[9].width = $dgv_modelLib.columns[2].width
$dgv_modelLib.columns[0].readonly = $true
$dgv_modelLib.ColumnHeadersHeight = 70

$dgv_modelLib.font =  New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)
$dgv_modelLib.SELECTIONMODE = "fuLLROWSELECT"
$dgv_modelLib.multiselect = $false

$btn_NewModel = makeButton -size_x 100 50 600 10 "New Model"

$cb_choose = makecombobox -size_x 300 -size_y 20 -loc_x 50 -loc_y 10 
$cb_choose.Items.Clear()
$items = Get-ChildItem -Path "$masterpath\modeldb\" -Exclude "bom.tmp"
foreach ($aa in $items) {$b = (get-item ($aa.fullname)).basename;$cb_choose.Items.add($b)}
$btn_NewModel.add_Click({
databaseCreation
})
$cb_choose.add_textChanged({
$ln =@()
$mdName  = $cb_choose.text
$asd = Test-Path ("$masterPath\modeldb\$mdName.txt")
if ($asd -eq $true){
    $header = "0","1","2","3","4","5","6","7","8"
    $dgv_modelLib.rows.clear()

$db = import-csv "$masterpath\modeldb\$mdName.txt" -Header $header
    foreacH($aa in $db){

        $ln = $aa.'0',$aa.'1',$aa.'2',$aa.'3',$aa.'4',$aa.'5',$aa.'6',$aa.'7',$aa.'8'
        if ($ln -ne ""){$dgv_modelLib.rows.add($ln)}
        
        
            }


    }



})   
$dgv_modelLib.add_CellValueChanged({
param([object]$sender,[object]$e)
$fname = $cb_choose.text
$header = "0","1","2","3","4","5","6","7","8"
$csv = import-csv "$masterpath\modeldb\$fName.txt" -Header $header
$fl = $dgv_modelLib.currentRow.cells[0].value
$cl = $e.columnIndex
$ln = $csv|Where-Object{$_.'0' -eq $fl}
$ln."$cl" = $dgv_modelLib.currentRow.cells[$cl].value
""|out-file "$masterpath\modeldb\$fName.txt"
foreach($cs in $csv){
$0 = $cs.'0'
$1 = $cs.'1'
$2 = $cs.'2'
$3 = $cs.'3'
$4 = $cs.'4'
$5 = $cs.'5'
$6 = $cs.'6'
$7 = $cs.'7'
$8 = $cs.'8'

$line = "$0,$1,$2,$3,$4,$5,$6,$7,$8"
$line|out-file "$masterpath\modeldb\$fName.txt" -Append

}
$msg = "modify model Library"
$now = get-date
$usr = $global:UserNow
$ln = $cb_line.Text
outLogs -loc "$mastershared\logs\sysLogs\$ln\" -line "$now,$msg,$usr"

})

$frm_modelLib.controls.add($btn_newModel)
$frm_modelLib.controls.add($cb_choose)
$frm_modelLib.controls.add($dgv_modelLib)
$frm_modelLib.showdialog()
}