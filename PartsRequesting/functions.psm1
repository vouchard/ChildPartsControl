#functions

function mouse_down{
$pos = [System.Windows.Forms.Cursor]::Position
$frm_Main.Text = $pos
}
function mouse_up{
$pos = [System.Windows.Forms.Cursor]::Position
$xd = $pos.x
$yd = $pos.y
$frm_Main.Text = "x = $xd | y = $yd"
}
function msgbox{
param ($St)
[System.Windows.Forms.MessageBox]::show(($st))
<#$fr = new-object system.windows.forms.form
$fr.Size = New-Object System.Drawing.Size(500,300)
$fr.StartPosition = "CenterScreen"
$lbll  = new-object system.windows.forms.label
$lbll.Text = $St
$lbll.top = 20
$lbll.left = 20
$fr.Text = $text
$fr.BackColor = "#ffffffff"
$fr.controls.Add($lbll)
$fr.ShowDialog()
#>
}
function makeForm{
param($size_x,$size_y,$text)

$frm = new-object system.windows.forms.form
$frm.Size = New-Object System.Drawing.Size($size_x,$size_y)
$frm.StartPosition = "manual"
$frm.Text = $text
$frm.BackColor = "#ffffffff"
$frm
}
function makeButton{
param($size_x,$size_y,$loc_x,$loc_y,$text)

$btn = new-object system.windows.forms.button
$btn.Size = New-Object System.Drawing.Size($size_x,$size_y)
$btn.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$btn.Font =  New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$btn.Text = $text
$btn


}
function makeDGVButton{

$btn = new-object system.windows.forms.dataGridViewButtonColumn
#$btn.DefaultCellStyle.SelectionBackColor = new-obe
#$btn.DefaultCellStyle.BackColor = "blue"
#btn.FlatStyle = "popup"
#$btn.HeaderText = "dad"
#$btn.UseColumnTextForButtonValue = $true

$btn
}
function makeLabel{
param($size_x,$size_y,$loc_x,$loc_y,$text)

$lbl = new-object system.windows.forms.LAbel
$lbl.Size = New-Object System.Drawing.Size($size_x,$size_y)
$lbl.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$lbl.Text = $text
$lbl.Font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::BOLD)
$lbl.TextAlign = "MIDDLERIGHT"
$lbl.BorderStyle = 1
$lbl


}
function makeGridView{
param($size_x,$size_y,$loc_x,$loc_y,$text)

$dgv = New-Object System.Windows.Forms.DataGridView
$dgv.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$dgv.ColumnHeadersVisible = $true
$dgv.ColumnHeadersDefaultCellStyle.BackColor = "lightGreen"
$dgv.EnableHeadersVisualStyles = $false
$dgv.RowHeadersVisible = $FALSE
$dgv.BackgroundColor = "White"
$dgv.font =  New-Object System.Drawing.font("Century Gothic",7,[System.Drawing.FontStyle]::Regular)
$dgv.Size = New-Object System.Drawing.Size($size_x,$size_y)
$dgv.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
        #$dgv.AutoSizeRowsMode = [System.Windows.Forms.DataGridViewAutoSizeRowsMode]::DisplayedCellsExceptHeaders
        #$dgv.DefaultCellStyle.WrapMode = [System.Windows.Forms.DataGridViewTriState]::True
$dgv


}
function makeCombobox{
param($size_x,$size_y,$loc_x,$loc_y,$text)
$cb  = New-Object System.Windows.Forms.ComboBox
$cb.Size = New-Object System.Drawing.Size($size_x,$size_y)
$cb.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$cb.Font = New-Object System.Drawing.font("Century Gothic",$size_y,[System.Drawing.FontStyle]::BOLD)
$cb

}
function maketextbox{
param($size_x,$size_y,$loc_x,$loc_y,$text)

$lbl = new-object system.windows.forms.textbox
$lbl.Size = New-Object System.Drawing.Size($size_x,$size_y)
$lbl.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$lbl.Text = $text
$lbl.Font = New-Object System.Drawing.font("Century Gothic",14.5,[System.Drawing.FontStyle]::BOLD)
$lbl.BorderStyle = 1
$lbl
}
function bomCompliler{
param($fsl,$boml,$md)
Remove-Item "$masterPath\modeldb\bom.tmp" 
"Main part,alt1,alt2,alt3,alt4,alt5,alt6,alt7"|Out-File "$masterPath\modeldb\bom.tmp" 

#$fsl = import-csv $fsl               
$header = "0","1","2","3","4","5","6","7","8","9","10","11"

$bom = import-csv $boml -Header $header|Select-Object -Skip 1|Where-Object{$_.'10' -ne ""}
#$bom|Out-GridView
#[System.Windows.Forms.MessageBox]::show(($bom.length))


for($i = 0;$i -le $bom.length;$i++){
$ln = $bom[$i]
$asd = $ln.'0'

    if ($asd -ne "")
        {
        $pn = $ln.'1'
        $towrite = $pn
        }else{
        $pn = $ln.'1'
        $towrite ="$towrite,$pn"
                }
        if($bom[$i+1].'0' -ne ""){
        $towrite|Out-File "$masterPath\modeldb\bom.tmp" -Append 
        }
}
createDatabase -fsl $fsl -mdlName $md
}

