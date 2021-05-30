
function changeModel{

$mdlchange = New-Object System.Windows.Forms.form
$mdlchange.size = New-Object System.Drawing.Size(800,600)
$mdlchange.StartPosition ="CenterScreen"

$lb2 = New-Object System.Windows.Forms.Label
$lb2.text = "NEW MODEL: "
$lb2.Font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)
$lb2.Size = New-Object System.Drawing.Size(150,30)
$lb2.Location = New-Object System.Drawing.Point(50,30)
$lb2.BorderStyle = 1

$cb = New-Object System.Windows.Forms.ComboBox
$cb.text = "Choose Model Here"
$cb.Font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)
$cb.Size = New-Object System.Drawing.Size(350,30)
$cb.Location = New-Object System.Drawing.Point(200,30)

$btn = New-Object System.Windows.Forms.Button
$btn.text = "INITIALIZE"
$btn.Font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::BOLD)
$btn.Size = New-Object System.Drawing.Size(500,30)
$btn.Location = New-Object System.Drawing.Point(50,60)

$btnOK = New-Object System.Windows.Forms.Button
$btnOK.text = "CHANGE"
$btnOK.Font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::BOLD)
$btnOK.Size = New-Object System.Drawing.Size(150,70)
$btnOK.Location = New-Object System.Drawing.Point(560,20)
$btnOk.Enabled = $FALSE





$dgvbtn = new-object system.windows.forms.dataGridViewButtonColumn
#$dgvbtn.FlatStyle = "popup"
$dgv = New-Object System.Windows.Forms.DataGridView
$dgv.Width = 650
$dgv.Height = 300

$dgv.Location = New-Object System.Drawing.Point(50,100)
$dgv.columnCOunt = 3
$dgv.Columns.Add($dgvBtn)|Out-Null
$dgv.columns[0].name = "Feeder Location"
$dgv.columns[1].name = "Current Barcode"
$dgv.columns[2].name = "Current Part"

$dgv.columns[0].width = 106
$dgv.columns[1].width = 196
$dgv.columns[2].width = 150
$dgv.columns[3].width = 180

$dgv.RowHeadersVisible = $FALSE
$dgv.BackgroundColor = $mdlchange.BackColor
$dgv.font =  New-Object System.Drawing.font("Century Gothic",9,[System.Drawing.FontStyle]::BOLD)
$dgv.BorderStyle = 0



function getBarcode{
param($FL)

$fdr = Import-Csv "$masterPath\feederdb\feederdb.csv" -Header "0","1","2"|Select-Object -Skip 1
$bcd = $fdr|Where-Object {$_.'0' -eq $FL}
$bcd = $bcd.'2'
$bcd        
      
}
function getBarcodeContent{
param($bcd)
$tst = Test-Path "$masterShared\Barcodes\$bcd.txt"

if ($tst){
    $pn = Get-Content "$masterShared\Barcodes\$bcd.txt"
    }else{
    #msgbox "BARCODES WAS NOT REGISTERED BY PDC"
    $pn = "NG Barcode"
    
    }

    [string]$pn
   
}
function judgePart{
param($csv,$fl,$iss)
    if ($iss -eq "DEFAULT"){$res = "Start-up Only"}else{
        
        $dbC = $csv
        $ln = $dbC|Where-Object{$_.'0' -eq $fl}
        if (($ln.'2' -eq $iss) -or ($ln.'3' -eq $iss) -or ($ln.'4' -eq $iss) -or ($ln.'5' -eq $iss) -or ($ln.'6' -eq $iss) -or ($ln.'7' -eq $iss) -or ($ln.'8' -eq $iss))
            {$res = "Alt Part"}else{
            if ($ln."1" -eq $iss){$res = "Main Part"}else{
                $res = "Wrong Part"}
                }
                 }
                $res
        }


        
#addingm models on combobox
$cb.Items.Clear()
$items = Get-ChildItem -Path "$masterpath\modeldb\" -Exclude "bom.tmp"

foreach ($aa in $items) {$b = (get-item ($aa.fullname)).basename;$cb.Items.add($b)|Out-Null}
   


