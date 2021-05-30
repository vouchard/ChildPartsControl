

add-type -AssemblyName system.windows.forms
add-type -AssemblyName system.drawing
cls
$global:masterPath = "C:\ChildPartsControl"
$global:masterShared = "E:\shared"
$global:allowUser = $false
$global:userNow

[System.Windows.Forms.Application]::EnableVisualStyles()


function addPartstoGridview{
param($model)
$header = "0","1","2","3","4","5","6","7","8"

$db = import-csv "$masterpath\modeldb\$model.txt" -Header $header
#$db|Out-GridView
$dgv_partsList.Rows.Clear()
    for($i = 0;$i -le $db.length;$i++){
    
    $alt0 = ($db[$i]).'0'
    $alt1 = ($db[$i]).'1'
    $alt2 = ($db[$i]).'2' 
    $alt3 = ($db[$i]).'3'
    $alt4 = ($db[$i]).'4'
    $alt5 = ($db[$i]).'5'
    $alt6 = ($db[$i]).'6'
    $alt7 = ($db[$i]).'7'

    
     $dgv_partsList.Rows.Add("REQUEST",$alt0,$alt1,$alt2,$alt3,$alt4,$alt5,$alt6,$alt7)
      
    }

}
function sendReqData{
param($line,$rw,$fl,$p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8)



if ($fl -eq ""){$fl = "-"}
if ($p1 -eq ""){$pl = "-"}
if ($p2 -eq ""){$p2 = "-"}
if ($p3 -eq ""){$p3 = "-"}
if ($p4 -eq ""){$p4 = "-"}
if ($p5 -eq ""){$p5 = "-"}
if ($p6 -eq ""){$p6 = "-"}
if ($p7 -eq ""){$p7 = "-"}
if ($fl -eq $null){$fl = "-"}
if ($p1 -eq $null){$pl = "-"}
if ($p2 -eq $null){$p2 = "-"}
if ($p3 -eq $null){$p3 = "-"}
if ($p4 -eq $null){$p4 = "-"}
if ($p5 -eq $null){$p5 = "-"}
if ($p6 -eq $null){$p6 = "-"}
if ($p7 -eq $null){$p7 = "-"}






$fn = -join($line,"_",$fl)
$filename = "$masterShared\Request\$fn.txt"
$filename2 = "$masterShared\received\$fn.txt"
$filename3 = "$masterShared\print\$fn.txt"
$filename4 = "$masterShared\issue\$fn.txt"


$t = get-date


$ts0 = Test-Path $filename
$ts1 = Test-Path $filename2
$ts2 = Test-Path $filename3
$ts3 = Test-Path $filename4


if ($ts0 -eq $false){
    if ($ts1 -eq $false){
        if ($ts2 -eq $false){
            if ($ts3 -eq $false){
                    $tneed  =$t.AddMinutes(20)
                    $t.ToString()|out-file $filename -Append
                    $tb_pic.Text|out-file $filename -Append
                    $tneed.ToString()|out-file $filename -Append
                    $line|out-file $filename -Append
                    $fl|out-file $filename -Append
                    $p1|out-file $filename -Append
                    $p2|out-file $filename -Append
                    $p3|out-file $filename -Append
                    $p4|out-file $filename -Append
                    $p5|out-file $filename -Append
                    $p6|out-file $filename -Append
                    $p7|out-file $filename -Append
                    $p8|out-file $filename -Append
                    $pic = $tb_Pic.Text
                    $ln = $cb_LINE.Text
                    $req = "$t,$pic,$line,$fl,$p1,$p2,$p3,$p4,$p5,$p6,$p7,$p8"
                    outLogs -loc "$masterShared\logs\requestPart\$ln\" -line $req    

            }else{ msgbox "Please change part ongoing"}
        }else{ msgbox "Please change part ongoing"}
    }else{ msgbox "Please change part first"}
}else{ msgbox "Request is already ongoing"}
}
function readSentData{
$req = Get-ChildItem "$masterShared\Request\" -filter (-join(($cb_Line.text),"*"))
$dgv_requestlist.rows.Clear()
foreach ($aa in $req)
    {
        try{
        $gtc = Get-Content $aa.FullName
        $line = $gtc[0],$gtc[3],$gtc[4],$gtc[5],$gtc[1]
        $dgv_requestlist.Rows.Add($line)|Out-Null 
            }
        catch{toprompt -msg "File already moved"}


    }
$req = Get-ChildItem "$masterShared\Print\" -filter (-join(($cb_Line.text),"*"))
foreach ($aa in $req)
    {
        try{
        $gtc = Get-Content $aa.FullName
        $line = $gtc[0],$gtc[3],$gtc[4],$gtc[5],$gtc[1]
        $dgv_requestlist.Rows.Add($line)|Out-Null 
            }
        catch{toprompt -msg "File already moved"}
    }
	
$req = Get-ChildItem "$masterShared\Issue\" -filter (-join(($cb_Line.text),"*"))
foreach ($aa in $req)
    {
        try{
        $gtc = Get-Content $aa.FullName
        $line = $gtc[0],$gtc[3],$gtc[4],$gtc[5],$gtc[1]
        $dgv_requestlist.Rows.Add($line)|Out-Null 
            }
        catch{toprompt -msg "File already moved"} 
    }
}
function readToRecieveData{
$files = Get-ChildItem -Path "$masterShared\Received" -filter (-join(($cb_Line.text),"*"))
        $dgv_change.rows.Clear()
    foreach ($perfile in $files)
    {
        if ($perfile -ne $null){
        $reading = Get-Content $perfile.fullname
        $line = "CHANGE",$reading[3],$reading[4],$reading[15],$reading[5],$reading[16]
        $dgv_change.rows.Add($line)|Out-Null
        }
    }

}
function autoUpdate{
readTorecieveData
readSentData
$lb_update.Text = Get-Date
}



