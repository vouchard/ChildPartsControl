#Feeder Library

function feederLibrary{
param($mainCsv)
$frm_fl = makeForm -size_x 900 -size_y 700 -text "$mainCsv"
$frm_fl.startPosition = "CenterScreen"
$dgv_feederLib = makeGridView -size_x 605 -size_y 500 -loc_x 50 -loc_y 120
$dgv_feederLib.columnCount = 3
$dgv_feederLib.columns[0].Name = "Feeder Location"
$dgv_feederLib.columns[1].Name = "Feeder Barcode"
$dgv_feederLib.columns[2].Name = "Current Part"
$dgv_feederLib.columns[0].width = 185
$dgv_feederLib.columns[1].width = 200
$dgv_feederLib.columns[2].width = 200
$dgv_feederLib.font =  New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)
$dgv_feederLib.SELECTIONMODE = "fuLLROWSELECT"
$dgv_feederLib.readonly = $true
$dgv_feederLib.multiselect = $false


$lb_scn = makelabel 250 25 45 40 "Scan Feeder Barcode"
$lb_scn.textalign = "middleLeft"
$lb_scn.borderstyle = 0
$lb_scn.font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)

$tb_scn= makeTextbox 250 15 45 70 ""
$tb_scn.textalign = [System.Windows.Forms.HorizontalAlignment]::Center
$tb_scn.font =  New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)
$tb_scn.tabindex = 0

$lb_scn2 = makelabel 250 25 300 40 "Scan New Part"
$lb_scn2.textalign = "middleLeft"
$lb_scn2.borderstyle = 0
$lb_scn2.font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)

$tb_scn2 = makeTextbox 250 15 300 70 ""
$tb_scn2.textalign = [System.Windows.Forms.HorizontalAlignment]::Center
$tb_scn2.font =  New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)
$tb_scn2.tabindex = 1



$a = import-csv "$masterPath\feederdb\feederdb.csv" -Header "0","1","2"|Select-Object -Skip 1
$ln = @()
$dgv_feederLib.rows.clear
$dgv_feederLib.rows.add("")
$dgv_feederLib.rows[0].HEIGHT = 0



foreach ($aa in $a){
    $ln = $aa.'0',$aa.'1',$aa.'2'
    $dgv_feederLib.rows.add($ln)

}





$tb_scn.add_textchanged({
if (($tb_scn.text).length -ge 10) {
    
    $tb_scn2.focus()

}})
$tb_scn2.add_textchanged({
if (($tb_scn2.text).length -eq 10) {
    
    $csv = Import-Csv "$masterPath\feederdb\feederdb.csv" -Header "0","1","2"|Select-Object -Skip 1
    $line = $csv|Where-Object {$_.'1' -eq ($tb_scn.text)}
	$fnn = $line.'1'
	$fnloc = $line.'0'
	$oldbcd = $line.'2'
    $line.'2' = $tb_scn2.TEXT
	$newbcd = $tb_scn2.TEXT
    $csv|Export-Csv "$masterPath\feederdb\feederdb.csv" -NoTypeInformation

    $a = import-csv "$masterPath\feederdb\feederdb.csv" -Header "0","1","2"|Select-Object -Skip 1
    $ln = @()
    $dgv_feederLib.rows.clear()
    $dgv_feederLib.rows.add("")
    $dgv_feederLib.rows[0].HEIGHT = 0
    foreach ($aa in $a){
    $ln = $aa.'0',$aa.'1',$aa.'2'
    $dgv_feederLib.rows.add($ln)
    }

  
$msg = "modify feeder Library: $fnn ($fnloc) $oldbcd to $newbcd"
$now = get-date
$usr = $global:UserNow
$ln = $cb_line.Text

outLogs -loc "$mastershared\logs\sysLogs\$ln\" -line "$now,$msg,$usr"
$tb_scn2.text = ""	
$tb_scn.text = ""
$tb_scn.focus()

Write-Host $msg
}})


$frm_fl.add_shown({$tb_scn2.focus})


$frm_fl.controls.add($lb_scn2)
$frm_fl.controls.add($tb_scn2)
$frm_fl.controls.add($lb_scn)
$frm_fl.controls.add($tb_scn)
$frm_fl.controls.add($dgv_feederLib)
$frm_fl.showdialog()













}