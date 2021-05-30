    
Add-type -AssemblyName System.windows.forms
Add-Type -AssemblyName system.drawing

$global:pathForAll = "C:\ChildPartsControl"

Remove-Module *
Import-Module "$pathForAll\programs\partsIssuance\Functions.psm1" 
Import-Module "$pathForAll\programs\partsIssuance\subwindows.psm1" 




#### Path #### #### Path #### #### Path #### #### Path #### #### Path #### #### Path #### #### Path ####
$MainPath = "$pathForAll\Shared\Request\"
$LotPath = "$pathForAll\Shared\Lot\"
$MasterPath = "$pathForAll\Shared\Request"
$ReceivedPath = "$pathForAll\Shared\Received\"
$TransactionPath = "$pathForAll\Shared\Transaction\"
$global:LogfilePath = "$pathForAll\Shared\logs\receiveRequest\"
$QTYPath = "$pathForAll\partsdb\partsdb.csv"
$BarcodePath = "$pathForAll\Shared\Barcodes\"

#### FORM #### #### FORM #### #### FORM #### #### FORM #### #### FORM #### #### FORM #### #### FORM ####
$form_main = Make_Form -size_x 1366 -size_y 750
$form_main.BackColor = [System.Drawing.Color]::PaleTurquoise
$form_log = make_form -size_x 1366 -size_y 730
$form_log.BackColor = [System.Drawing.Color]::PaleTurquoise

 
 #### LABEL ####  #### LABEL ####  #### LABEL ####  #### LABEL ####  #### LABEL ####  #### LABEL ####
 
$label1 = make_label -size_x 500 -size_y 100 -loc_x 450 -loc_y 10
$label1.Text = "PCB Parts Management"
$label1.ForeColor = [System.Drawing.Color]::RoyalBlue
$label1.Font =(New-Object System.Drawing.font("Stencil",25,[System.Drawing.FontStyle]::BOLD))

$label2 = make_label -size_x 500 -size_y 100 -loc_x 500 -loc_y 350
$label2.Text = "REQUEST STATUS"
$label2.ForeColor = [System.Drawing.Color]::RoyalBlue
$label2.Font =(New-Object System.Drawing.font("Stencil",30,[System.Drawing.FontStyle]::BOLD))



 $label9 = make_label -size_x 500 -size_y 100 -loc_x 125 -loc_y 17
 $label9.Text = "Log Files"
 $label9.ForeColor = [System.Drawing.Color]::RoyalBlue
 $label9.Font =(New-Object System.Drawing.font("Stencil",50,[System.Drawing.FontStyle]::BOLD))
 $label9.TextAlign = "MiddleRight"


$lb_request = make_label -size_x 700 -size_y 20 -loc_x 10 -loc_y 110 
$lb_request.text = "PARTS REQUESTS"
$lb_request.TextAlign = "MiddleLeft"
$lb_request.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$lb_request.BorderStyle = 1

$lb_request.add_click({$cb_quickRequest.Visible = $True})

$chr = [char]0x2713

$cb_quickRequest = New-Object System.Windows.Forms.CheckBox
$cb_quickRequest.top = 112
$cb_quickRequest.Left = 180
$cb_quickRequest.Width = 200
$cb_quickRequest.Height = 15
$cb_quickRequest.FlatStyle = "FLAT"
$cb_quickRequest.BackColor = $form_main.BackColor
$cb_quickRequest.Font = New-Object System.Drawing.font("Arial",8,[System.Drawing.FontStyle]::BOLD)
$cb_quickRequest.Text =" $chr by Line"





$lb_forIssue = make_label -size_x 550 -size_y 20 -loc_x 750 -loc_y 110 
$lb_forIssue.text = "FOR PRINT PARTS"
$lb_forIssue.TextAlign = "MiddleLeft"
$lb_forIssue.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$lb_forIssue.BorderStyle = 1