$timer = New-Object System.Windows.Forms.Timer
$timer.Interval =2000
$timer.add_tick({
autoUpdate
})

$timer.Enabled |Out-Null
$timer.Start()


Remove-Module *
Import-Module "$masterPath\programs\PartsRequesting\functions.psm1" 
Import-Module "$masterPath\programs\PartsRequesting\dbCreator.psm1" 
Import-Module "$masterPath\Programs\PartsRequesting\partChange.psm1"
Import-Module "$masterPath\Programs\PartsRequesting\feederLibrary.psm1"
Import-Module "$masterPath\Programs\PartsRequesting\modelLibrary.psm1" 
Import-Module "$masterpath\Programs\PartsRequesting\partsLibrary.psm1" 
Import-Module "$masterpath\Programs\PartsRequesting\partsChecking.psm1"
Import-Module "$masterpath\Programs\PartsRequesting\Reports.psm1" 
Import-Module "$masterpath\Programs\PartsRequesting\checkCredentials.psm1"
Import-Module "$masterpath\Programs\PartsRequesting\changeModel.psm1"

#Creating Main Form
#change data grid view
$frm_Main = makeForm 1366 768
#$frm_Main.WindowState = "maximize"
$title = makeLabel 1000 60 190 0 "PCB PARTS MANAGEMENT SYSTEM"
$title.font = New-Object System.Drawing.font("cALIBRI",35,[System.Drawing.FontStyle]::BOLD)
$title.TextAlign = "TOPlEFT"
$title.BorderStyle = 0
$dgvButton = makeDGVButton
$dgvButton.FlatStyle = "POPUP"

$pb = New-Object System.Windows.Forms.PictureBox
$pb.Location = New-Object System.Drawing.Size(20,0)
$pb.size = New-Object System.Drawing.Size(150,75)
#$pb.BorderStyle = 1
$pb.SizeMode = 2
$pb.ImageLocation ="$masterPath\programs\canonLogo.png"

$lb_change = makelabel 595 20 750 130 "READY FOR CHANGE"
$lb_change.TextAlign = "MiddleLeft"
$lb_change.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)

