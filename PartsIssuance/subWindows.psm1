Function logfile{
 $dgv3 = make_dgv -size_x 1250 -size_y 600 -loc_x 50 -loc_y 75
 $dgv3.BackgroundColor = [System.Drawing.Color]::MediumTurquoise
 $dgv3.AllowUserToResizeRows= $false
 $dgv3.AllowUserToResizeColumns = $false
 $dgv3.AllowUserToAddRows = $false
 $dgv3.RowHeadersVisible = $false
 $dgv3.ColumnCount = 8
 $dgv3.Columns[0].Name = "Date and Time"
 $dgv3.Columns[1].Name = "Feeder Location"
 $dgv3.Columns[2].Name = "Requested Part Number"
 $dgv3.Columns[3].Name = "Issued Part Number"
 $dgv3.Columns[4].name = "Barcode"
 $dgv3.Columns[5].name = "OP Name"
 $dgv3.Columns[6].name = "Quantity"
 $dgv3.Columns[7].name = "Status"
 $dgv3.Columns[0].Width = 247
 $dgv3.Columns[1].Width = 100
 $dgv3.Columns[2].Width = 200
 $dgv3.Columns[3].Width = 200
 $dgv3.Columns[4].Width = 180
 $dgv3.Columns[5].Width = 120
 $dgv3.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::Turquoise
  for($i=0;$i -le 7;$i++){
  $dgv3.columns[$i].ReadOnly = $true
 }

 
 $global:optbox1 = make_radiobutton -loc_x 700 -loc_y 25
 $optbox1.text = "Day Shift"
 $optbox1.Font =(New-Object System.Drawing.font("Century Gothic",12,[System.Drawing.FontStyle]::BOLD))
 
 $global:optbox2 = make_radiobutton -loc_x 850 -loc_y 25
 $optbox2.text = "Night Shift"
 $optbox2.Font =(New-Object System.Drawing.font("Century Gothic",12,[System.Drawing.FontStyle]::BOLD))


$form_log.Controls.Add($dgv3)
$form_log.Controls.Add($dtpicker1)
$form_log.Controls.Add($optbox1)
$form_log.Controls.Add($optbox2)
#$form_log.Controls.Add($btn4)
$form_log.Controls.Add($btn5)
}


