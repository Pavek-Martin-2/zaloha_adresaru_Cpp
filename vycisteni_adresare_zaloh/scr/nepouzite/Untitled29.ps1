cls
# tridi adresar ruzne
$cesta = "C:\Users\DELL\Documents\zaloha\ruzne"
$start_date = (get-date)
$pole = @()
$pole += Get-ChildItem -Path $cesta -Include *.zip -Name
$d_pole = $pole.LongLength
$smazat_stare = @()

$sulfix = @(
"-ps1.zip",
"-QL_SAVE.zip",
"-ubuntu.zip",
"-Dos.zip", # dosbox
"-WindowsPowerShell.zip",
"-screenshots.zip",
"-Ballon_story.zip", # na git pak nedavat <<<<<<<<<<<<<<<<<<<<<<< !
"-GW323.zip", # dosbox
"-QBASIC45.zip", # dosbox
"-TC10.zip", # dosbox
"-TP70.zip", # dosbox
"-UTILS.zip", # dosbox
"-Lua52_Win32.zip",
"-Desktop.zip",
"-Start Menu.zip",
"-navody.zip",
"-BC31.zip" # dosbox
"-BaseCamp.zip",
"-tools.zip",
"-Dev-Cpp.zip",
"-login.zip"
)
$d_sulfix = $sulfix.Length
#echo $d_sulfix # 20

#echo $d_pole # pocet souboru zip v "ruzne/"

for ( $aa = 0; $aa -le $d_sulfix -1; $aa++ ){ 
$polozka_sulfix = $sulfix[$aa]
#echo $polozka_sulfix
#} # for aa

#$pocet_stejnych_zipu = 0
$pole_stejny_druh_zipu = @() # pole se vzdy nuluje, pri kazdem pruchodu cyklem

for ( $bb = 0; $bb -le $d_pole -1; $bb++ ){                  
$file = $pole[$bb]
#echo $file

$d_file = $file.Length # sulfix souboru zip ( napr. "-ps1.zip" apod. )
$nazev = $file.Substring(19, $d_file -19)
#echo $nazev"<<"

# shoda

if ( $polozka_sulfix -like $nazev ){
#echo "xx"
#echo $file
$pole_stejny_druh_zipu += $file
#$pocet_stejnych_zipu++
}

} # for bb

# stejne soubory zip (stejneho druhu zalohy)
$d_pole_stejny_druh_zipu = $pole_stejny_druh_zipu.Length
if ($d_pole_stejny_druh_zipu -gt 1 ) { # pole musi mit vice nez jednu polozku *.zip
#write-host -ForegroundColor red "$d_pole_stejny_druh_zipu stejne"
#echo $d_pole_stejny_druh_zipu
#write-host -ForegroundColor blue $pole_stejny_druh_zipu

for ( $cc = 0; $cc -le $d_pole_stejny_druh_zipu -1; $cc++ ){
$polozka_pole_stejny_druh_zipu = $pole_stejny_druh_zipu[$cc]
#write-host -ForegroundColor yellow $polozka_pole_stejny_druh_zipu

# z nazvu souboru "zip" zjisti stari souboru a spocita pocet vterin kdy byl vytvoren od datum "ted"
$file_cas = $polozka_pole_stejny_druh_zipu.Substring(0,19) # prefix souboru zip
#echo $file_cas

# sestavi z pefixu souboru string pro vypocet rozdilu datumu ve vterinach
$dat = ""
$dat += $file_cas.Substring(3,2) + "/" + $file_cas.Substring(0,2) + "/" + $file_cas.Substring(6,4) + " "
$dat += $file_cas.Substring(11,2) + ":" + $file_cas.Substring(14,2) + ":" + $file_cas.Substring(17,2)
#write-host -ForegroundColor blue $dat

# prevod na rozdil vterin filename "zip" od casu "ted"
$end_date = [datetime] $dat
$rozdil = New-TimeSpan -Start $start_date -End $end_date
[int32] $rozdil_vterin = $rozdil.TotalSeconds
$vterin = $rozdil_vterin - ( 2 * $rozdil_vterin)
#echo "stari souboru vterin - $vterin" # int32
# mazat soubory z nejvetsim rozdilem vterin a nechat jenom jeden z nejmensim poctem rozdilu vterin od "ted"

# zjisteni nejmensi hodnoty rozdilu vterin pro ponechani souboru, bude probyhat dvoufazove
# napred se projede pole a zjisti se vnem nejnizzi hodnota, ta se preulozi do promene
# a pak se projede pole souboru a smaze se vse co nebude odpovidat nalezenemu nejnizssimu rozdilu vterin

$nejnovejsi = 0
$filename_nemazat = 0
#$index_pole_nejnovejsi

if ( $vterin -gt $nejnovejsi ){
$nejnovejsi = $vterin # preulozi se vzdycky vyssi hodnota
$index_pole_nejnovejsi = $cc # uchovani indexu pole, preulozenim jinam
}

} # for cc

# nalezeno nejnovejsi zip(y)
#write-host -ForegroundColor cyan "nejnovejsi : $nejnovejsi"
#echo "najnovejsi je na indexu [$index_pole_nejnovejsi]"
#write-host -ForegroundColor white $pole_stejny_druh_zipu[$index_pole_nejnovejsi]
$filename_nemazat = $pole_stejny_druh_zipu[$index_pole_nejnovejsi]
#write-host -ForegroundColor white "$filename_nemazat <- PONECHAT NEJNOVEJSI"
write-host -ForegroundColor red $filename_nemazat

# mazani stareho neaktualniho a ponechani pouze jednoho nejnovejsiho "zipu"
for ( $dd = 0; $dd -le $d_pole_stejny_druh_zipu -1; $dd++ ){
$polozka_pole_stejny_druh_zipu_2 = $pole_stejny_druh_zipu[$dd]
#write-host -ForegroundColor yellow $polozka_pole_stejny_druh_zipu_2

if ( $polozka_pole_stejny_druh_zipu_2 -notlike $filename_nemazat){
$smazat_soubor = $polozka_pole_stejny_druh_zipu_2
#echo "$smazat_soubor <- neaktulni bube smazano"
write-host -ForegroundColor white $smazat_soubor

# pridani polozky do pole smazat_stare
$vloz_smazat_stare = $cesta
$vloz_smazat_stare += "\"
$vloz_smazat_stare += $smazat_soubor
#echo $vloz_smazat_stare
$smazat_stare += $vloz_smazat_stare

} # if smazat vse starsi

} # for dd
echo ""
} # konec if ($d_pole_stejny_druh_zipu -gt 1

# echo "-------------------------------------------------" # tady je vydet krery soubory vynechal (jsou 1x)
} # for aa

# udelat pole smazej soubory a nechat potvrdit uzivatele vymazani
write-host -ForegroundColor green "vse co je " -NoNewline
write-host -ForegroundColor white "bile " -NoNewline
write-host -ForegroundColor green "je zastarale a bude smazano" #-NoNewline
write-host -ForegroundColor green "a pouze " -NoNewline
write-host -ForegroundColor red "cervene " -NoNewline
write-host -ForegroundColor green "bude ponachano jako aktualni"

Read-Host -Prompt "zmackni klavesu ENTER pro potvrzeni . . ."
echo "mazu"
sleep 1

# fyzicke mazani souboru "zip"
$d_smazat_stare = $smazat_stare.Length

for ( $ee = 0; $ee -le $d_smazat_stare -1; $ee++ ){
$del = $smazat_stare[$ee]
echo $del

Remove-Item -Path $del
sleep -Milliseconds 200
}

echo  "hotovo"
sleep 20


