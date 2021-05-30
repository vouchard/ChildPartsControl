function Make_Form{
param($size_x, $size_y,$loc_x, $loc_y)

$form = New-Object System.Windows.Forms.Form
$form.Size = New-object System.Drawing.Size($size_x,$size_y)
$form.location = New-object System.Drawing.Size($size_x,$size_y)
$form.StartPosition = "CenterScreen"
$form
}
function Make_button{
param($size_x,$size_y,$loc_x,$loc_y,$text)

$btn = New-Object System.Windows.Forms.Button

$btn.text = $text
$btn.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$btn.size = New-Object System.Drawing.Size($size_x,$size_y)

$btn
}
function Make_dgv{
param($size_x,$size_y,$loc_x,$loc_y)
$dgv = new-object System.Windows.Forms.DataGridView
$dgv.size = new-object System.Drawing.Size($size_x,$size_y)
$dgv.Location = New-Object System.Drawing.Size($loc_x,$loc_y)

$dgv.ColumnHeadersVisible = $true
$dgv.ColumnHeadersHeight = 30
$dgv.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::Turquoise

$dgv.ColumnHeadersHeight = 50

$dgv.BackColor = "#ff66ccff"
$dgv.Font = (New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD))
$dgv
}
Function make_dtpicker{
param($size_x,$size_y,$loc_x,$loc_y)
$dtpicker = New-Object System.Windows.Forms.DateTimePicker
$dtpicker.Size = New-Object System.Drawing.Size(300,10)
$dtpicker.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$dtpicker.Font = (New-Object System.Drawing.font("Century Gothic",12,[System.Drawing.FontStyle]::BOLD))
$dtpicker
}
function Make_textbox{
param($s_x,$s_y,$l_x,$l_y)
$txt = New-Object System.Windows.Forms.TextBox
$txt.Location = New-Object System.Drawing.size($l_x,$l_y)
$txt.Size = New-Object System.Drawing.Size($s_x,$s_y)
$txt
}
function make_label{
param($size_x,$size_y,$loc_x,$loc_y,$text)
$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$label.size = New-Object System.Drawing.Size($size_x,$size_y)
$label
}
function getQty{

param($pn)

$qty
}
function make_radiobutton{
param($loc_x,$loc_y)
$optbox = New-Object System.Windows.Forms.RadioButton
$optbox.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$optbox.size = New-Object System.Drawing.Size(120,20)
$optbox
}
function make_picturebox{
param($size_x, $size_y,$loc_x,$loc_y)
$pic = New-Object System.Windows.Forms.PictureBox
$pic.Location = New-Object System.Drawing.Size($loc_x,$loc_y)
$pic.size = New-Object System.Drawing.Size($size_x,$size_y)
$pic.ImageLocation = "$pathForAll\programs\canon1.png"
$pic.sizemode = 1
$pic
}
function getmfg{
param($prtn)
$b = "0","1","2"
        $a = import-csv $QTYPath -Header $b|Select-Object -skip 1
        $mfg = $a|Where-Object {$_.'0' -eq $prtn}
        #[system.windows.forms.messagebox]::show($pn)
        if ($mfg.Length -eq 0){
            $mfg = ""
        }
        else{
            $mfg = $mfg[0].'1'
            #$dgv4.Rows[$i].cells[6].value =($dgv4.Rows[$i].cells[6].value + " / " + $qty)
        }
        $mfg
}
function ForPrint{
$req = Get-ChildItem $MainPath

$dgv4.rows.Clear()
$a = 0
foreach ($aa in $req)
    {
        $a = $a + 1
        
        $gtc = Get-Content $aa.FullName
        $j = $gtc[5]
        $header = "0","1","2"
        $b = import-csv $QTYPath -Header $header
        $c = $b|Where-Object{$_.'0' -eq $j}
        if ($c -eq 0){
         $qty = ""
        }
        else{
         $qty = $c[0].'2'
        }
       
        $line = $a,$gtc[0],$gtc[2],$gtc[3],$gtc[4],$gtc[5],$gtc[6],$gtc[7],$gtc[8],$gtc[9],$gtc[10], $qty
        $dgv4.Rows.Add($line)|Out-Null
       
    } 
        $jj = $dgv4.RowCount
        For ($i = 0; $i -lt $jj;$i ++){
        $j = $dgv4.rows[$i].Cells[5].value

        $b = "0","1","2"
        $a = import-csv $QTYPath -Header $b|Select-Object -skip 1
        $global:pn = $a|Where-Object {$_.'0' -eq $j}

        if ($pn.Length -gt 10){
            $qty = "not registered"
        }
        else{
            $qty = $pn[0].'1'
            $dgv4.Rows[$i].cells[5].value =($dgv4.Rows[$i].cells[5].value + " / " + $qty)
            $dgv4.Rows[$i].cells[6].value = ($dgv4.Rows[$i].cells[6].value + " / " + (getmfg -prtn $dgv4.Rows[$i].cells[6].value))
            $dgv4.Rows[$i].cells[7].value = ($dgv4.Rows[$i].cells[7].value + " / " + (getmfg -prtn $dgv4.Rows[$i].cells[7].value))
            $dgv4.Rows[$i].cells[8].value = ($dgv4.Rows[$i].cells[8].value + " / " + (getmfg -prtn $dgv4.Rows[$i].cells[8].value))
            $dgv4.Rows[$i].cells[9].value = ($dgv4.Rows[$i].cells[9].value + " / " + (getmfg -prtn $dgv4.Rows[$i].cells[9].value))
            $dgv4.Rows[$i].cells[10].value = ($dgv4.Rows[$i].cells[10].value + " / " + (getmfg -prtn $dgv4.Rows[$i].cells[10].value))
        }
        }

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
function print_Screen{
param($path)
$bounds = [Drawing.Rectangle]::FromLTRB(7,31,1350,727)
#$bounds = [Drawing.Rectangle]::FromLTRB(60,130,1310,580)
$picture = New-Object Drawing.Bitmap $bounds.Width,$bounds.Height
$graphics = [Drawing.Graphics]::FromImage($picture)
$graphics.CopyFromScreen($bounds.Location,[Drawing.point]::Empty,$bounds.Size)

$picture.Save($path)
$graphics.Dispose()
$picture.Dispose()

Start-Process $path -Verb print

}
function print_Screen2{
param($path)
#$path = "C:\Users\110049\Desktop\sample.jpg"
$doc = New-Object System.Drawing.Printing.PrintDocument
$prev = New-Object System.Windows.Forms.PrintPreviewDialog

$snipxAxis = 7
$snipyAxis = 31 
$snipx = 1350
$snipy = 727
$paperx = 1100


## SCREEN CAPTURE #######################################
$bounds = [Drawing.Rectangle]::FromLTRB($snipxAxis,$snipyAxis,$snipx,$snipy)

$picture = New-Object Drawing.Bitmap $bounds.Width,$bounds.Height
$graphics = [Drawing.Graphics]::FromImage($picture)
$graphics.CopyFromScreen($bounds.Location,[Drawing.point]::Empty,$bounds.Size)
$picture.Save($path)


## PRINTER ########################################

$doc.DefaultPageSettings.Landscape = $true
$aspectRatio = $snipx/$snipy
$papery = $paperx*($snipy/$snipx) 

$doc.add_PrintPage{

$_.graphics.DrawImage($picture,0,0,$paperx,$papery )

}

#$prev.Document = $doc
#prev.ShowDialog()

$doc.Print()

}
function msgbox{
param ($St)
[System.Windows.Forms.MessageBox]::show(($st))
}

function getQty{
param($pn)

$b = "0","1","2"
$a = import-csv "$pathForAll\partsdb\partsdb.csv" -Header $b|Select-Object -skip 1

$pn = $a|Where-Object {$_.'0' -eq $pn}

$fnd = ($pn|Measure-Object).Count

if ($fnd -lt 1){
    $qty = "not registered"}
    else{
        $qty = $pn[0].'2'
        }
$qty
}



function getMfgPN{
param($pn)
if ($pn -eq "-"){$mfg = ""}else{
$b = "0","1","2"
$a = import-csv "$pathForAll\partsdb\partsdb.csv" -Header $b|Select-Object -skip 1
$pn = $a|Where-Object {$_.'0' -eq $pn}


if ($pn.Length -eq 0){
    $mfg = "NOT REGISTERED"}
    else{
        $mfg = $pn[0].'1'
        }
}
$mfg
}