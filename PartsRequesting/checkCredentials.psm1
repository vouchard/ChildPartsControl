#AUTHENTICATION popPUP
function EnterCredentials{
param($pw)
$frm = makeform -size_x 440 -size_y 210
$frm.startPosition = "CenterScreen"
$frm.BACKcOLOR = "MIDNIGHTBLUE"
$frm.MaximumSize = $frm.size

$btn = makebutton -size_x 150 -size_y 30 -loc_x 260 -loc_y 110 -text "OK" 
$btn.backColor = "Green"
$btn.ForeColor = "Navy"

$tb1 = maketextbox -size_x 400 -size_y 40 -loc_x 10 -loc_y 30
$lb1 = makeLAbel -size_x 400 -size_y 20 -loc_x 10 -loc_y 10 -text "USER"
$tb2 = maketextbox -size_x 400 -size_y 150 -loc_x 10 -loc_y 110
$lb2 = makeLAbel -size_x 400 -size_y 20 -loc_x 10 -loc_y 90 -text "Password"
$lb1.BorderStyle = 0
$lb2.BorderStyle = 0
$lb1.ForeColor = "WHITE"
$lb2.ForeColor = "WHITE"

$lb1.TextAlign = "MiddleLeft"
$tb1.TextAlign = "Left"
$lb2.TextAlign = "MiddleLeft"
$tb2.TextAlign = "Left"


$tb1.TabIndex = 0
$tb2.TabIndex = 1
$btn.TabIndex = 2

$lb1.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::ITALIC)
$lb2.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::ITALIC)
$tb2.UseSystemPasswordChar = $true

$btn.add_click({

if ($tb1.text -eq ""){msgbox "Please Provide UserName"}else{

    if ($tb2.text -ne $pw){msgbox "WRONG PASSWORD"}
    else{

    $global:userNow = $tb1.text
    $global:allowUser = $true

        $frm.dispose()
    }
    }

})










$frm.controls.add($btn)
$frm.controls.add($lb2)
$frm.controls.add($tb2)
$frm.controls.add($lb1)
$frm.controls.add($tb1)
$frm.showdialog()

}