#REPORTS
FUNCTION press_saveButton{
param($login)
$mode = $lb.text
$ln = $cb_line.Text
    $dt = $dtv.text
    $dname = get-date($dt) -UFormat "%y%m%d"
    if($btn_option1.checked -eq $true) {$sh = "DS" } elseif ($btn_option2.checked -eq $true){$sh = "NS"}else{$ss =  "noshift"}
    $logname = -join($dname,"_",$sh,".txt")

    $sfd = New-Object System.Windows.Forms.SaveFileDialog
    $sfd.InitialDirectory = (get-childitem env:|where-object {$_.NAME -eq "USERPROFILE"}).value
    $sfd.DefaultExt = ".csv"
    $sfd.ShowDialog()
    $fpt = $sfd.FileName
    $pt = "$masterShared\logs\log.tmp"

    switch ($mode){
        "REQUEST_HISTORY"{$firstLine = "Date/Time,PIC,Line,Feeder Loc,Part 1,Part 2,Part 3,Part 4,Part 5"
                    $header = "0","1","2","3","4","5","6","7","8"
                    $logpath = "$masterShared\logs\requestPart\$ln\"
                    $fp = -join($logpath,$logname)
                    $csv = import-csv $fp -Header $header
                    $firstLine|Out-File $pt
                    foreach($aa in $csv){
                        $lin = -join($aa.'0',",",$aa.'1',",",$aa.'2',",",$aa.'3',",",$aa.'4',",",$aa.'5',",",$aa.'6',",",$aa.'7',",",$aa.'8') 
                        $lin|Out-File $pt -Append
                        import-csv $pt|Export-Csv $fpt -NoTypeInformation
                        }

                    }
        "TRANSACTIONS"{$firstLine = "Date/Time,Line,Feeder Loc,Requested PN,Issued PN,Issued BCD,PIC"
                    $header = "0","1","2","3","4","5","6"
                    $logpath = "$masterShared\logs\changePart\$ln\"
                    $fp = -join($logpath,$logname)
                    $csv = import-csv $fp -Header $header
                    $firstLine|Out-File $pt
                    foreach($aa in $csv){
                        $lin = -join($aa.'0',",",$aa.'1',",",$aa.'2',",",$aa.'3',",",$aa.'4',",",$aa.'5',",",$aa.'6') 
                        $lin|Out-File $pt -Append
                        import-csv $pt|Export-Csv $fpt -NoTypeInformation
                        }

                    }

        "PART_CHECK_HISTORY"{$firstLine = "Date/Time,Feeder BCD,Feeder Loc,Current PN,Scanned PN,Result,PIC"
                    $header = "0","1","2","3","4","5","6"
                    $logpath = "$masterShared\logs\partsChecking\$ln\"
                    $fp = -join($logpath,$logname)
                    $csv = import-csv $fp -Header $header
                    $firstLine|Out-File $pt
                    foreach($aa in $csv){
                        $lin = -join($aa.'0',",",$aa.'1',",",$aa.'2',",",$aa.'3',",",$aa.'4',",",$aa.'5',",",$aa.'6') 
                        $lin|Out-File $pt -Append
                        import-csv $pt|Export-Csv $fpt -NoTypeInformation
                        }

                    }
    
                   
    }



}
function get-filename{
param($purp)
$dt = $dtv.text
$dname = get-date($dt) -UFormat "%y%m%d"
if($btn_option1.checked -eq $true) {$sh = "DS" } elseif ($btn_option2.checked -eq $true){$sh = "NS"}else{$ss =  "noshift"}
$ln = $cb_line.Text
$logname = -join($dname,"_",$sh,".txt")
#msgbox $logname
if ($ss -ne "noshift"){

switch ($purp){

"REQUEST"{
        $gv.columns.clear()
         $gv.columnCount = 11
         $gv.columns[0].name = "DATE/TIME"
         $gv.columns[1].name = "PIC"
         $gv.columns[2].name = "LINE"
         $gv.columns[3].name = "FEEDER LOCATION"
         $gv.columns[4].name = "PART 1"
         $gv.columns[5].name = "PART 2"
         $gv.columns[6].name = "PART 3"
         $gv.columns[7].name = "PART 5"
         $gv.columns[8].name = "PART 6"
         $gv.columns[9].name = "PART 7"
         $gv.columns[10].name = "PART 8"
         $gv.rows.clear()
         if (test-path "$masterShared\logs\requestPart\$ln\$logname"   ){
         $csv = Import-Csv "$masterShared\logs\requestPart\$ln\$logname" -Header "0","1","2","3","4","5","6","7","8"
         
             foreach ($aa in $csv)
                {
                $ln = $aa.'0',$aa.'1',$aa.'2',$aa.'3',$aa.'4',$aa.'5',$aa.'6',$aa.'7',$aa.'8'
                if ($ln -ne ""){$gv.rows.add($ln)}
                }
            }else{msgbox "NO LOG AT THIS DATE"   }
        }
"CHECK"{
         $gv.columns.clear()
         $gv.columnCount = 7
         $gv.columns[0].name = ""
         $gv.columns[1].name = "LINE"
         $gv.columns[2].name = "FEEDER LOC"
         $gv.columns[3].name = "REQUEST PN"
         $gv.columns[4].name = "ISSUED PN"
         $gv.columns[5].name = "ISSUED BCD"
         $gv.columns[6].name = "PIC"
         $gv.rows.clear()

         if (test-path "$masterShared\logs\partsChecking\$ln\$logname"   ){
         $csv = Import-Csv "$masterShared\logs\changePart\$ln\$logname" -Header "0","1","2","3","4","5","6"
         
             foreach ($aa in $csv)
                {
                $ln = $aa.'0',$aa.'1',$aa.'2',$aa.'3',$aa.'4',$aa.'5',$aa.'6'
                if ($ln -ne ""){$gv.rows.add($ln)}
                }
            }else{msgbox "NO LOG AT THIS DATE"   }

        }
"TRANSACTIONS"{
        $gv.columns.clear()
         $gv.columnCount = 20

         $gv.columns[0].name = "Time Requested"
         $gv.columns[1].name = "Time Needed"
		 $gv.columns[2].name = "Requested By"
         $gv.columns[3].name = "Line"
         $gv.columns[4].name = "Model"
         $gv.columns[5].name = "Feeder Location"
         $gv.columns[6].name = "Main PN"
         $gv.columns[7].name = "Alt1"
         $gv.columns[8].name = "Alt2"
         $gv.columns[9].name = "Alt3"
         $gv.columns[10].name = "Alt4"
         $gv.columns[11].name = "Alt5"
         $gv.columns[12].name = "Alt6"
         $gv.columns[13].name = "Issuance Status"
         $gv.columns[14].name = "Time Issued"
         $gv.columns[15].name = "Issued By"
         $gv.columns[16].name = "Issued Barcode"
         $gv.columns[17].name = "Lot"
         $gv.columns[18].name = "Change Time"
         $gv.columns[19].name = "Change Model"
         $gv.columns[20].name = "PIC"








         $gv.rows.clear()

         if (test-path "$masterShared\logs\transactions\$ln\$logname"   ){
         $csv = Import-Csv "$masterShared\logs\transactions\$ln\$logname" -Header "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"
             foreach ($aa in $csv)
                {
                $ln = $aa.'0',$aa.'1',$aa.'2',$aa.'3',$aa.'4',$aa.'5',$aa.'6',$aa.'7',$aa.'8',$aa.'9',$aa.'10',$aa.'11',$aa.'12',$aa.'13',$aa.'14',$aa.'15',$aa.'16',$aa.'17',$aa.'18',$aa.'19',$aa.'20'
                if ($ln -ne ""){$gv.rows.add($ln)}
                }
            }else{msgbox "NO LOG AT THIS DATE"   }
            }
"LOGS"{
        $gv.columns.clear()
         $gv.columnCount = 3
         $gv.columns[0].name = "DATE/TIME"
         $gv.columns[1].name = "ACTIVITY"
         $gv.columns[2].name = "PIC"
         $gv.rows.clear()

         if (test-path "$masterShared\logs\sysLogs\$ln\$logname"   ){
         $csv = Import-Csv "E:\shared\logs\sysLogs\190625_DS.txt" -Header "0","1","2"
         
             foreach ($aa in $csv)
                {
                $ln = $aa.'0',$aa.'1',$aa.'2'
                if ($ln -ne ""){$gv.rows.add($ln)}
                }
            }else{msgbox "NO LOG AT THIS DATE"   }
            }



       
   



     }
 }else{msgbox "NO SHIFT SCHED SELECTED"} 
 }