function RequestForm{
$form_requestform = make_form -size_x 1366 -size_y 730
$form_requestform.BackColor = [System.Drawing.Color]::White
 $label10 = make_label -size_x 250 -size_y 25 -loc_x 50 -loc_y 100
 $label10.Text = "PCB PIC"
 $label10.Font =(New-Object System.Drawing.font("Arial",17,[System.Drawing.FontStyle]::Regular))
 $label10.TextAlign = "MiddleCenter"

 $label11 = make_label -size_x 250 -size_y 25 -loc_x 335 -loc_y 100
 $label11.Text = "Control Number"
 $label11.Font =(New-Object System.Drawing.font("Arial",17,[System.Drawing.FontStyle]::Regular))
 $label11.TextAlign = "MiddleRight"

 $label12 = make_label -size_x 600 -size_y 50 -loc_x 330 -loc_y 10
 $label12.Text = "Parts List Form"
 $label12.Font =(New-Object System.Drawing.font("Arial",35,[System.Drawing.FontStyle]::Regular))
 $label12.TextAlign = "MiddleRight"

 $btn7 = make_button -size_x 200 -size_y 35 -loc_x 10 -loc_y 10
 $btn7.text = "Print"
 $btn7.ForeColor = [system.drawing.color]::Black
 $btn7.Font = (New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $btn7.FlatStyle = "Popup"


 
 $txt7 = Make_textbox -s_x 200 -l_x 375 -l_y 125
 $txt7.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt7.TextAlign = "Center"
 $txt7.CharacterCasing = 'Upper'
 $txt7.Enabled = $false
 $txt7.backcolor = "white"



 $txt6 = Make_textbox -s_x 150 -l_x 100 -l_y 125
 $txt6.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt6.TextAlign = "Center"
 $txt6.CharacterCasing = 'Upper'
 $txt6.MaxLength = 6
 $txt6.BorderStyle = 1




 $dgv4 = make_dgv -size_x 1335 -size_y 500 -loc_x 10 -loc_y 200
 $dgv4.BackgroundColor = [System.Drawing.Color]::White
 $dgv4.AllowUserToResizeRows= $false
 $dgv4.AllowUserToResizeColumns = $false
 $dgv4.font = (New-Object System.Drawing.font("Calibri",10,[System.Drawing.FontStyle]::Regular))
 $dgv4.AllowUserToAddRows = $false
 $dgv4.RowHeadersVisible = $false
 $dgv4.ColumnCount = 14
 $dgv4.Columns[0].Name = "No."
 $dgv4.Columns[1].Name = "Time Request"
 $dgv4.Columns[2].Name = "Time Need"
 $dgv4.Columns[3].Name = "Line No."
 $dgv4.Columns[4].name = "Feeder Loc."
 $dgv4.Columns[5].name = "Main Part Number"
 $dgv4.Columns[6].name = "Alt1"
 $dgv4.Columns[7].name = "Alt2"
 $dgv4.Columns[8].name = "Alt3"
 $dgv4.Columns[9].name = "Alt4"
 $dgv4.Columns[10].name = "Alt5"
 $dgv4.Columns[11].name = "Qty. Req."
 $dgv4.Columns[12].name = "Qty. Sup."
 $dgv4.Columns[13].name = "Remarks"

 $dgv4.Columns[0].Width = 24
 $dgv4.Columns[1].Width = 85
 $dgv4.Columns[2].Width = 85
 $dgv4.Columns[3].Width = 85
 $dgv4.Columns[4].Width = 45
 $dgv4.Columns[5].Width = 140
 $dgv4.Columns[6].Width = 140
 $dgv4.Columns[7].Width = 140
 $dgv4.Columns[8].Width = 140
 $dgv4.Columns[9].Width = 140
 $dgv4.Columns[10].Width = 140
 $dgv4.Columns[11].Width = 50
 $dgv4.Columns[12].Width = 50
 $dgv4.Columns[13].Width = 55
 $dgv4.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"
 $dgv4.EnableHeadersVisualStyles = $false
 $dgv4.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::White
 $dgv4.GridColor = 'Black'
 $dgv4.BorderStyle = 0
 $dgv4.DefaultCellStyle.Alignment = "Middlecenter"
 $dgv4.AutoSizeRowsMode = [System.Windows.Forms.DataGridViewAutoSizeRowsMode]::AllCellsExceptHeaders
 $dgv4.DefaultCellStyle.WrapMode = [System.Windows.Forms.DataGridViewTriState]::True
 for($i=0;$i -le 12;$i++){
  $dgv4.columns[$i].ReadOnly = $true
  }


  ###filling  up DGV4

  $forprint = get-childitem $pathForAll/shared/print
 $counter = 1
 foreach ($aa  in $forprint){
    
    $cont = Get-Content $aa.fullname
    $lnxmdl = -join($cont[3]," ",$cont[12])
    $pn0 = -join($cont[5]," / ",(getmfgpn $cont[5]) )
    $pn1 = -join($cont[6]," / ",(getmfgpn $cont[6]) )
    $pn2 = -join($cont[7]," / ",(getmfgpn $cont[7]) )
    $pn3 = -join($cont[8]," / ",(getmfgpn $cont[8]) )
    $pn4 = -join($cont[9]," / ",(getmfgpn $cont[9]) )
    $pn5 = -join($cont[10]," / ",(getmfgpn $cont[10]) )

    $pn6 = getQty -pn $cont[5]

    $rw = $counter,$cont[0],$cont[2],$lnxmdl,$cont[4],$pn0,$pn1,$pn2,$pn3,$pn4,$pn5,$pn6
    $dgv4.rows.add($rw)
    $counter++
    $dgv4.ClearSelection()

 }


 
##############acquire PartNo
 $lastPrinted = Get-ChildItem -Path "$pathForAll\shared\reqForm" 
 $lastPrintedCOunt = ($lastPrinted|Measure-Object).Count + 1
 $lastPrintedCount = $lastPrintedCOunt.ToString()
 $txt7.text =   $lastPrintedCount.padleft(10,"0")

   
 $dgv5 = make_dgv -size_x 359 -size_y 95 -loc_x 970 -loc_y 60
 $dgv5.BackgroundColor = [System.Drawing.Color]::White
 $dgv5.AllowUserToResizeRows= $false
 $dgv5.AllowUserToResizeColumns = $false
 $dgv5.borderstyle = 0
 $dgv5.AllowUserToAddRows = $false
 $dgv5.RowHeadersVisible = $false
 $dgv5.ColumnHeadersHeight = 30
 $dgv5.ColumnCount = 3
 $dgv5.Columns[0].Name = "Dept."
 $dgv5.Columns[1].Name = "PCB"
 $dgv5.Columns[2].Name = "PDC"
 $dgv5.Columns[0].Width = 100
 $dgv5.Columns[1].Width = 128
 $dgv5.Columns[2].Width = 128
 $dgv5.Rows.add("Operator","")
 $dgv5.Rows.add("Time","")
 $dgv5.DefaultCellStyle.Alignment = "Middlecenter"
 $dgv5.GridColor = 'Black'
 $dgv5.rows[0].Height = 30
 $dgv5.rows[1].Height = 30
 $dgv5.ClearSelection()
  for($i=0;$i -le 2;$i++){
  $dgv5.columns[$i].ReadOnly = $true
 }



 $btn7.add_click({

 $fn = $txt7.text
 


if ($txt6.text -ne ""){

 $btn7.visible = $false


 print_Screen2 "$pathForAll\shared\ReqForm\$fn.png"
 
$pt = Get-ChildItem "$pathForAll\shared\print\"

 $des = -join($pathForAll,"\shared\issue\")

         foreach ($aa in $pt)
         {
         Move-Item -Path $aa.FullName -Destination $des
         updateissued
         updateToPick
         }
    



 }else{msgbox "Please Input PCB PIC"}

 })



















$form_requestform.controls.add($dgv4)
$form_requestform.controls.add($dgv5)

$form_requestform.controls.add($label10)
$form_requestform.controls.add($label12)
$form_requestform.controls.add($txt6)
$form_requestform.controls.add($label11)
$form_requestform.controls.add($txt7)
$form_requestform.controls.add($btn7)
$form_requestform.WindowState = "Maximize"

$form_requestform.ShowDialog()

}


function partsAccept{
param($fileN)
 $form_popup = Make_Form -size_x 700 -size_y 510
 $form_popup.BackColor = [System.Drawing.Color]::PaleTurquoise

 $btn1 = Make_button -size_x 200 -size_y 50 -loc_x 100 -loc_y 400
 $btn1.text = "OK"
 $btn1.BackColor = [system.drawing.color]::DarkTurquoise
 $btn1.ForeColor = [system.drawing.color]::Yellow
 $btn1.Font = (New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $btn1.FlatStyle = "Popup"

 $btn2 = Make_button -size_x 200 -size_y 50 -loc_x 350 -loc_y 400
 $btn2.text = "Cancel"
 $btn2.BackColor = [system.drawing.color]::DarkRed
 $btn2.ForeColor = "#ffffff00"
 $btn2.Font = (New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $btn2.FlatStyle = "Popup"

  $label4 = make_label -size_x 230 -size_y 50 -loc_x 100 -loc_y 25
 $label4.Text = "REQUESTED PART NUMBER"
 $label4.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label4.Font =(New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $label4.TextAlign = "MiddleCenter"

 $label5 = make_label -size_x 310 -size_y 30 -loc_x 10 -loc_y 95
 $label5.Text = "ISSUED PART NUMBER"
 $label5.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label5.Font =(New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $label5.TextAlign = "MiddleRight"

 $label6 = make_label -size_x 310 -size_y 30 -loc_x 10 -loc_y 155
 $label6.Text = "BARCODE"
 $label6.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label6.Font =(New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $label6.TextAlign = "MiddleRight"

 $label7 = make_label -size_x 310 -size_y 30 -loc_x 10 -loc_y 215
 $label7.Text = "OP Name(PIC)"
 $label7.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label7.Font =(New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $label7.TextAlign = "MiddleRight"

 $label8 = make_label -size_x 310 -size_y 30 -loc_x 10 -loc_y 275
 $label8.Text = "Quantity"
 $label8.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label8.Font =(New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $label8.TextAlign = "MiddleRight"

  $label13 = make_label -size_x 310 -size_y 30 -loc_x 10 -loc_y 335
 $label13.Text = "Lot Number"
 $label13.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label13.Font =(New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $label13.TextAlign = "MiddleRight"

  $txt1 = Make_textbox -s_x 340 -l_x 330 -l_y 30
 $txt1.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt1.TextAlign = "Center"
 $txt1.CharacterCasing = 'Upper'
 $txt1.Enabled = $false

 $txt2 = Make_textbox -s_x 340 -l_x 330 -l_y 90
 $txt2.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt2.TextAlign = "Center"
 $txt2.CharacterCasing = 'Upper'

 $txt3 = Make_textbox -s_x 340 -l_x 330 -l_y 150
 $txt3.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt3.TextAlign = "Center"
 $txt3.CharacterCasing = 'Upper'

 $txt4 = Make_textbox -s_x 340 -l_x 330 -l_y 210
 $txt4.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt4.TextAlign = "Center"
 $txt4.CharacterCasing = 'Upper'

 $txt5 = Make_textbox -s_x 340 -l_x 330 -l_y 270
 $txt5.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt5.TextAlign = "Center"
 $txt5.CharacterCasing = 'Upper'
 #$txt5.Enabled = $false
 
 

 $txt8 = Make_textbox -s_x 340 -l_x 330 -l_y 330
 $txt8.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt8.TextAlign = "Center"
 $txt8.CharacterCasing = 'Upper'

 #READING DATA


 $form_popup.add_shown({ $txt2.focus() })

 $txtfile = -join($fileN,".txt")
 $readFile = get-content "$pathForAll\shared\issue\$txtfile"
 $txt1.text = $readFile[5]
 #$txt5.text = getqty -pn $txt1.text


 $txt2.add_keypress{
 param($a,$b)
if ($b.keychar -eq [System.Windows.Forms.Keys]::Enter){$txt3.focus()}
}
 $txt3.add_keypress{
 param($a,$b)
if ($b.keychar -eq [System.Windows.Forms.Keys]::Enter){$txt5.focus()}
}
 $txt5.add_keypress{
 param($a,$b)
if ($b.keychar -eq [System.Windows.Forms.Keys]::Enter){$txt4.focus()}
}
 $txt4.add_keypress{
 param($a,$b)
if ($b.keychar -eq [System.Windows.Forms.Keys]::Enter){$txt8.focus()}
}
 $txt8.add_keypress{
 param($a,$b)
if ($b.keychar -eq [System.Windows.Forms.Keys]::Enter){$btn1.focus()}
}
 


 $btn1.add_click({

 $data1 =  $readFile[5]
 $data2 =  $readFile[6]
 $data4 =  $readFile[7]
 $data5 =  $readFile[8]
 $data6 =  $readFile[9]
 $data7 =  $readFile[10]
 $data8 =  $readFile[11]
 $checkPN = $txt2.text -eq $data1 -or $txt2.text -eq $data2 -or $txt2.text -eq $data3 -or $txt2.text -eq $data4 -or $txt2.text -eq $data5 -or $txt2.text -eq $data6 -or $txt2.text -eq $data7 -or $txt2.text -eq $data8
 $barcodePath = -join("$pathForAll/shared/barcodes/",$txt3.Text,".txt")

 $messagebutton = [System.Windows.Forms.MessageBox]::show('Are you sure?','Warning','YesNo')
 $err = "OK"
 #Evaluation of textbox values
 if ($messagebutton -eq 'Yes'){
		$scannedPN = $txt2.Text
    if ($txt1.text -eq ""){ $err = "Please enter the Requested Part Number!"}
    if ($txt2.Text -eq ""){$err ="Please enter Issued Part Number!"}
    if ($txt3.text -eq ""){$err = "Please scan the barcode!"}
    if ($txt4.text -eq ""){$err = "Please enter your name!"}
    if ($txt5.Text -eq ""){$err = "Please enter part quantity"}
    if ($txt8.Text -eq ""){$err = "Please Enter Lot Number"}
    if ($checkPN -eq $false){$err = "You are scanning a wrong Part Number "}
	if (($txt3.text -as [int]) -eq $null){$err = "Please Re-check Barcode";$txt3.text = "";$txt3.focus()}
	if ($txt3.TextLength -ne 10){$err = "Please Re-check Barcode";$txt3.text = "";$txt3.focus()}
	if ($txt2.TextLength -ne 12){$err = "Please Re-check Barcode";$txt3.text = "";$txt3.focus()}
	if ($scannedPN[3] -ne "-"){$err = "Please Re-check Part Number";$txt2.text = "";$txt2.focus()}
	if ($scannedPN[8] -ne "-"){$err = "Please Re-check Part Number";$txt2.text = "";$txt2.focus()}



	
    if ((test-path $barcodePath)){$err = "barcode already Exist"}
        if ($err -eq "OK"){

        $now = Get-Date
        Move-Item -Path "$pathForAll\shared\issue\$txtfile" -Destination "$pathForAll\shared\received\$txtfile"
       "ISSUED"|Out-File "$pathForAll\shared\received\$txtfile" -Append
        $txt4.text|out-file "$pathForAll\shared\received\$txtfile" -Append
        $txt3.Text|Out-File "$pathForAll\shared\received\$txtfile" -Append
        $txt2.Text|Out-File "$pathForAll\shared\received\$txtfile" -Append
        $txt8.Text|Out-File "$pathForAll\shared\received\$txtfile" -Append
        #$txt5.Text|Out-File "$pathForAll\shared\received\$txtfile" -Append #########ADDED AS REQUESTED 200217
        $now.ToString()|Out-File "$pathForAll\shared\received\$txtfile" -Append
        $txt2.Text|Out-File $barcodePath


        #ADDED AS REQUESTED 200217### for parts Request Automation
        $qtypath = -join("C:\ChildPartsControl\Shared\qtyPerBarcode\",$txt3.text,".txt")
        $txt5.text|Out-File $qtypath
        ###
		
		#ADDED AS REQUESTED 200218### for parts Request Automation, revision only
		$prf_date = $now.toString()
		$prf_process = $readFile[3]
		$prf_feeder = $readFile[4]
		$prf_partNo = $txt2.text
		$prf_lot = $txt8.text
		$prf_qty = $txt5.text
		$prf_path = "C:\ChildPartsControl\Shared\logs\Issuance\"
		$line_issue = -join($prf_date,",",$prf_process,",",$prf_feeder,",",$prf_partNo,",",$prf_lot,",",$prf_qty)
		outLogs -loc $prf_path -line $line_issue

        updateIssued
        updateToPick
        $form_popup.dispose()
        }else{msgbox $err}
    }
})


$form_popup.Controls.Add($btn1)
$form_popup.Controls.Add($btn2)
$form_popup.Controls.Add($label4)
$form_popup.Controls.Add($label5)
$form_popup.Controls.Add($label6)
$form_popup.Controls.Add($label7)
$form_popup.Controls.Add($label8)
$form_popup.Controls.Add($label13)
$form_popup.Controls.Add($txt1)
$form_popup.Controls.Add($txt2)
$form_popup.Controls.Add($txt3)
$form_popup.Controls.Add($txt4)
$form_popup.Controls.Add($txt5)
$form_popup.Controls.Add($txt8)

$form_popup.ShowDialog()





}