$lb_forDelivery = make_label -size_x 550 -size_y 20 -loc_x 750 -loc_y 320 
$lb_forDelivery.text = "PARTS FOR ISSUANCE"
$lb_forDelivery.TextAlign = "MiddleLeft"
$lb_forDelivery.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$lb_forDelivery.BorderStyle = 1

$lb_update = make_label 200 30 1125 705 "updated last"
$lb_update.BorderStyle = 0
$lb_update.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::italic)



 #### BUTTON ##### #### BUTTON ##### #### BUTTON ##### #### BUTTON ##### #### BUTTON ##### #### BUTTON #####

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

 $button1 = New-Object System.Windows.Forms.DataGridViewButtonColumn
 $button1.HeaderText = [char]0x2713|Out-Null
 $button1.UseColumnTextForButtonValue = $true
 $button1.text = [char]0x2713
 $button1.Width = 25

 $button1.UseColumnTextForButtonValue|Out-Null
 $button1.FlatStyle = "Popup"

$button2 = New-Object System.Windows.Forms.DataGridViewButtonColumn
$button2.HeaderText = "X"|Out-Null
$button2.UseColumnTextForButtonValue = $true
$button2.text = "X"|Out-Null
$button2.Width = 25

$button2.UseColumnTextForButtonValue|Out-Null
$button2.FlatStyle = "Popup"

$button_issue = New-Object System.Windows.Forms.DataGridViewButtonColumn
#$button_issue.HeaderText = "Issue"
$button_issue.UseColumnTextForButtonValue = $true
$button_issue.text = "Issue"
$button_issue.Width = 25

$button_issue.UseColumnTextForButtonValue|Out-Null
$button_issue.FlatStyle = "Popup"

$button_notissue = New-Object System.Windows.Forms.DataGridViewButtonColumn
#$button_notissue.HeaderText = "Not Issue"
$button_notissue.UseColumnTextForButtonValue = $true
$button_notissue.text = [char]0x2717
$button_notissue.Width = 25

$button_notissue.UseColumnTextForButtonValue|Out-Null
$button_notissue.FlatStyle = "Popup"


$button_return = New-Object System.Windows.Forms.DataGridViewButtonColumn
$button_return.HeaderText = ""
$button_return.UseColumnTextForButtonValue = $true
$button_return.text = [char]0x2717
$button_return.Width = 25
$button_return.UseColumnTextForButtonValue|Out-Null
$button_return.FlatStyle = "Popup"