$dgv_change = makeGridView 595 250 750 150 "For Change"
$dgv_change.font =  New-Object System.Drawing.font("Arial",10,[System.Drawing.FontStyle]::bold)
$dgv_change.Columns.Add($dgvButton)|Out-Null
$dgv_change.columnCount = 6
$dgv_change.columns[0].Name = "Change"
$dgv_change.columns[1].Name = "Line"
$dgv_change.columns[2].Name = "Feeder Location"
$dgv_change.columns[3].Name = "Barcode"
$dgv_change.columns[4].Name = "Requested Part"
$dgv_change.columns[5].Name = "Issued Part"
$dgv_change.columns[0].WIDTH = 70
$dgv_change.columns[1].WIDTH = 80
$dgv_change.columns[2].WIDTH = 110
$dgv_change.columns[3].WIDTH = 110
$dgv_change.columns[4].WIDTH = 110
$dgv_change.columns[5].WIDTH = 110
$dgv_change.ColumnHeadersHeight = 40
$dgv_change.Columns[0].DEFAULTCELLSTYLE.BACKCOLOR = "lIGHTGREEN"
$dgv_change.GridColor = "gREEN"


$dgvButton = makeDGVButton
$dgvButton.Selected = $false
$dgvButton.FlatStyle = "POPUP"

$lb_parts = makelabel 705 20 30 130 "PARTS LIST"
$lb_parts.TextAlign = "MiddleLeft"
$lb_parts.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$dgv_partsList = makeGridView 705 570 30 150 "aaa"
$dgv_partsList.Font = New-Object System.Drawing.font("Century Gothic",8,[System.Drawing.FontStyle]::BOLD)
$dgv_partsList.Columns.Add($dgvButton)|Out-Null
$dgv_partsList.ColumnCount = 9
$dgv_partsList.columns[0].Name = "Request"
$dgv_partsList.columns[3].Name = "Alt 1"
$dgv_partsList.columns[1].Name = "Feeder Location"
$dgv_partsList.columns[2].Name = "Main Part No."
$dgv_partsList.columns[3].Name = "Alernate Part No. 1"
$dgv_partsList.columns[4].Name = "Alernate Part No. 2"
$dgv_partsList.columns[5].Name = "Alernate Part No. 3"
$dgv_partsList.columns[6].Name = "Alernate Part No. 4"
$dgv_partsList.columns[7].Name = "Alernate Part No. 5"
$dgv_partsList.columns[8].Name = "Alernate Part No. 6"
#$dgv_partsList.columns[9].Name = "Alernate Part No. 7"
$dgv_partsList.columns[0].width = 70
$dgv_partsList.columns[1].width = 80
$dgv_partsList.columns[2].width = 110
$dgv_partsList.columns[3].width = $dgv_partsList.columns[2].width
$dgv_partsList.columns[4].width = $dgv_partsList.columns[2].width
$dgv_partsList.columns[5].width = $dgv_partsList.columns[2].width
$dgv_partsList.columns[6].width = $dgv_partsList.columns[2].width
$dgv_partsList.columns[7].width = $dgv_partsList.columns[2].width
$dgv_partsList.columns[8].width = $dgv_partsList.columns[2].width
#$dgv_partsList.columns[9].width = $dgv_partsList.columns[2].width
$dgv_partsList.ReadOnly = $true
$dgv_partsList.ColumnHeadersHeight = 40
$dgv_partsList.Columns[0].DEFAULTCELLSTYLE.BACKCOLOR = "lIGHTGREEN"
$dgv_partsList.GridColor = "gREEN"



#Request DataGridView
$lb_request = makelabel 600 20 750 410 "ONGOING REQUESTS"
$lb_request.TextAlign = "MiddleLeft"
$lb_request.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$dgv_requestList = makeGridView 600 290 750 430 "aaa"
$dgv_requestList.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$dgv_requestList.ColumnCount = 5
$dgv_requestList.columns[0].Name = "Time"
$dgv_requestList.columns[1].Name = "Line"
$dgv_requestList.columns[2].Name = "Feeder"
$dgv_requestList.columns[3].Name = "Main Part"
$dgv_requestList.columns[4].Name = "PIC"
$dgv_requestList.columns[0].width = 160
$dgv_requestList.columns[1].width = 105
$dgv_requestList.columns[2].width = 105
$dgv_requestList.columns[3].width = 120
$dgv_requestList.columns[4].width = $dgv_requestList.columns[2].width
$dgv_requestList.ReadOnly = $true
$dgv_requestList.ColumnHeadersHeight = 20
$dgv_requestList.GridColor = "gREEN"



