Add-type -AssemblyName System.windows.forms
Add-Type -AssemblyName system.drawing

Remove-Module *
Import-Module "M:\4003\members\Vou\ChildPartSystem\chidlPartsControl\samples\Functions.psm1" -Verbose
Import-Module "M:\4003\members\Vou\ChildPartSystem\chidlPartsControl\samples\logfiles.psm1" -Verbose


#### Path #### #### Path #### #### Path #### #### Path #### #### Path #### #### Path #### #### Path ####
$MainPath = "M:\4003\members\Vou\ChildPartSystem\Shared\Request\"
$LotPath = "M:\4003\members\Vou\ChildPartSystem\Shared\Lot\"
$MasterPath = "M:\4003\members\Vou\ChildPartSystem\Shared\Request"
$ReceivedPath = "M:\4003\members\Vou\ChildPartSystem\Shared\Received\"
$TransactionPath = "M:\4003\members\Vou\ChildPartSystem\Shared\Transaction\"
$global:LogfilePath = "M:\4003\members\Vou\ChildPartSystem\Shared\logs\receiveRequest\"
$QTYPath = "M:\4003\members\Vou\ChildPartSystem\partsdb\partsdb.csv"
$BarcodePath = "M:\4003\members\Vou\ChildPartSystem\Shared\Barcodes\"

#### FORM #### #### FORM #### #### FORM #### #### FORM #### #### FORM #### #### FORM #### #### FORM ####
$form_main = Make_Form -size_x 1366 -size_y 730
$form_main.BackColor = [System.Drawing.Color]::PaleTurquoise
$form_popup = Make_Form -size_x 700 -size_y 510
$form_popup.BackColor = [System.Drawing.Color]::PaleTurquoise
$form_log = make_form -size_x 1366 -size_y 730
$form_log.BackColor = [System.Drawing.Color]::PaleTurquoise

$form_requestform = make_form -size_x 1366 -size_y 730
$form_requestform.BackColor = [System.Drawing.Color]::White


#### TEXTBOX #### #### TEXTBOX #### #### TEXTBOX #### #### TEXTBOX #### #### TEXTBOX #### #### TEXTBOX ####
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
 $txt5.Enabled = $false

 $txt6 = Make_textbox -s_x 150 -l_x 100 -l_y 125
 $txt6.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt6.TextAlign = "Center"
 $txt6.CharacterCasing = 'Upper'
 $txt6.MaxLength = 6


 $txt7 = Make_textbox -s_x 200 -l_x 375 -l_y 125
 $txt7.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt7.TextAlign = "Center"
 $txt7.CharacterCasing = 'Upper'
 $txt7.Enabled = $false

 $txt8 = Make_textbox -s_x 340 -l_x 330 -l_y 330
 $txt8.font = (New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD))
 $txt8.TextAlign = "Center"
 $txt8.CharacterCasing = 'Upper'
 

 
 #### LABEL ####  #### LABEL ####  #### LABEL ####  #### LABEL ####  #### LABEL ####  #### LABEL ####
 
$label1 = make_label -size_x 500 -size_y 100 -loc_x 450 -loc_y 10
$label1.Text = "PCB REQUEST"
$label1.ForeColor = [System.Drawing.Color]::RoyalBlue
$label1.Font =(New-Object System.Drawing.font("Stencil",50,[System.Drawing.FontStyle]::BOLD))