#### DATAGRIDVIEW #### #### DATAGRIDVIEW #### #### DATAGRIDVIEW #### #### DATAGRIDVIEW #### #### DATAGRIDVIEW ####
#PARTS REQUESTSS
 $dgv1 = Make_dgv -size_x 710 -size_y 570 -loc_x 10 -loc_y 130
 $dgv1.Columns.Add($button1)|Out-Null
 $dgv1.ColumnCount = 11
 $dgv1.Columns[1].Name = "Model"
 $dgv1.Columns[2].Name = "Time Needed"
 $dgv1.Columns[3].Name = "Line No."
 $dgv1.Columns[4].Name = "Feeder Location"
 $dgv1.Columns[5].Name = "Main Part Number"
 $dgv1.Columns[6].Name = "Alt 1"
 $dgv1.Columns[7].Name = "Alt 2"
 $dgv1.Columns[8].Name = "Alt 3"
 $dgv1.Columns[9].Name = "Alt 4"
 $dgv1.Columns[10].Name = "Alt 5"
 $dgv1.Columns[2].Width = 60
 $dgv1.Columns[3].Width = 80
 $dgv1.Columns[4].Width = 65
 $dgv1.Columns[5].Width = 40
 $dgv1.Columns[6].Width = 67
 $dgv1.Columns[7].Width = 40
 $dgv1.Columns[8].Width = 67
 $dgv1.Columns[9].Width = 40
 $dgv1.EnableHeadersVisualStyles = $false
 $dgv1.Columns[0].DefaultCellStyle.BackColor = [System.Drawing.Color]::LightGreen
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
 $dgv1.DefaultCellStyle.WrapMode = [System.Windows.Forms.DataGridViewTriState]::True

  
 #PARTS ISSUANCE
 $dgv2= Make_dgv -size_x 580 -size_y 350 -loc_x 750 -loc_y 340
 $dgv2.Font = New-Object System.Drawing.font("Calibri",10,[System.Drawing.FontStyle]::BOLD)
 $dgv2.Columns.Add($button_issue)|Out-Null
 $dgv2.Columns.Add($button_notissue)|Out-Null
 $dgv2.ColumnCount = 7
 $dgv2.Columns[2].Name = "No."
 $dgv2.Columns[3].Name = "Line"
 $dgv2.Columns[4].name = "Model"
 $dgv2.Columns[5].Name = "Fdr. Loc"
 $dgv2.Columns[6].Name = "Req. Part"
 $dgv2.BorderStyle = "Fixed3D"
 $dgv2.Columns[0].Width = 40
 $dgv2.Columns[1].Width = 40
 $dgv2.Columns[2].Width = 40
 $dgv2.Columns[3].Width = 125
 $dgv2.Columns[4].Width = 120
 $dgv2.Columns[5].Width = 100
 $dgv2.Columns[6].Width = 110
 $dgv2.BackgroundColor = [System.Drawing.Color]::MediumTurquoise
 $dgv2.AllowUserToAddRows = $false
 $dgv2.RowHeadersVisible = $false
 $dgv2.EnableHeadersVisualStyles = $false
 $dgv2.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::Turquoise
 $dgv2.DefaultCellStyle.Alignment = "Middlecenter"
 $dgv2.GridColor = [System.Drawing.Color]::DarkTurquoise
 $dgv2.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"
  $dgv2.Columns[0].DefaultCellStyle.BackColor = [System.Drawing.Color]::LightGreen
 $dgv2.Columns[1].DefaultCellStyle.BackColor =[System.Drawing.Color]::Red
 $dgv2.Columns[1].DefaultCellStyle.ForeColor = [System.Drawing.Color]::Yellow
  $dgv2.ColumnHeadersDefaultCellStyle.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
 $dgv2.ColumnHeadersHeight = 25



 for($i=0;$i -le 5;$i++){
  $dgv2.columns[$i].ReadOnly = $true
 }

 
 $dgv3 = make_dgv -size_x 1250 -size_y 500 -loc_x 50 -loc_y 100
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



 #PARTS FOR PRINT
 $dgv6= Make_dgv -size_x 580 -size_y 180 -loc_x 750 -loc_y 130
 $dgv6.Font = New-Object System.Drawing.font("Calibri",9,[System.Drawing.FontStyle]::Regular)
 $dgv6.RowTemplate.Height = 15
 #$dgv6.Columns.Add($button_issue)|Out-Null
 $dgv6.Columns.Add($button_return)|Out-Null
 $dgv6.ColumnCount = 6
 $dgv6.Columns[1].Name = "No."
 $dgv6.Columns[2].Name = "Line"
 $dgv6.Columns[3].name = "Model"
 $dgv6.Columns[4].Name = "FeederLocation"
 $dgv6.Columns[5].Name = "RequestedPart"
 $dgv6.BorderStyle = "Fixed3D"
 $dgv6.ColumnHeadersDefaultCellStyle.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
 $dgv6.ColumnHeadersHeight = 25

 for($i=0;$i -le 5;$i++){
  $dgv6.columns[$i].ReadOnly = $true
 }

 $dgv6.Columns[0].Width = 30
 $dgv6.Columns[1].Width = 30
 $dgv6.Columns[2].Width = 110
 $dgv6.Columns[3].Width = 150
 $dgv6.Columns[4].Width = 130
 $dgv6.Columns[5].Width = 125
 $dgv6.BackgroundColor = [System.Drawing.Color]::MediumTurquoise
 $dgv6.AllowUserToAddRows = $false
 $dgv6.RowHeadersVisible = $false
 $dgv6.EnableHeadersVisualStyles = $FALSE
 $dgv6.ColumnHeadersDefaultCellStyle.BackColor = [System.Drawing.Color]::Turquoise
 $dgv6.DefaultCellStyle.Alignment = "Middlecenter"
 $dgv6.GridColor = [System.Drawing.Color]::DarkTurquoise
 $dgv6.ColumnHeadersDefaultCellStyle.Alignment = "MiddleCenter"
 #$dgv6.Columns[0].DefaultCellStyle.BackColor = [System.Drawing.Color]::LightGreen
 $dgv6.Columns[0].DefaultCellStyle.BackColor =[System.Drawing.Color]::Red
 $dgv6.Columns[0].DefaultCellStyle.ForeColor = [System.Drawing.Color]::Yellow
 $dgv6.BorderStyle = "Fixed3D"
 $dgv6.ScrollBars = [System.Windows.Forms.ScrollBars]::None




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
$timer1.Interval = 5000