$lb1 = makelabel 130 20 30 75 "LINE:"
$global:cb_line = makeCombobox 130 13.5 30 95 "adadad"
$lb1.TextAlign = "middleLeft"
$lb1.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)

$lb3 = makelabel 130 20 180 75 "SHIFT:"
$cb_shift = makeCombobox 130 13.5 180 95 "adadad"
$lb3.TextAlign = "middleLeft"
$lb3.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)


$global:lb_model = makeLabel 130 30 330 95 ""
$lb_model.TextAlign = "middleLeft"
$btn_mdl = makeButton 130 20 330 75 "MODEL:"
$btn_mdl.TextAlign = "middleLeft"
$btn_mdl.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)

$lb4 = makelabel 160 20 480 75 "PIC:"
$tb_pic = maketextbox 160 12.5 480 95
$lb4.TextAlign = "middleLeft"
$lb4.Font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)
$lb4.BorderStyle = 1

$lb_update = makeLabel 200 15 20 725 "updated last"
$lb_update.BorderStyle = 0
$lb_update.Font = New-Object System.Drawing.font("Century Gothic",8,[System.Drawing.FontStyle]::italic)

$cp = [char]0x00A9
$lb_cpr = makeLabel 400 15 950 725 "$cp 2019 Canon Business Machines Philippines-PCB Department"
$lb_cpr.BorderStyle = 0
$lb_cpr.Font = New-Object System.Drawing.font("Century Gothic",7.5,[System.Drawing.FontStyle]::italic)



$btn_partsCheck = makebutton 80 50 930 75 "Parts Checking"
$btn_FLLib = makebutton 80 50 1010 75 "Feeder Library"
$btn_partsLib= makebutton 80 50 1090 75 "Parts Library"
$btn_modelLib = makebutton 80 50 1170 75 "Model Library"
#$btn_newModel = makebutton 80 50 1250 60 "New Model"
$btn_Reports = makebutton 80 50 1250 75 "Reports"




$cb_LINE.Items.Add("L1Front")|Out-Null
$cb_LINE.Items.Add("L1Rear")|Out-Null
$cb_LINE.Items.Add("LINE2")|Out-Null
#$cb_LINE.Items.Add("L1AVRG")|Out-Null
#$cb_LINE.Items.Add("MIPP")|Out-Null





$cb_LINE.Text= Get-Content "$masterPath\programs\partsRequesting\default_model.txt"
$cb_shift.Items.Add("A")|Out-Null
$cb_shift.Items.Add("B")|Out-Null
$cb_shift.Items.Add("C")|Out-Null


#EVENTSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
$frm_Main.add_closed({
$timer.stop()
$timer.Dispose()
$frm_Main.Dispose()
})
$dgv_partsList.add_cellClick({
param([object]$sender,[object]$e)
if ($e.rowIndex -ne -1){
    if($e.columnIndex -eq 0){
        
        $test_line = $cb_line.Text -eq ""
        $test_op = $tb_pic.Text -eq ""
        $test_model = $lb_model.Text -eq ""
        $test_shift = $cb_shift.Text -eq ""

        $test_all = $test_line -or $test_op -or $test_model -or $test_shift
        
        if ($test_all -eq $TRUE){msgbox "SOME DATA IS MISSING PLEASE CHECK"}else{
            $rw = $dgv_partsList.CurrentRow.Index
            $fl = $dgv_partsList.CurrentRow.Cells[1].Value
            $p1 = $dgv_partsList.CurrentRow.Cells[2].Value
            $p2 = $dgv_partsList.CurrentRow.Cells[3].Value
            $p3 = $dgv_partsList.CurrentRow.Cells[4].Value
            $p4 = $dgv_partsList.CurrentRow.Cells[5].Value
            $p5 = $dgv_partsList.CurrentRow.Cells[6].Value
            $p6 = $dgv_partsList.CurrentRow.Cells[7].Value
            $p7 = $dgv_partsList.CurrentRow.Cells[8].Value
            $p8 = $lb_model.text
            #msgbox $cb_line.Text
			
            $mdl = $lb_model.text
            $ms =  "MODEL: $mdl `n FEEDER LOC: $fl "
            $response = [System.Windows.Forms.MessageBox]::Show($ms,'Warning','YesNo')
           # msgbox $response
            if ($response -eq 'Yes'){
                 if ((Test-Path E:) -eq $false){
                    msgbox "cannot connect to drive E: (parts Issuance PC, Please Reboot)"
                   }else{

                sendReqData $cb_line.Text $rw $fl $p1 $p2 $p3 $p4 $p5 $p6 $p7 $p8
                readSentData
                toprompt -msg "Part Requested:$fl"

                }
            }
        }
}
}

})


