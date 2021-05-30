#partschange
function find_barcodePart{
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
function check_partRelationship{
param($mdl,$fl,$iss)
    if ($iss -eq "DEFAULT"){$res = "Start-up Only"}else{
        
        $dbContent = Import-Csv "$masterPath\modeldb\$mdl.txt" -Header "0","1","2","3","4","5","7","8"
        $ln = $dbContent|Where-Object{$_.'0' -eq $fl}
        if (($ln.'2' -eq $iss) -or ($ln.'3' -eq $iss) -or ($ln.'4' -eq $iss) -or ($ln.'5' -eq $iss) -or ($ln.'6' -eq $iss) -or ($ln.'7' -eq $iss) -or ($ln.'8' -eq $iss))
            {$res = "Alt Part"}else{
            if ($ln."1" -eq $iss){$res = "Main Part"}else{
                $res = "Wrong Part"}
                }
                 }
                $res
        }
function findPart_viaLoc{
param($loc)
$a = Import-Csv "$masterPath\feederdb\feederdb.csv" -Header "0","1","2"|Select-Object -Skip 1
$itsbcd = $a|Where-Object {$_.'0' -eq $fl}
$itsbcd = $itsbcd.'2'

if ($itsbcd -eq "") {$itsbcd = "CANT FIND LOC"}


$itsbcd



}


function checkFeederBarcode{
param($fb,$issPartFL)

$script:feederCSV = Import-Csv "$masterPath\feederdb\feederdb.csv" -Header "0","1","2"|Select-Object -Skip 1
$script:itsbcdo = $feederCSV|Where-Object {$_.'1' -eq $fb}
$script:itsFL = $itsbcdo.'0'
$script:itsBCD = $itsbcdo.'1'
$script:itsPARTBCD = $itsbcdo.'2'

$resa = "NG","NG","NG",""
$x = ($itsbcdo|Measure-Object).count

if ($x -gt 0 ){
    $resa[0] = "OK" 
   
        if ($itsFL -eq $issPartFL){ 
        $resa[1] = "OK"}

        $onBom = check_partRelationship -mdl $mdl -fl $itsFL -iss (find_BarcodePart -bcd $itsPARTBCD)
        
        if ($onBom -ne "WRONG PART"){
        $resa[2] = "OK"
        $resa[3] = $onBom
        }
        
        
        

        }
        $resa
        
      
}
function checkPreviousPartBarcode{
param($bcdofPArt,$feederBCD)
$thePArt = -join($mastershared,"\barcodes\",$bcdofPArt,".txt")
$resa =  "NG","NG","NG","WRONG PART"


if (test-PATH($thePArt)){#PREVIOUS PART BARCODE
    $resa[0] = "OK"

   

    if ($itsPARTBCD -eq $bcdofPArt)
        {$resa[1] = "OK"}

    $onBom = check_partRelationship -mdl $mdl -fl $itsFL -iss (find_BarcodePart -bcd $itsPARTBCD)
       if ($onBom -ne "WRONG PART"){
        $resa[2] = "OK"
        $resa[3] = $onBom
        }
        




    }
     $resa
}
function checkNewPartBarcode{
param($bcdofPArt,$feederBCD)
$thePArt = -join($masterShared,"\barcodes\",$bcdofPArt,".txt")
$resa =  "NG","NG","NG",""


if (test-PATH($thePArt)){#PREVIOUS PART BARCODE
    $resa[0] = "OK"

   
   #MSGBOX "$bcdofPArt _ $issuedBarcode"
    if ($bcdofPArt -eq $issuedBarcode)
        {$resa[1] = "OK"}

        
    $onBom = check_partRelationship -mdl $mdl -fl $issuedFL -iss (find_BarcodePart -bcd $bcdofPArt)
    
       if ($onBom -ne "WRONG PART"){
        $resa[2] = "OK"
        $resa[3] = $onBom
        }




    }
     $resa




}

function clickChange{
param($line,$fl)
#getting data
$file = -join("$mastershared/received/",$line,"_",$fl,".txt")
$file = Get-Content $file
$mdl = $file[12]
$frm_change = makeform 800 700
$frm_change.startposition = "centerScreen"
$frm_change.text = $mdl

$script:issuedPart = $file[16]
$Script:issuedFL = $file[4]
$Script:issuedBarcode = $file[15]




$dgv_opCheck = makeGridView 720 300 40 150
$dgv_opCheck.columnCount = 4
$dgv_opCheck.columns[0].name = "NO."
$dgv_opCheck.columns[1].name = "CHECKPOINT"
$dgv_opCheck.columns[2].name = "RESULT"
$dgv_opCheck.columns[3].name = "REMARKS"
#$dgv_opCheck.rowHeadersVisible = $true
$dgv_opCheck.RowHeadersDefaultCellStyle.BackColor = "lightGreen"
$dgv_opCheck.font =  New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::bold)
$dgv_opCheck.AllowUsertoaddrows = $false
#$dgv_opCheck.rowheaderswidth = 165
$dgv_opCheck.columns[3].width = 100
$dgv_opCheck.columns[2].width = 160
$dgv_opCheck.columns[1].width = 400
$dgv_opCheck.columns[0].width = 40
$dgv_opCheck.readonly = $true
#$dgv_opCheck.selectionmode = "fullRowSelect"
#$dgv_opCheck.rows[0].height = 0 
$dgv_opCheck.borderstyle = 0




$lb_bcd  = makelabel 400 25 65 10 "FEEDER BARCODE"
$lb_bcd.textalign = "middleLeft"
$lb_bcd.borderstyle = 0
$lb_bcd.font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)
$tb_bcd = makeTextbox 400 50 65 35 ""
$tb_bcd.textalign = [System.Windows.Forms.HorizontalAlignment]::Center
$tb_bcd.font =  New-Object System.Drawing.font("Century Gothic",20,[System.Drawing.FontStyle]::BOLD)
$tb_bcd.tabindex = 2


$lb_bcd2  = makelabel 400 25 65 100 "Line:$line      Feeder Loc:$fl"
$lb_bcd2.textalign = "middleLeft"
$lb_bcd2.borderstyle = 0
$lb_bcd2.font = New-Object System.Drawing.font("Century Gothic",15,[System.Drawing.FontStyle]::Regular)


$lb_bcd3  = makelabel 400 100 500 10 ""
$lb_bcd3.textalign = "middleLeft"
$lb_bcd3.borderstyle = 0
$lb_bcd3.font = New-Object System.Drawing.font("Century Gothic",80,[System.Drawing.FontStyle]::BOLD)
$lb_bcd3.borderstyle = 0
$lb_bcd3.textalign = "MiddleCenter"



$frm_change.controls.add($dgv_opCheck)
$frm_change.Controls.add($tb_bcd)
$frm_change.Controls.add($lb_bcd)
$frm_change.Controls.add($lb_bcd3)
$frm_change.Controls.add($lb_bcd2)


$frm_change.add_click({
$frm_change.Text = $frm_change.PointToClient([System.Windows.Forms.Cursor]::Position)
})

$tb_bcd.add_textChanged({
$case = $tb_bcd.text
$len = $case.length
$func = $lb_bcd.text
if ($len -eq 10)
    {
        $dgv_opCheck.clearSelection()
        $rc = $dgv_opCheck.rowCount + 1
        switch ($func)
        {

            
        "NEW PART BARCODE"{

                           $tst = checkNewPartBarcode -bcdofPArt $case -feederBCD $feederBarcode
                                
                           $dgv_opCheck.rows.add($dgv_opCheck.rowCount + 1,"CHECKING NEW PART BARCODE",$tst[0])
                           $dgv_opCheck.rows.add($dgv_opCheck.rowCount + 1,"CHECKING NEW PART VS ISSUED PART",$tst[1],$tst[3])
                           $dgv_opCheck.rows.add($dgv_opCheck.rowCount + 1,"CHECKING NEW PART ON BOM LIST",$tst[2])


                           $lb_bcd.text = "PIC"
                           $tb_bcd.text = ""
                           $tb_bcd.focus()



                              }
        "PREVIOUS PART BARCODE"{
                               
                                $tst = checkPreviousPartBarcode -bcdofPArt $case -feederBCD $feederBarcode
                                
                                $dgv_opCheck.rows.add($dgv_opCheck.rowCount + 1,"CHECKING PREVIOUS PART BARCODE",$tst[0])
                                $dgv_opCheck.rows.add($dgv_opCheck.rowCount + 1,"CHECKING PREVIOUS PART OF CURRENT FEEDER",$tst[1],$tst[3])
    



                                       $lb_bcd.text = "NEW PART BARCODE"
                                       $tb_bcd.text = ""
                                       $tb_bcd.focus()
                                       
                              }                            
        "FEEDER BARCODE"{

                            $tst = checkFeederBarcode -fb $case -issPartFL $issuedFL
                            $script:feederBarcode = $case
                            $dgv_opCheck.rows.add($dgv_opCheck.rowCount + 1,"CHECKING FEEDER BARCODE",$tst[0])
                            $dgv_opCheck.rows.add($dgv_opCheck.rowCount + 1,"CHECKING FEEDER LOC OF ISSUED PART",$tst[1])

                           
                           $lb_bcd.text = "PREVIOUS PART BARCODE"
                           $tb_bcd.text = ""
                           $tb_bcd.focus()
                              }
        "PIC"          {      

                        
                        $fileD = -join($mastershared,"/received/",$line,"_",$fl,".txt")
                        $file = Get-Content $fileD

                        $iRequestTime = $file[0]
                        $iRequestNeed = $file[2]
						$iRequestPic = $file[1]
                        $iLine = $file[3]
                        $iModel = $file[12]
                        $iFeederLocation = $file[4]
                        $iMainPN = $file[5]
                        $iAlt1 = $file[6]
                        $iAlt2 = $file[7]
                        $iAlt3 = $file[8]
                        $iAlt4 = $file[9]
                        $iAlt5 = $file[10]
                        $iAlt6 = $file[11]
                        $istatus = $file[13]
                        $iTimeIssued = $file[18]
                        $iIssuedBy = $file[14]
                        $iIssuedBarcode = $file[15]
                        $iIssuedPart = $file[16]
                        $iLot = $file[17]
                        $ichangeTime = (Get-Date).ToString()
                        $ichangeModel = $mdl
                        $ichangePIC = $tb_bcd.text
                        $ireplacedPart = $itsPARTBCD


                        $toOut = "$iRequestTime,$iRequestNeed,$iRequestPic,$iLine,$iModel,$iFeederLocation,$iMainPN,$iAlt1,$iAlt2,$iAlt3,$iAlt4,$iAlt5,$iAlt6,$istatus,$iTimeIssued,$iIssuedBy,$iIssuedBarcode,$iLot,$ichangeTime,$ichangeModel,$ireplacedPart,$ichangePIC"
                                

                        $ln = $cb_line.Text

                        outlogs -loc "$masterShared\logs\Transactions\$ln\" -line $toOut
                        $frm_change.dispose()
                        Remove-Item $fileD
                        
                        toprompt -msg "part Changed Successfully"

                        $a = import-csv "$masterPath\feederdb\feederdb.csv"
                        $cl = $a|Where-Object {$_.'0' -eq $iFeederLocation}
                        $cl.'2' = $iIssuedBarcode
                        $a|Export-Csv "$masterPath\feederdb\feederdb.csv" -NoTypeInformation

                        
                        
                       }







        }
            $rowcount = $dgv_opCheck.rowcount
            for($i = 0;$i -le $rowcount - 1; $i++){
                    if ($dgv_opCheck.rows[$i].cells[2].Value -eq "NG"){
                    $dgv_opCheck.Rows[$i].CELLS[0].Style.backcolor = 'Red'
                    $dgv_opCheck.rows[$i].CELLS[0].style.forecolor = 'Yellow'
                    $dgv_opCheck.Rows[$i].CELLS[1].Style.backcolor = 'Red'
                    $dgv_opCheck.rows[$i].CELLS[1].style.forecolor = 'Yellow'
                    $dgv_opCheck.Rows[$i].CELLS[2].Style.backcolor = 'Red'
                    $dgv_opCheck.rows[$i].CELLS[2].style.forecolor = 'Yellow'
                    $dgv_opCheck.Rows[$i].CELLS[3].Style.backcolor = 'Red'
                    $dgv_opCheck.rows[$i].CELLS[3].style.forecolor = 'Yellow'
                    $tb_bcd.readonly = $true
                    $tb_bcd.text = "PART CHANGE ERROR!!!"
                    #$dgv_opCheck.ColumnHeadersDefaultCellStyle.BackColor = "Red"
                    $tb_bcd.borderstyle = 1
                    toprompt -msg "PART CHANGE ERROR!!!"

                    }

            }
                           



    }
})


$frm_change.ADD_SHOWN({
$tb_bcd.FOCUS()

})


$frm_change.showdialog()

}