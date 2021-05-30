
function databaseCreation{

$frm = makeform 700 300 "database creation"
$frm.startposition = "centerScreen"

$tb_choosefsl = maketextbox 550 25 100 15
$tb_choosebom = maketextbox 550 25 100 50

$bt_choosefsl = makebutton 90 25 10 15
$bt_choosebom = makebutton 90 25 10 50

$lb_choosemodel = makelabel 90 30 10 85
$tb_choosemodel = maketextbox 350 25 100 85

$proceed = makebutton 200 30 10 125
$proceed.text = "PROCEED"

$bt_choosefsl.text = "choose FSL"
$bt_choosebom.text = "choose BOM"
$lb_choosemodel.text = "model: "
$tb_choosefsl.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)
$tb_choosebom.font = New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)


#events
$bt_choosefsl.add_click({
$fd = new-object System.Windows.Forms.OpenFileDialog
$fd.InitialDirectory = "$masterPath\feederSettingList"
$fd.ShowDialog()
$tb_choosefsl.text =  $fd.FileName

})
$bt_choosebom.add_click({
$fd = new-object System.Windows.Forms.OpenFileDialog
$fd.InitialDirectory = "$masterPath\bom"
$fd.ShowDialog()
$tb_choosebom.text =  $fd.FileName

})


$proceed.add_click({
$frm.text = "PLEASE WAIT ONGOING PROGRAM CREATION"
bomCompliler $tb_choosefsl.text   $tb_choosebom.text $tb_choosemodel.text
$frm.text = "PROGRAM FINISHED"
})


























$frm.controls.add($lb_choosemodel)
$frm.controls.add($tb_choosemodel)
$frm.controls.add($tb_choosefsl)
$frm.controls.add($tb_choosebom)
$frm.controls.add($bt_choosefsl)
$frm.controls.add($bt_choosebom)
$frm.controls.add($proceed)
$frm.showdialog()



}