$label2 = make_label -size_x 500 -size_y 100 -loc_x 500 -loc_y 350
$label2.Text = "REQUEST STATUS"
$label2.ForeColor = [System.Drawing.Color]::RoyalBlue
$label2.Font =(New-Object System.Drawing.font("Stencil",30,[System.Drawing.FontStyle]::BOLD))

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

 $label9 = make_label -size_x 500 -size_y 100 -loc_x 125 -loc_y 17
 $label9.Text = "Log Files"
 $label9.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label9.Font =(New-Object System.Drawing.font("Stencil",50,[System.Drawing.FontStyle]::BOLD))
 $label9.TextAlign = "MiddleRight"

 $label10 = make_label -size_x 250 -size_y 25 -loc_x 50 -loc_y 100
 $label10.Text = "Employee Number"
 $label10.Font =(New-Object System.Drawing.font("Stencil",17,[System.Drawing.FontStyle]::BOLD))
 $label10.TextAlign = "MiddleRight"

 $label11 = make_label -size_x 250 -size_y 25 -loc_x 335 -loc_y 100
 $label11.Text = "Control Number"
 $label11.Font =(New-Object System.Drawing.font("Stencil",17,[System.Drawing.FontStyle]::BOLD))
 $label11.TextAlign = "MiddleRight"

 $label12 = make_label -size_x 600 -size_y 50 -loc_x 330 -loc_y 10
 $label12.Text = "Parts List Form"
 $label12.Font =(New-Object System.Drawing.font("Stencil",40,[System.Drawing.FontStyle]::BOLD))
 $label12.TextAlign = "MiddleRight"

 $label13 = make_label -size_x 310 -size_y 30 -loc_x 10 -loc_y 335
 $label13.Text = "Lot Number"
 $label13.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label13.Font =(New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $label13.TextAlign = "MiddleRight"



 #### BUTTON ##### #### BUTTON ##### #### BUTTON ##### #### BUTTON ##### #### BUTTON ##### #### BUTTON #####
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

 $btn3 = make_button -size_x 200 -size_y 35 -loc_x 1100 -loc_y 55
 $btn3.text = "Log Files"
 $btn3.BackColor = [system.drawing.color]::DarkTurquoise
 $btn3.ForeColor = [system.drawing.color]::Black
 $btn3.Font = (New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $btn3.FlatStyle = "Popup"

 $btn5 = make_button -size_x 200 -size_y 40 -loc_x 1100 -loc_y 55
 $btn5.text = "Save"
 $btn5.BackColor = [system.drawing.color]::DarkTurquoise
 $btn5.ForeColor = [system.drawing.color]::Black
 $btn5.Font = (New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $btn5.FlatStyle = "Popup"

 $btn6 = make_button -size_x 200 -size_y 35 -loc_x 1100 -loc_y 10
 $btn6.text = "Request Form"
 $btn6.BackColor = [system.drawing.color]::DarkTurquoise
 $btn6.ForeColor = [system.drawing.color]::Black
 $btn6.Font = (New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $btn6.FlatStyle = "Popup"

 $btn7 = make_button -size_x 200 -size_y 35 -loc_x 1100 -loc_y 10
 $btn7.text = "Print"
 $btn7.ForeColor = [system.drawing.color]::Black
 $btn7.Font = (New-Object System.Drawing.font("Century Gothic",16,[System.Drawing.FontStyle]::BOLD))
 $btn7.FlatStyle = "Popup"


 $button1 = New-Object System.Windows.Forms.DataGridViewButtonColumn
 $button1.HeaderText = "Accept"
 $button1.UseColumnTextForButtonValue = $true
 $button1.text = "Accept"
 $button1.Width = 100
 $button1.HeaderText
 $button1.UseColumnTextForButtonValue
 $button1.FlatStyle = "Popup"

$button2 = New-Object System.Windows.Forms.DataGridViewButtonColumn
$button2.HeaderText = "Deny"
$button2.UseColumnTextForButtonValue = $true
$button2.text = "Deny"
$button2.Width = 100
$button2.HeaderText
$button2.UseColumnTextForButtonValue
$button2.FlatStyle = "Popup"

#### DATAGRIDVIEW #### #### DATAGRIDVIEW #### #### DATAGRIDVIEW #### #### DATAGRIDVIEW #### #### DATAGRIDVIEW ####
 $dgv1 = Make_dgv -size_x 1250 -size_y 250 -loc_x 50 -loc_y 100
 $dgv1.Columns.Add($button1)|Out-Null
 $dgv1.Columns.Add($button2)|Out-Null
 $dgv1.ColumnCount = 11
 $dgv1.Columns[2].Name = "Time Needed"
 $dgv1.Columns[3].Name = "Line No."
 $dgv1.Columns[4].Name = "Feeder Location"
 $dgv1.Columns[5].Name = "Main Part Number"
 $dgv1.Columns[6].Name = "Alt 1"
 $dgv1.Columns[7].Name = "Alt 2"
 $dgv1.Columns[8].Name = "Alt 3"
 $dgv1.Columns[9].Name = "Alt 4"
 $dgv1.Columns[10].Name = "Alt 5"
 $dgv1.Columns[2].Width = 190
 $dgv1.Columns[3].Width = 50
 $dgv1.Columns[4].Width = 75
 $dgv1.Columns[5].Width = 50
 $dgv1.Columns[6].Width = 77
 $dgv1.Columns[7].Width = 50
 $dgv1.Columns[8].Width = 77
 $dgv1.Columns[9].Width = 50
 $dgv1.EnableHeadersVisualStyles = $false
 $dgv1.Columns[0].DefaultCellStyle.BackColor = [System.Drawing.Color]::LightGreen
 $dgv1.Columns[1].DefaultCellStyle.BackColor =[System.Drawing.Color]::Red
 $dgv1.Columns[1].DefaultCellStyle.ForeColor = [System.Drawing.Color]::Yellow
 $dgv1.Columns[0].DefaultCellStyle.ForeColor = [System.Drawing.Color]::DarkBlue
 $dgv1.BorderStyle = "Fixed3D"
 $dgv1.GridColor = [System.Drawing.Color]::DarkTurquoise
 $dgv1.DefaultCellStyle.Alignment = "Middlecenter"
 

 for($i=5;$i -le 10; $i++){
 $dgv1.Columns[$i].Width = 122
 }
 
 for($i=0;$i -le 9; $i++){
 $dgv1.columns[$i].ReadOnly = $true
 }
 $dgv1.BackgroundColor = [System.Drawing.Color]::MediumTurquoise
 $dgv1.AllowUserToResizeRows= $false
 $dgv1.AllowUserToResizeColumns = $false
 $dgv1.AllowUserToAddRows = $false
 $dgv1.RowHeadersVisible = $false
 $dgv1.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"

 $dgv2= Make_dgv -size_x 1250 -size_y 250 -loc_x 50 -loc_y 400
 $dgv2.ColumnCount = 6
 $dgv2.Columns[0].Name = "Line Number"
 $dgv2.Columns[1].Name = "Feeder Location"
 $dgv2.Columns[2].Name = "Requested Part Number"
 $dgv2.Columns[3].Name = "Issued Part Number"
 $dgv2.Columns[4].name = "Barcode"
 $dgv2.Columns[5].name = "Status"
 $dgv2.BorderStyle = "Fixed3D"

 for($i=0;$i -le 5;$i++){
  $dgv2.columns[$i].ReadOnly = $true
 }

 $dgv2.Columns[0].Width = 100
 $dgv2.Columns[1].Width = 200
 $dgv2.Columns[2].Width = 250
 $dgv2.Columns[3].Width = 250
 $dgv2.Columns[4].Width = 247
 $dgv2.Columns[5].Width = 200
 $dgv2.BackgroundColor = [System.Drawing.Color]::MediumTurquoise
 $dgv2.AllowUserToAddRows = $false
 $dgv2.RowHeadersVisible = $false
 $dgv2.EnableHeadersVisualStyles = $false
 $dgv2.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::Turquoise
 $dgv2.DefaultCellStyle.Alignment = "Middlecenter"
 $dgv2.GridColor = [System.Drawing.Color]::DarkTurquoise
 $dgv2.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"

 $dgv3 = make_dgv -size_x 1250 -size_y 550 -loc_x 50 -loc_y 100
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
 $dgv3.Columns[5].name = "PIC"
 $dgv3.Columns[6].name = "Quantity"
 $dgv3.Columns[7].name = "Status"
 $dgv3.Columns[0].Width = 247
 $dgv3.Columns[1].Width = 100
 $dgv3.Columns[2].Width = 200
 $dgv3.Columns[3].Width = 200
 $dgv3.Columns[4].Width = 180
 $dgv3.Columns[5].Width = 120
 $dgv3.EnableHeadersVisualStyles = $false
 $dgv3.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::Turquoise
 $dgv3.GridColor = [System.Drawing.Color]::DarkTurquoise
 $dgv3.DefaultCellStyle.Alignment = "Middlecenter"
 $dgv3.BorderStyle = "Fixed3D"
 $dgv3.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"

  for($i=0;$i -le 7;$i++){
  $dgv3.columns[$i].ReadOnly = $true
 }


 $dgv4 = make_dgv -size_x 1335 -size_y 430 -loc_x 5 -loc_y 272
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
 $dgv4.Columns[3].Width = 45
 $dgv4.Columns[4].Width = 45
 $dgv4.Columns[5].Width = 149
 $dgv4.Columns[6].Width = 147
 $dgv4.Columns[7].Width = 146
 $dgv4.Columns[8].Width = 145
 $dgv4.Columns[9].Width = 144
 $dgv4.Columns[10].Width = 144
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

 $dgv5 = make_dgv -size_x 359 -size_y 129 -loc_x 980 -loc_y 100
 $dgv5.BackgroundColor = [System.Drawing.Color]::White
 $dgv5.AllowUserToResizeRows= $false
 $dgv5.AllowUserToResizeColumns = $false

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
 $dgv5.rows[0].Height = 47
 $dgv5.rows[1].Height = 50
 $dgv5.ClearSelection()
  for($i=0;$i -le 2;$i++){
  $dgv5.columns[$i].ReadOnly = $true
 }




 #### DATETIMEPICKER #### #### DATETIMEPICKER #### #### DATETIMEPICKER #### #### DATETIMEPICKER #### #### DATETIMEPICKER ####
 $global:dtpicker1 = make_dtpicker -loc_x 1000 -loc_y 20

 #### PICTUREBOX #### #### PICTUREBOX #### #### PICTUREBOX #### #### PICTUREBOX #### #### PICTUREBOX ####
 $pic1 = Make_picturebox -loc_x 50 -loc_y 10 -size_x 150 -size_y 75
 $pic2 = Make_picturebox -loc_x 50 -loc_y 10 -size_x 150 -size_y 75
 
#### OPTIONBOX #### #### OPTIONBOX #### #### OPTIONBOX #### #### OPTIONBOX #### #### OPTIONBOX ####
 $global:optbox1 = make_radiobutton -loc_x 700 -loc_y 25
 $optbox1.text = "Day Shift"
 $optbox1.Font =(New-Object System.Drawing.font("Century Gothic",12,[System.Drawing.FontStyle]::BOLD))
 
 $global:optbox2 = make_radiobutton -loc_x 850 -loc_y 25
 $optbox2.text = "Night Shift"
 $optbox2.Font =(New-Object System.Drawing.font("Century Gothic",12,[System.Drawing.FontStyle]::BOLD))

#### TIMER #### #### TIMER #### #### TIMER #### #### TIMER #### #### TIMER #### #### TIMER #### #### TIMER ####
$timer1 = New-Object System.Windows.Forms.Timer
$timer1.Enabled = $false
$timer1.Enabled = $true
$timer1.Interval = 3000




$timer1.add_tick({
$dgv1.Rows.Clear()
$dgv2.Rows.Clear()




foreach ($file in Get-childitem $MainPath){

$dgv1.rows.Clear()
 $files = Get-ChildItem -Path $MainPath|Sort-Object -Property lastwritetime
        
    foreach ($perfile in $files)
    {
    if ($perfile -ne $null){
        $reading = Get-Content $perfile.fullname
        $line = $reading[0],$reading[1],$reading[2],$reading[3],$reading[4],$reading[5],$reading[6],$reading[7],$reading[8]
        $dgv1.rows.Add($line)|Out-Null
        }

    }
}

foreach ($file in Get-childitem $ReceivedPath)
{
$dgv2.rows.Clear()
$files = Get-ChildItem -Path $ReceivedPath|Sort-Object -Property lastwritetime
        
  foreach ($perfile in $files)
    {
        $reading = Get-Content $perfile.fullname
        $line = $reading[0],$reading[1],$reading[2],$reading[3],$reading[4],$reading[5]
       $dgv2.rows.Add($line)|Out-Null
       
   }
}

$time = (get-date).ToString()
$qwerty = Get-ChildItem -Path $MainPath|Sort-Object -Property lastwritetime |Select-Object -First 1
#[System.Windows.Forms.MessageBox]::Show($time)
if ($qwerty -ne $null){
    $read = Get-Content $qwerty.fullname
    $line1 = $read[0]
    $time1 = (get-date ($line1)).AddMinutes(1)
    
    if ($time1.tostring() -gt $time){
            #[System.Windows.Forms.MessageBox]::Show($read[0])
            if ($btn6.BackColor -eq 'Red'){
                $btn6.BackColor = 'DarkTurquoise'
                $btn6.ForeColor = 'Black'
            }
            else{
                $btn6.BackColor = 'Red'
                $btn6.Forecolor = 'Yellow'
            }
    
    
    }
    else{
    $btn6.BackColor = 'DarkTurquoise'
    $btn6.Visible = $true
    $btn6.Forecolor = 'Black'
    }
}
Else{
    $btn6.BackColor = 'DarkTurquoise'
    $btn6.Visible = $true
    $btn6.Forecolor = 'Black'
}


$dgv1.ClearSelection()
$dgv2.ClearSelection()
})

#### EVENTS #### #### EVENTS #### #### EVENTS #### #### EVENTS #### #### EVENTS #### #### EVENTS ####


$form_requestform.add_click({
$pos = [System.Windows.Forms.Cursor]::Position
$form_requestform.Text = $pos
})
$txt8.add_keydown({if ($_.keycode -eq "Enter" -or $_.keycode -eq "Tab"){

$btn1.Focus()
}
})
$txt4.add_keydown({if ($_.keycode -eq "Enter" -or $_.keycode -eq "Tab"){

$txt8.Focus()
}
})

$btn3.add_click({
$timer1.Enabled = $false
$form_log.ShowDialog()
})

$dgv1.add_scroll({
$timer1.Enabled = $false
})
$dgv1.add_mouseleave({
$timer1.Enabled = $true
})

 $optbox1.add_click({

 if ($optbox1.Checked -eq $false -and $optbox2.Checked -eq $false){
[System.Windows.Forms.MessageBox]::Show("Please choose shift!")
}
else{
    $date = $dtpicker1.Value
    $date = Get-Date $date -UFormat "%y%m%d"
     $date = ($date + "_DS.txt")
    
     $test = Test-Path ($logfilepath + $date)
     if (!($test)){
     [System.Windows.Forms.MessageBox]::Show("File does not exist!")
      $optbox1.Checked = $false
      $optbox2.Checked = $false
      $dgv3.Rows.Clear()

         }
     else{
     $dgv3.Rows.Clear()
    $header = "0","1","2","3","4","5","6","7","8"

    $a = import-csv ($logfilepath + $date) -Header $header
  
    foreach($file in $a){
    
        $alt0 = $file.'0'
        $alt1 = $file.'1'
        $alt2 = $file.'2'
        $alt3 = $file.'3'
        $alt4 = $file.'4'
        $alt5 = $file.'5'
        $alt6 = $file.'6'
        $alt7 = $file.'7'

        $dgv3.Rows.Add($alt0,$alt1,$alt2,$alt3,$alt4,$alt5,$alt6,$alt7)
        }
         $rowcount = $dgv3.Rows.Count
        for($i = 0;$i -le $rowcount - 1; $i++){
        if ($dgv3.rows[$i].cells[7].Value -eq "Denied"){
            $dgv3.Rows[$i].cells[7].Style.backcolor = 'Red'
            $dgv3.rows[$i].cells[7].style.forecolor = 'Yellow'
            }
            else{
            $dgv3.Rows[$i].cells[7].Style.backcolor = 'LightGreen'
            $dgv3.rows[$i].cells[7].style.forecolor = 'RoyalBlue'
        }
        }
     }
 }
 })


 



 $optbox2.add_click({

 if ($optbox1.Checked -eq $false -and $optbox2.Checked -eq $false){
[System.Windows.MessageBox]::Show("Please choose shift!")
}

else{
    $date = $dtpicker1.Value
    $date = Get-Date $date -UFormat "%y%m%d"
     $date = ($date + "_NS.txt")
    
     $test = Test-Path ($logfilepath + $date)
     if (!($test)){
     [System.Windows.Forms.MessageBox]::Show("File does not exist!")
   
    
     $optbox1.Checked = $false
     $optbox2.Checked = $false
     $dgv3.Rows.Clear()

         }
     else{
     $dgv3.Rows.Clear()
    $header = "0","1","2","3","4","5","6","7","8"

    $a = import-csv ($logfilepath + $date) -Header $header
    foreach($file in $a){
    
        $alt0 = $file.'0'
        $alt1 = $file.'1'
        $alt2 = $file.'2'
        $alt3 = $file.'3'
        $alt4 = $file.'4'
        $alt5 = $file.'5'
        $alt6 = $file.'6'
        $alt7 = $file.'7'
        $dgv3.Rows.Add($alt0,$alt1,$alt2,$alt3,$alt4,$alt5,$alt6,$alt7)   
        }
     }
          $rowcount = $dgv3.Rows.Count
for($i = 0;$i -le $rowcount - 1; $i++){

    if ($dgv3.rows[$i].cells[7].Value -eq "Denied"){
    $dgv3.Rows[$i].cells[7].Style.backcolor = 'Red'
    $dgv3.rows[$i].cells[7].style.forecolor = 'Yellow'
    }
    else{
    $dgv3.Rows[$i].cells[7].Style.backcolor = 'LightGreen'
    $dgv3.rows[$i].cells[7].style.forecolor = 'RoyalBlue'
    }
}
 } 
 })


 $btn5.add_click({

 if ($optbox1.Checked){
    $date = $dtpicker1.Value
    $date = Get-Date $date -UFormat "%y%m%d"
    $date = ($date + "_DS")
    }
 elseif ($optbox2.Checked){
    $date = $dtpicker1.Value
    $date = Get-Date $date -UFormat "%y%m%d"
    $date = ($date + "_NS")
 }
 if ($dgv3.RowCount -eq 0){
 [System.Windows.MessageBox]::Show("Search file first!")
 }
 else{
 $save = New-Object System.Windows.Forms.SaveFileDialog
 $save.InitialDirectory = ($LogfilePath + "ForPrint")
 $save.title = "Save file to ForPrint"
 $save.FileName = $date
 if ($save.ShowDialog() -eq "Ok"){
  
 $a = import-csv ($LogfilePath + $date + ".txt") -Header "Date and Time","Feeder Location","Requested Part Number","Issued Part Number","Barcode","OP Name","Quantity","Status"
 $a|export-csv ($LogfilePath + "ForPrint\" + $date + ".csv") -NoTypeInformation
 [System.Windows.Forms.MessageBox]::Show("Save Successfully!")
 }
 }
 })


 $btn6.add_click({

 $form_requestform.ShowDialog()
 })



 $btn7.add_click({
 if ($txt6.text -eq ""){
  [System.Windows.Forms.MessageBox]::Show("Please enter employee number!")
  $txt6.Focus()
 }
 elseif ($txt6.TextLength -lt 6){
  [System.Windows.Forms.MessageBox]::Show("Check your employee number!")
  $txt6.Focus()
 }
 elseif ($txt7.Text -eq ""){
  [System.Windows.Forms.MessageBox]::Show("Please input control number!")
 }
 else{
 $txt6.Focus() = $false
 $txt7.Focus() = $false
 $btn7.Visible = $false
 $txt7.HideSelection
if ($dgv4.RowCount -ne 0){
  print-Screen2 ("C:\Users\121476\Desktop\FOrPrint\" + $txt7.text+".png")
   if ($dgv4.RowCount -lt 10){
        $a = $dgv4.RowCount    
        for ($i = 0;$i -le $a-1;$i++){
        $dgv4.Rows.RemoveAt(0)
        }
        $form_requestform.Close()
   }
   else{
        for ($i = 0;$i -le 9;$i ++){
        $dgv4.Rows.RemoveAt(0)
        }
         While ($dgv4.RowCount -ne 0){ 
        <# foreach ($file in get-childitem "C:\Users\121476\Desktop\ForPrint"){}
          $cn = $file.BaseName
          $cn = [int]$cn
          $cn = $cn + 1
          $cn = $cn.ToString()
          $cn = $cn.padleft(10,"0")
          $txt7.text = $cn
          $timer1.Enabled = $false#>
          $dgv4.ClearSelection()
          wait-event -sourceIdentifier "ProcessStarted" -timeout 1
          print-Screen2 ("C:\Users\121476\Desktop\FOrPrint\" + $txt7.text+".png")
          
          if ($dgv4.RowCount -lt 10){
        $a = $dgv4.RowCount    
        for ($i = 0;$i -le $a-1;$i++){
        $dgv4.Rows.RemoveAt(0)
        }
        }
        elseif ($dgv4.RowCount -ge 10){
        for ($i = 0;$i -le 9;$i ++){
        $dgv4.Rows.RemoveAt(0)
        }
         }
         }
   }
   $form_requestform.Close() 
   }
else{[System.Windows.Forms.MessageBox]::Show("No data to print!")}    

 
   
}
  <#$txt6.Focus()
  $txt7.Clear()
  $txt6.Clear()
  #>
  
    $btn7.Visible = $true
    
 })


$dgv1.add_CellClick({
param([object]$s,[object]$q)


$col = $dgv1.CurrentCelladdress.x
$row = $dgv1.CurrentCelladdress.y
if ($q.ROWINDEX -ge 0){
    if ($col -eq 0){
        $timer1.enabled = $false

        $txt1.text = $dgv1.rows[$row].Cells[5].value

        $b = "0","1","2"
        $a = import-csv $QTYPath -Header $b|Select-Object -skip 1
        $global:pn = $a|Where-Object {$_.'0' -eq $txt1.text}

        if ($pn.Length -gt 10){
           $qty = "not registered"
        }
        
       
        else{
            $qty = $pn[0].'2'
        }
         $txt5.Text = $qty
        $txt2.Focus()
        

    $form_popup.ShowDialog()
        }
       
    
elseif ($col -eq 1)
{ 
$messagebutton = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to deny the request?","Warning","YesNo")
if($messagebutton -eq 'Yes'){
$timer1.enabled = $false
$data = $dgv1.rows[$row].cells[3].value
$data2 = $dgv1.rows[$row].cells[4].value
$data1 = $dgv1.rows[$row].cells[5].value
$date = get-date -UFormat "%y%m%d"
$now = Get-Date
$dayshift = get-date ("8:00")
$nightshift = get-date ("20:00")
if ($now -lt $dayshift){
$log = $now.AddDays(-1)
$log = Get-Date $log -UFormat "%y%m%d"
$line = "$now, $data2, $data1, - , - , - , - ,Denied"
$line|Out-File ($LogfilePath + $log + "_NS" + ".txt") -Append
Remove-Item ($MainPath + $data + "_" + $data2 + ".txt")
}
elseif ($now -gt $nightshift){
$line = "$now, $data2, $data1, - , - , - , - ,Denied"
$line|Out-File ($LogfilePath + $date + "_NS" + ".txt") -Append
Remove-Item ($MainPath + $data + "_" + $data2 + ".txt")
}
else{
$line = "$now, $data2, $data1, - , - , - , - ,Denied"
$line|Out-File ($LogfilePath + $date + "_DS" + ".txt") -Append
Remove-Item ($MainPath + $data + "_" + $data2 + ".txt")
}
$timer1.enabled = $true
}

}
}
})

$form_popup.add_Shown({

$txt2.Focus()
 
})
$form_requestform.add_Shown({
  ForPrint
  foreach ($file in get-childitem "C:\Users\121476\Desktop\ForPrint"){}
  $cn = $file.BaseName
  $cn = [int]$cn
  $cn = $cn + 1
  $cn = $cn.ToString()
  $cn = $cn.padleft(10,"0")
  $txt7.text = $cn
  $timer1.Enabled = $false
  $dgv4.ClearSelection()
  $txt6.Focus()
})






$btn1.add_click({
 $data = $dgv1.rows[$row].cells[3].value
 $data2 = $dgv1.rows[$row].cells[4].value
 $data4 = $dgv1.rows[$row].cells[5].value
 $data5 = $dgv1.rows[$row].cells[6].value
 $data6 = $dgv1.rows[$row].cells[7].value
 $data7 = $dgv1.rows[$row].cells[8].value
 $data8 = $dgv1.rows[$row].cells[9].value
 $data9 = $dgv1.rows[$row].cells[10].value   


$messagebutton = [System.Windows.Forms.MessageBox]::show('Are you sure?','Warning','YesNo')
if ($messagebutton -eq 'Yes'){
    if ($txt1.text -eq ""){
        [System.Windows.Forms.MessageBox]::show("Please enter the Requested Part Number!", 'Warning!')
    }
    elseif ($txt2.Text -eq ""){
        [System.Windows.Forms.MessageBox]::show("Please enter Issued Part Number!", 'Warning!')
    }
    elseif ($txt3.text -eq ""){
        [System.Windows.Forms.MessageBox]::show("Please scan the barcode!", 'Warning!')
    }
    elseif ($txt4.text -eq ""){
        [System.Windows.Forms.MessageBox]::show("Please enter your name!", 'Warning!')
    }
    elseif ($txt5.Text -eq "NOT REGISTERED"){
        [System.Windows.Forms.MessageBox]::show("Not registered! Please contact PCB Planning!", 'Warning!')
    }
    else{
        if ($txt2.text -eq $data4 -or $txt2.text -eq $data5 -or $txt2.text -eq $data6 -or $txt2.text -eq $data7 -or $txt2.text -eq $data8 -or $txt2.text -eq $data9){
   
        $date = Get-Date -UFormat "%y%m%d"
        $Now = get-date
        $pn = $txt1.text
        $bc = $txt3.text
        $OP = $txt4.Text
        $qt= $txt5.Text
    
     
        $barc = Test-Path ($BarcodePath  + $txt3.text + ".txt")
        if ($txt3.TextLength -lt 10){
        [System.Windows.Forms.MessageBox]::Show("Wrong barcode!")
        }
        elseif ($barc -eq $true) {
            [System.Windows.Forms.MessageBox]::Show("Existing barcode!")
            $txt3.Clear()
            $txt3.Focus()
        }
        elseif ($txt5.Text -eq ""){
             [System.Windows.Forms.MessageBox]::Show("Not registered!")
             }
        elseif ($txt8.Text -eq ""){
             [System.Windows.Forms.MessageBox]::Show("Input Lot Number!")
        }
        Else{
        $data,$data2,$txt1.text,$txt2.Text,$txt3.text,"Accepted"|Out-File ($MainPath + $data + "_" + $data2 + ".txt")
         Move-Item ($MainPath + $data + "_" + $data2 + ".txt") -Destination $ReceivedPath
        
        $dgv1.rows.removeat($row)

        $txt2.text|Out-File ($BarcodePath + $txt3.text + ".txt")
        $txt3.Text|Out-File ($LotPath + $txt8.text + ".txt") -Append
        $receive = Get-Content ($ReceivedPath + $data + "_" + $data2 + ".txt")
        $dgv2.Rows.Add($receive)
        
        $dayshift = get-date ("8:00")
        $nightshift = get-date ("20:00")

            if ($now -lt $dayshift){
                $log = $Now.AddDays(-1)
                $log = Get-Date $log -UFormat "%y%m%d"
                $line = "$now, $data2, $qt, $data4, $pn, $bc, $OP, Accepted"
                $line|Out-File ($LogfilePath + $log + "_NS" + ".txt") -Append
                
                $txt1.text = ""
                $txt2.text = ""
                $txt3.text = ""
                $txt4.Text = ""
                $txt5.Text = ""
                $timer1.enabled = $true
                $form_popup.Close()
            }
            elseif ($now -gt $nightshift) {
                $line = "$now, $data2, $data4, $pn, $bc, $OP, $qt, Accepted"
                $line|Out-File ($LogfilePath + $date + "_NS" + ".txt") -Append
                $txt1.text = ""
                $txt2.text = ""
                $txt3.text = ""
                $txt4.Text = ""
                $txt5.Text = ""
                $timer1.enabled = $true
                $form_popup.Close()
            }
            else{
                $line = "$now, $data2, $data4, $pn, $bc, $OP, $qt, Accepted"
                $line|Out-File ($LogfilePath + $date + "_DS" + ".txt") -Append
                $txt1.text = ""
                $txt2.text = ""
                $txt3.text = ""
                $txt4.Text = ""
                $txt5.Text = ""
                $timer1.enabled = $true
                $form_popup.Close()
            }
            }
        }
        else{
            [System.Windows.Forms.MessageBox]::Show("Check the Part Number to be issued!")
        }
        }
  
}
elseif ($messagebutton -eq 'No'){

}
})

$btn2.add_click({
$txt1.text = ""
$txt2.text = ""
$txt3.text = ""
$txt4.text = ""
$txt5.text = ""
$timer1.enabled = $true
$form_popup.Close()
})

$form_popup.Add_Closing({
$txt1.text = ""
$txt2.text = ""
$txt3.text = ""
$txt4.text = ""
$txt5.text = ""
$timer1.enabled = $true
$form_popup.Close()
})


$form_requestform.Add_Closing({

$timer1.enabled = $true
#$form_popup.Close()

})


$form_main.add_closing({

$timer1.Enabled = $false
})
$form_log.add_closing({

$dgv3.Rows.Clear()
$optbox1.Checked =$false
$optbox2.Checked =$false
$timer1.Enabled = $true
})


#### CONTROLS #### #### CONTROLS #### #### CONTROLS #### #### CONTROLS #### #### CONTROLS #### #### CONTROLS ####
$form_main.Controls.Add($dgv1)
$form_main.Controls.Add($dgv2)
$form_main.Controls.Add($label1)
$form_main.Controls.Add($label2)
$form_main.Controls.Add($btn3)
$form_main.Controls.Add($pic1)
$form_main.Controls.Add($btn6)
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
$form_log.Controls.Add($dgv3)
$form_log.Controls.Add($dtpicker1)
$form_log.Controls.Add($optbox1)
$form_log.Controls.Add($optbox2)
$form_log.Controls.Add($pic2)
$form_log.Controls.Add($btn5)
$form_log.Controls.Add($label9)
$form_requestform.controls.add($dgv4)
$form_requestform.controls.add($dgv5)
$form_requestform.controls.add($label10)
$form_requestform.controls.add($label12)
$form_requestform.controls.add($txt6)
$form_requestform.controls.add($label11)
$form_requestform.controls.add($txt7)
$form_requestform.controls.add($btn7)
$form_main.ShowDialog()