function global:updateRequest{
$dgv1.Rows.Clear()
    foreach ($file in Get-childitem $MainPath){

    $dgv1.rows.Clear()
     $files = Get-ChildItem -Path $MainPath|Sort-Object -Property lastwritetime
     if ($files.count -gt 0){
            $ctr = 0
        foreach ($perfile in $files)
        {
        if ($perfile -ne $null){
            $reading = Get-Content $perfile.fullname
            $line = "",$reading[12],$reading[2],$reading[3],$reading[4],$reading[5],$reading[6],$reading[7],$reading[8],$reading[9],$reading[10],$reading[11]
            $dgv1.rows.Add($line)|Out-Null
            $tm = $dgv1.rows[$ctr].Cells[2].Value
            $tm  =get-date($tm) -UFormat "%H:%m"
            $dgv1.rows[$ctr].Cells[2].Value = $tm
            $ctr++
            }

        }
        }
    }

}
function global:updateToPick{
$dgv6.Rows.Clear()
foreach ($file in Get-childitem "$pathForAll/shared/print"){

$dgv6.rows.Clear()
 $files = Get-ChildItem -Path $pathForAll/shared/print/ |Sort-Object -Property lastwritetime

    foreach ($perfile in $files)
    {
    if ($perfile -ne $null){
        $reading = Get-Content $perfile.fullname
        $cnt = $dgv6.RowCount + 1


        $line = "",$cnt,$reading[3],$reading[12],$reading[4],$reading[5]
        $dgv6.rows.Add($line)|Out-Null
        }

    }
}


}
function global:updateIssued{
$dgv2.Rows.Clear()
$pt = "$pathForAll\shared\issue\"
foreach ($file in Get-childitem $pt)
{
$dgv2.rows.Clear()
$files = Get-ChildItem -Path $pt|Sort-Object -Property lastwritetime
        
  foreach ($perfile in $files)
    {
        $ct = $dgv2.RowCount + 1
        $reading = Get-Content $perfile.fullname
        $line = "","",$ct,$reading[3],$reading[12],$reading[4],$reading[5]
       $dgv2.rows.Add($line)|Out-Null
       
   }
}

}

updateRequest
updateToPick
updateIssued



#### EVENTS #### #### EVENTS #### #### EVENTS #### #### EVENTS #### #### EVENTS #### #### EVENTS ####