$btn.add_click({
$mdl = $cb.Text
$dbContent = Import-Csv "$masterPath\modeldb\$mdl.txt" -Header "0","1","2","3","4","5","7","8"
$dgv.Rows.Clear()
foreach ($lnn in $dbContent){
        $fd = $lnn.'0'
        if (($fd -ne "") -and ($fd -ne $null)){
            $fdbcd = getbarcodE -FL $fd
            $bcdprt = getBarcodeContent -bcd $fdbcd
            $judge = judgePart -csv $dbContent -fl $fd -iss $bcdprt
     
                $dgv.Rows.Add($fd,$fdbcd,$bcdprt,$judge)
                }
 }

 $ctr = 0
$rowcount = $dgv.rowcount
for($i = 0;$i -le $rowcount - 1; $i++){
           if ($dgv.rows[$i].cells[3].Value -eq "Wrong Part"){
             $dgv.rows[$i].cells[0].Style.BackColor = "RED"           
             $dgv.rows[$i].cells[1].Style.BackColor = "RED"
             $dgv.rows[$i].cells[2].Style.BackColor = "RED"
             $dgv.rows[$i].cells[3].Style.BackColor = "RED"
             $dgv.rows[$i].cells[0].Style.foreColor = "Yellow"           
             $dgv.rows[$i].cells[1].Style.foreColor = "Yellow"
             $dgv.rows[$i].cells[2].Style.foreColor = "Yellow"
             $dgv.rows[$i].cells[3].Style.foreColor = "Yellow"
             $ctr++

             $a = $dgv.rows[$i].cells[0].Value
             $b = $dgv.rows[$i].cells[1].Value
             $c = $dgv.rows[$i].cells[2].Value
             $now = (Get-Date).ToString()
             $msg = "$now,New Model Initialization Error $a $b $c"

             outLogs -loc "$masterShared\logs\sysLogs\$ln\" -line $msg
            toprompt -msg  "error in model Initialization $ctr"


            }else{
             $dgv.rows[$i].cells[0].Style.BackColor = "LightGREEN"           
             $dgv.rows[$i].cells[1].Style.BackColor = "LightGREEN"
             $dgv.rows[$i].cells[2].Style.BackColor = "LightGREEN"
             $dgv.rows[$i].cells[3].Style.BackColor = "LightGREEN"
             }
    }
    $dgv.Sort($dgv.columns[3],"descending")
    if ($ctr -eq 0){$btnOK.Enabled = $true}else{$btnOK.Enabled = $false}
})
$dgv.add_cellClick({
param([object]$sender,[object]$e)
if ($e.rowIndex -ne -1){
    if($e.columnIndex -eq 3){
        changeBarcode -fl $dgv.CurrentRow.Cells[0].Value

    }}
})
$btnOK.add_click({

$ln = $cb_line.Text
$now = (get-date).ToString()
$oldMOdel = $lb_model.Text
$NewModel = $cb.Text
$msg = "$now,Model Changed $oldmodel to $newModel"

outLogs -loc "$mastershared\logs\syslogs\$ln\" -line $msg

$lb_model.Text = $cb.Text

toprompt -msg "Model Change  $msg"



$mdlchange.Dispose()
})



$mdlchange.controls.add($dgv)
$mdlchange.Controls.Add($btn)
$mdlchange.Controls.Add($cb)
$mdlchange.Controls.Add($lb2)
$mdlchange.Controls.Add($btnOK)
$mdlchange.ShowDialog()

}

function changeBarcode{
param($fl)
$lo = [System.Windows.Forms.Cursor]::Position
$asd = New-Object System.Windows.Forms.Form
$asd.Text = "New Barcode"
$tb = New-Object System.Windows.Forms.TextBox
$tb.Font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)
$tb.Width = $asd.Width
$asd.size = New-Object System.Drawing.Size(230,70)
$asd.StartPosition = "manual"
$asd.Location = $lo



$tb.add_textchanged({
    if ($tb.TextLength -eq 10){
    $csv = Import-Csv "$masterPath\feederdb\feederdb.csv" -Header "0","1","2"|Select-Object -Skip 1
    $line = $csv|Where-Object {$_.'0' -eq $fl}
	$fnn = $line.'1'
	$fnloc = $line.'0'
	$oldbcd = $line.'2'
    $line.'2' = $tb.TEXT
	$newbcd = $tb_scn2.TEXT
    $csv|Export-Csv "$masterPath\feederdb\feederdb.csv" -NoTypeInformation
    $tb.Text = ""

    $ln = $cb_line.Text
   $now = (Get-Date).ToString()
    $msg = "$now,Modified Previous Barcode $fnn $fnloc $oldbcd $newbcd"
    outLogs -loc "$mastershared\logs\sysLogs\$ln\" -line $msg

    toprompt -msg $msg



    }
})





$asd.controls.add($tb)
$asd.showdialog()
}