function viewReport{
$frm_rep = makeform -size_x 950 -size_y 760 
$frm_rep.startPosition = "CenterScreen"
$dtv = New-Object System.Windows.Forms.DateTimePicker
$dtv.Location = New-Object System.Drawing.Size(10,50)
$dtv.Size = New-Object System.Drawing.Size(250,100)
$dtv.font =  New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::Regular)


$btn_option1 = New-Object System.Windows.Forms.RadioButton
$btn_option2 = New-Object System.Windows.Forms.RadioButton
$btn_option1.Text = "DAYSHIFT"
$btn_option2.Text = "NIGHTSHIFT"
$btn_option1.Location = New-Object System.Drawing.Size(300,50)
$btn_option2.Location = New-Object System.Drawing.Size(400,50)
$lb = makelabel -size_x 800 -size_y 25 -loc_x 100 -loc_y 80 -text "REPORTS"
$lb.textalign = "MiddleLEft"
$gv = makeGridView -size_x 800 -size_y 600 -loc_x 100 -loc_y 105
$gv.autosizeColumnsMode = "AllCells"
$gv.Readonly = $true
$gv.Font =New-Object System.Drawing.font("Century Gothic",10,[System.Drawing.FontStyle]::BOLD)
$gv.BORDERSTYLE = 0