function createDatabase{
param($fsl,$mdlName)
$fs = import-csv $fsl -Header "0","1"|Select-Object -Skip 1
$header = "0","1","2","3","4","5","6","7","8"
$bom = import-csv "$masterPath\modeldb\bom.tmp" -Header $header|Select-Object -Skip 1
 #$bom|out-Gridview
 #"0,1,2,3,4,5,6,7,8"|out-file "$masterPath\modeldb\$mdlName.txt" -Append
 for ($i=0;$i -le $fs.length;$i++){
    $fLoc = $fs[$i].'1'
    $main = $fs[$i].'0'
    $alt1 = ""
    $alt2 = ""
    $alt3 = ""
    $alt4 = ""
    $alt5 = ""
    $alt6 = ""
    $alt7 = ""


        $fbom = $bom|where-object{$_.'0' -eq $main}
 #$fbom|Out-GridView 
 #Read-Host "aaa" 
   if ($fbom.count -ne 0){
   
    $alt1 = ($fbom[0]).'1'
    $alt2 = ($fbom[0]).'2'
    $alt3 = ($fbom[0]).'3'
    $alt4 = ($fbom[0]).'4'
    $alt5 = ($fbom[0]).'5'
    $alt6 = ($fbom[0]).'6'
    $alt7 = ($fbom[0]).'7'
    
    $line = "$fLoc,$main,$alt1,$alt2,$alt3,$alt4,$alt5,$alt6,$alt7"
    
    $line|out-file "$masterPath\modeldb\$mdlName.txt" -Append
     Write-Host "$line"
    }else{
    "$floc,$main"|out-file "$masterPath\modeldb\$mdlName.txt" -Append
    Write-Host "$floc,$main"
    }
   
 }



}
function getQty{
param($pn)
$a = "0","1","2"
$a = import-csv "$MainPath\partsdb\partsdb.csv" -Header $a|Select-Object -skip 1
$pn = $a|Where-Object {$_.'0' -eq $pn}

if ($pn.Length -lt 1){
    $qty = "not registered"}
    else{
        $qty = $pn[0].'2'
        }
$qty
}
function getMfgPN{
param($pn)
$b = "0","1","2"
$a = import-csv "$masterShared\partsdb\partsdb.csv" -Header $b|Select-Object -skip 1
$pn = $a|Where-Object {$_.'0' -eq $pn}


if ($pn.Length -eq 0){
    $mfg = "not registered"}
    else{
        $mfg = $pn[0].'1'
        }
$mfg
}
function getFeederPN{
param($pn)
$b = "0","1","2"
$a = import-csv "$masterpath\Feederdb\feederdb.csv" -Header $b|Select-Object -skip 1
$pn = $a|Where-Object {$_.'1' -eq $pn}


if ($pn.Length -eq 0){
    $mfg = "not registered"}
    else{
        $mfg = $pn[0].'1'
        }
$mfg
}
function outLogs{
param($loc,$line)
$refTime1 = get-date("08:00")
$refTime2 = get-date("20:00")
$now = Get-Date

$test1 = $now -ge $refTime1
$test2 = $now -le $refTime2

if ($test1 -and $test2)
    {$filename = get-date -UFormat "%y%m%d_DS"}
    elseif($now -gt $refTime2){$filename = get-date -UFormat "%y%m%d_NS"}
    elseif($now -lt $refTime1){
            $ystrday = $now.AddDays(-1)
            $filename = Get-Date $ystrday -UFormat "%y%m%d_NS"
            }

            $fullpath = -join($loc,$filename,".txt")
            
            $line|Out-file $fullpath -Append

}
function toprompt{
param($msg)

$now = (get-date).ToShortTimeString()

Write-Host "$now -- $msg"




}