$btn_mdl.add_click({changeModel})

$lb_model.add_textchanged({
$fl = $lb_model.Text
$asd = Test-Path ("$masterPath\modeldb\$fl.txt")

if ($asd -eq $true){
addPartstoGridview -model $lb_model.Text
}

})
$dgv_change.add_cellClick({
param([object]$sender,[object]$e)
if ($e.rowIndex -ne -1){
    if($e.columnIndex -eq 0){
        if ($lb_model.text -ne ""){
            $pn = $dgv_change.CurrentRow.Cells[4].Value 
            $ln = $dgv_change.CurrentRow.Cells[1].Value 
            $fl = $dgv_change.CurrentRow.Cells[2].Value 
            $bcd = $dgv_change.CurrentRow.Cells[3].Value 
            $mdl = $lb_model.Text

            clickChange -pn $pn -bcd $bcd -fl $fl -line $ln -mdl $mdl
            }else{msgbox "PLEASE SELECT MODEL"}

    }}
})
$dgv_change.add_scroll({$timer.enabled = $false})
$dgv_change.add_mouseLeave({$timer.enabled = $true})






$btn_FLLib.add_click({


EnterCredentials -pw "pcb@123"
if ($global:allowUser -eq $true){
feederLibrary -mainCsv $lb_model.Text
$global:allowUser = $false}





})
$btn_Reports.add_click({

EnterCredentials -pw "pcb@123"
if ($global:allowUser -eq $true){
ViewReport
$global:allowUser = $false}


})
$btn_modelLib.add_click({
#databaseCreation
EnterCredentials -pw "pcb@123"
if ($global:allowUser -eq $true){showModelLib;$global:allowUser = $false}
#showModelLib

})
$btn_partsCheck.add_Click({

if ($lb_model.Text -ne ""){


EnterCredentials -pw "pcb@123"
if ($global:allowUser -eq $true){
CheckParts -model $lb_model.Text
$global:allowUser = $false}





}else{

msgbox "PLEASE SELECT MODEL"
}

})
$btn_partsLib.add_click({


EnterCredentials -pw "pcb@123"
if ($global:allowUser -eq $true){
showPartsLib
$global:allowUser = $false}






})

$frm_Main.Controls.Add($lb_cpr)
$frm_Main.Controls.Add($btn_partsCheck)
$frm_Main.Controls.Add($btn_reports)
$frm_Main.Controls.Add($btn_partsLib)
$frm_Main.Controls.Add($btn_FLLib)
$frm_Main.Controls.Add($btn_modelLib)
$frm_Main.Controls.Add($lb_update)
$frm_Main.Controls.Add($lb4)
$frm_Main.Controls.Add($tb_pic)
$frm_Main.Controls.Add($makebutton)
$frm_Main.controls.add($cb_shift)
$frm_Main.controls.add($cb_Line)
$frm_Main.controls.add($lb_model)
$frm_Main.Controls.Add($lb3)
$frm_Main.Controls.Add($btn_mdl)
$frm_Main.Controls.Add($lb1)
$frm_Main.Controls.Add($lb_request)
$frm_Main.Controls.Add($dgv_requestList)
$frm_Main.controls.Add($lb_parts)
$frm_Main.controls.Add($lb_change)
$frm_Main.Controls.Add($title)
$frm_Main.Controls.Add($dgv_change)
$frm_Main.Controls.Add($dgv_partsList)
$frm_Main.Controls.Add($pb)
$frm_Main.showdialog()