$timer1.add_tick({
updateRequest
$lb_Update.text = -join(((get-date).tolongdatestring()),"   ",((get-date).ToShortTimeString()))

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
$dgv6.ClearSelection()
})
$btn3.add_click({
$timer1.Enabled = $false
$form_log.ShowDialog()
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

 #requestFormButton
 $btn6.add_click({
RequestForm
 })




$dgv1.add_CellClick({
    param([object]$s,[object]$q)
    
    $col = $q.columnIndex
    $rw =  $q.rowindex
       
    if ($rw -ge 0){
       if ($col -eq 0){
                #msgbox $rw	
                $ln = $dgv1[3,$rw].Value
                $fl = $dgv1[4,$rw].Value
                $fn = -join($ln,"_",$fl,".txt")



                 if ($dgv6.RowCount -lt 10){
                    if ($cb_quickRequest.Checked){
                        $slot = 10 - $dgv6.RowCount
                        $toMove = Get-ChildItem $MainPath -Filter (-join($ln,"_*"))|Sort-Object -Property lastwritetime|Select-Object -First $slot
                        foreach($perfile in $toMove){Move-Item -Path $perfile.FullName -Destination "$pathForAll\shared\print\"}
                         }else{Move-Item -Path "$pathForAll\shared\request\$fn" -Destination "$pathForAll\shared\print\"}
                        }else{msgbox " maximum of 10 parts only"}

                
                        updateToPick
                        updateRequest
                }
                
    }
})



$dgv6.add_cellClick({
    param([object]$s,[object]$q)
    
    $col = $q.columnIndex
    $rw =  $q.rowindex
       
    if ($rw -ge 0){
       if ($col -eq 0){

       $file = -join($dgv6[2,$rw].Value,"_",$dgv6[4,$rw].Value,".txt")

       
        Move-Item -Path "$pathForAll\shared\PRINT\$file" -Destination "$pathForAll\shared\request\"
                           updateToPick
                          updateRequest


       }}
})



#issue button
$dgv2.add_CellClick({
    param([object]$s,[object]$q)
    
    $col = $q.columnIndex
    $rw =  $q.rowindex
       
    if ($rw -ge 0){
       if ($col -eq 0){
                $a = $dgv2[3,$rw].Value
                $b = $dgv2[5,$rw].Value
                $filee = -join($a,"_",$b) 
                partsAccept -fileN $filee
                }elseif ($col -eq 1)
                    {
                        $a = $dgv2[3,$rw].Value
                        $b = $dgv2[5,$rw].Value
                        $c = $dgv2[4,$rw].Value
                        $d = $dgv2[6,$rw].Value

                        $filee = -join($a,"_",$b) 

                    $now = (Get-Date).ToString()
                    $pn = -join($a,",",$c,",",$b,",",$d)
                    $msg = "$now,Request Denied,$pn"

                    outLogs -loc "$pathForAll\shared\logs\sysLogs\PartsIssuance\" -line $msg

                    Remove-Item "$pathForAll\shared\issue\$filee.txt"
                    updateRequest
                    updateToPick
                    updateIssued
                    }
    }
    
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

$form_main.windowstate = "Maximized"
#### CONTROLS #### #### CONTROLS #### #### CONTROLS #### #### CONTROLS #### #### CONTROLS #### #### CONTROLS ####
$form_main.Controls.add($cb_quickRequest)
$form_main.Controls.Add($dgv1)
$form_main.Controls.Add($dgv6)
$form_main.Controls.Add($dgv2)
$form_main.Controls.Add($label1)
#$form_main.Controls.Add($label2)
$form_main.Controls.Add($btn3)
$form_main.Controls.Add($pic1)
$form_main.Controls.Add($btn6)
$form_main.Controls.Add($lb_request)
$form_main.Controls.Add($lb_forIssue)
$form_main.Controls.Add($lb_forDelivery)
$form_main.Controls.Add($lb_Update)

$form_log.Controls.Add($dgv3)
$form_log.Controls.Add($dtpicker1)
$form_log.Controls.Add($optbox1)
$form_log.Controls.Add($optbox2)
$form_log.Controls.Add($pic2)
$form_log.Controls.Add($btn5)
$form_log.Controls.Add($label9)

$form_main.ShowDialog()