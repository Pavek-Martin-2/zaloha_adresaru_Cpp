cls
<# na tohle jsem se dlouho chystal, vzdycky kdyz jsem to delal rucne tak se mi stalo
ze jsem omylem vymazal neco co jsem nemel, takze tohle vyrazne usnadnuje praci
z mazanim starych neaktualnich zaloh archivu "zip" v adresari $cesta
a cisti to misto na disku od vseho jiz nepotrebneho
a je to jako doplnek k mojim predchozim zalohovacim skriptum jak v C-cku tak v PS #>

$cesta = "C:\Users\DELL\Documents\zaloha\ruzne"
Write-Host -ForegroundColor cyan "bude vycistena slozka"
Write-Host -ForegroundColor cyan "$cesta\*.zip"
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

for ( $aa = 0; $aa -le $d_sulfix -1; $aa++ ){
$polozka_sulfix = $sulfix[$aa]
$pole_stejny_druh_zipu = @() # pole se vzdy nuluje, pri kazdem pruchodu cyklem

for ( $bb = 0; $bb -le $d_pole -1; $bb++ ){                  
$file = $pole[$bb]

$d_file = $file.Length # sulfix souboru zip ( napr. "-ps1.zip" apod. )
$nazev = $file.Substring(19, $d_file - 19)

# shoda
if ( $polozka_sulfix -like $nazev ){
$pole_stejny_druh_zipu += $file # pridava do pole stene druhy zip
}

} # for bb

# stejne soubory zip (stejneho druhu zalohy)
$d_pole_stejny_druh_zipu = $pole_stejny_druh_zipu.Length

if ( $d_pole_stejny_druh_zipu -gt 1 ) { # pole musi mit vice nez jednu polozku *.zip

########################################################################################################
$index_pole_nejnovejsi = $d_pole_stejny_druh_zipu -1 # nejnovejsi "zip" je vzdy na poslednim indexu pole
# uz to sam rovna podle abecedy (viz. screenshoty)
#echo $index_pole_nejnovejsi
#$index_pole_nejnovejsi = 1 # nejnovejsi je na poslednim indexu
#write-host -ForegroundColor Yellow $pole_stejny_druh_zipu
########################################################################################################

$filename_nemazat = $pole_stejny_druh_zipu[$index_pole_nejnovejsi]
write-host -ForegroundColor red $filename_nemazat

# mazani stareho neaktualniho a ponechani pouze jednoho nejnovejsiho "zipu"
for ( $dd = 0; $dd -le $d_pole_stejny_druh_zipu -1; $dd++ ){
$polozka_pole_stejny_druh_zipu_2 = $pole_stejny_druh_zipu[$dd]

if ( $polozka_pole_stejny_druh_zipu_2 -notlike $filename_nemazat){
$smazat_soubor = $polozka_pole_stejny_druh_zipu_2
write-host -ForegroundColor white $smazat_soubor

# pridani polozky do pole smazat_stare
$vloz_smazat_stare = $cesta
$vloz_smazat_stare += "\"
$vloz_smazat_stare += $smazat_soubor
$smazat_stare += $vloz_smazat_stare

# prazne pole smazat stare
if ($smazat_stare.Length -eq 0 ){
write-host -ForegroundColor Yellow "neni co cistit"
sleep 5
exit 1
}

} # if ( $polozka_pole_stejny_druh_zipu_2

} # for dd
echo ""
} # konec if ($d_pole_stejny_druh_zipu -gt 1

# echo "---------------" # tady je vydet krery soubory vynechal (jsou pouze 1x)
} # for aa

$d_smazat_stare = $smazat_stare.Length

# prazne pole smazat stare
if ($d_smazat_stare -eq 0 ){
write-host -ForegroundColor Yellow "vse je uz vycisteno"
sleep 5
exit 1
}

# udelat pole smazej soubory a nechat potvrdit uzivatele vymazani
write-host -ForegroundColor green "vse co je " -NoNewline
write-host -ForegroundColor white "bile " -NoNewline
write-host -ForegroundColor green "je zastarale a bude smazano" #-NoNewline
write-host -ForegroundColor green "a pouze " -NoNewline
write-host -ForegroundColor red "cervene " -NoNewline
write-host -ForegroundColor green "bude ponachano jako aktualni"

Read-Host -Prompt "zmackni klavesu ENTER pro potvrzeni . . ."
# v pripade chyby zavrit okno v pravo nahore krizkem

# fyzicke mazani souboru "zip"
for ( $ee = 0; $ee -le $d_smazat_stare -1; $ee++ ){
$del = $smazat_stare[$ee]
echo $del

Remove-Item -Path $del # tento radek maze
sleep -Milliseconds 200
}

echo "hotovo"
sleep 20