$btn_req = makebutton -size_x 80 -size_y 50 -loc_x 10 -loc_y 100 -text "PARTS REQUEST"
$btn_cha= makebutton -size_x 80 -size_y 50 -loc_x 10 -loc_y 150 -text "PARTS CHANGE"
$btn_che= makebutton -size_x 80 -size_y 50 -loc_x 10 -loc_y 200 -text "PARTS CHECK"
$btn_lIB= makebutton -size_x 80 -size_y 50 -loc_x 10 -loc_y 250 -text "SYSTEM LOGS"
$btn_sv= makebutton -size_x 80 -size_y 50 -loc_x 10 -loc_y 300 -text "SAVE"


$btn_req.add_click({
$lb.text = "REQUEST_HISTORY"
get-filename -purp "REQUEST"
})

$btn_cha.add_click({
$lb.text = "TRANSACTIONS"
get-filename -purp "TRANSACTIONS"
})

$btn_chE.add_click({
$lb.text = "PART_CHECK_HISTORY"
get-filename -purp "CHECK"
})

$btn_Lib.add_click({
$lb.text = "SYSTEM_LOGS"
get-filename -purp "LOGS"
})




$btn_sv.add_click({

press_saveButton
})


$frm_rep.controls.add($btn_option2)
$frm_rep.controls.add($btn_option1)
$frm_rep.controls.add($dtv)
$frm_rep.controls.add($btn_req)
$frm_rep.controls.add($btn_cha)
$frm_rep.controls.add($btn_che)
$frm_rep.controls.add($btn_sv)
$frm_rep.controls.add($btn_lib)
$frm_rep.controls.add($lb)
$frm_rep.controls.add($gv)
$frm_rep.showdialog()

}