#include <iostream>
#include <ctime> // time_t
#include <windows.h> // pro funkci delay();
#include <vector>
#include <string>
#include <sys/stat.h> // if (stat(path, &info) != 0) {
using namespace std;

// zaloha_adresaru - zalohovani zipovanim

string cesta_zdroj;
string cesta_cil = "C:\\Users\\DELL\\Documents\\zaloha\\ruzne\\"; // STEJNE
string argv_1, datum, prikaz, polozka_1, polozka_2, polozka_3;
char buffer [80];
int d_pole, aa, bb, n1, n2, n3=99999;

/* toto je priklad prikazu pro archivator "zip"
zip -r -9 "C:\Users\DELL\Documents\zaloha\ruzne\BaseCamp-backup.zip" 
 "C:\Users\DELL\Documents\BaseCamp" 
&& unzip -t "C:\Users\DELL\Documents\zaloha\ruzne\BaseCamp-backup.zip"
*/

// funkce test exist folder ?
bool existuje_adresar(const char* path) {
struct stat info;
if (stat(path, &info) != 0) {
return false;
}
return (info.st_mode & S_IFDIR) != 0;
}

int main(int argc, char** argv){

// test exist folder, cesta_cil ?
if (-not(existuje_adresar(cesta_cil.c_str()))) {
cerr<<"CHYBA: adresar "<<'"'<<cesta_cil<<'"'<<" NEexistuje"<<endl;
Sleep(3000); // milis.
return 1;
}
	
// definovani pole vsech adresaru urcenych k zalohovani
vector <string> pole = {
"C:\\Users\\DELL\\Documents\\BaseCamp",
"C:\\Users\\DELL\\Documents\\ps1",
"C:\\Users\\DELL\\Documents\\Lua52_Win32",
"C:\\Users\\DELL\\Documents\\QL_SAVE",
"C:\\Users\\DELL\\Documents\\ubuntu",
"C:\\Users\\DELL\\Documents\\Dos",
"C:\\Users\\DELL\\Desktop",
"C:\\ProgramData\\Microsoft\\Windows\\Start Menu", // parametr musi byt "Start Menu"
"C:\\Users\\DELL\\Documents\\Dev-Cpp",
"C:\\Users\\DELL\\Documents\\zaloha\\login",
"C:\\Users\\DELL\\Documents\\ubuntu\\navody",
"C:\\Users\\DELL\\Documents\\WindowsPowerShell",
"C:\\Users\\DELL\\Pictures\\screenshots",
"C:\\Users\\DELL\\Documents\\python",
"C:\\tools",
// Dosovy programy
"C:\\Users\\DELL\\Documents\\Dos\\PROG\\BC31",
"C:\\Users\\DELL\\Documents\\Dos\\PROG\\GW323",
"C:\\Users\\DELL\\Documents\\Dos\\PROG\\LUA535",
"C:\\Users\\DELL\\Documents\\Dos\\PROG\\QBASIC45",
"C:\\Users\\DELL\\Documents\\Dos\\PROG\\TC10",
"C:\\Users\\DELL\\Documents\\Dos\\PROG\\TP70",
"C:\\Users\\DELL\\Documents\\Dos\\UTILS",
"C:\\Users\\DELL\\Documents\\Dos\\PROG"
// zde pridavat dalsi radky (za posledni polozkou nedelat carku)
};

d_pole = pole.size() -1;
//cout<<d_pole<<endl;

// kontrola, zda uzivatel zadal argument (alespon jeden)
if (argc < 2) {
// napoveda	
cout<<"pouziti:"<<endl;
for ( aa = 0; aa <= d_pole; aa++){
polozka_1 = pole[aa];
n1 = polozka_1.find_last_of("\\"); // hleda posledni vyskyt v polozka_1
n1++;
cout<<"zaloha_adresaru "<<polozka_1.substr(n1, polozka_1.length() - n1)<<endl;
}
Sleep(10000); // milis.
return 1;
}

// hleda jestli parametr argv[1] odpovida necemu v poly
argv_1 = argv[1];
cout<<"argv[1]="<<'"'<<argv_1<<'"'<<endl;
//cout<<n3<<endl;

for ( bb = 0; bb <= d_pole; bb++){
polozka_2 = pole[bb];
n2 = polozka_2.find_last_of("\\"); // hleda posledni vyskyt
n2++;
polozka_3 = polozka_2.substr(n2, polozka_2.length() - n2);
//cout<<polozka_3<<endl;
if ( argv_1 == polozka_3){
n3 = bb;
break;	
}
}

//cout<<d_pole<<" "<<n3<<endl;
if ( n3 > d_pole){
cout<<"tento adrear nebyl nalezen"<<endl;
Sleep(3000); // milis.
return 1;
}

// test exist folder, cesta_zdroj ?
cesta_zdroj = pole[n3];
//cesta_zdroj = "C:\\sdfdfre"; // testovaci radek
if (-not(existuje_adresar(cesta_zdroj.c_str()))) {
cerr<<"CHYBA: adresar "<<'"'<<cesta_zdroj<<'"'<<" NEexistuje"<<endl;
Sleep(5000); // milis.
return 1;
}

// ziskani aktualniho datumu
time_t t = time(0); // get time now
struct tm * now = localtime(&t);
strftime(buffer,80,"%d_%m_%Y-%H_%M_%S-", now);
datum = buffer;

// slozeni prikazu pro zip a test unzip
prikaz += "zip -r -9 -S "; // rekurzivne a maximalni kompese
// -S include system and hidden files
prikaz += '"';
prikaz += cesta_cil; // ruzne (vzdy stejne)
prikaz += datum;
prikaz += polozka_3;
prikaz += ".zip";
prikaz += '"';
prikaz += " ";
prikaz += '"';
prikaz += cesta_zdroj;
prikaz += '"';
prikaz += " && "; // navratovy kod
prikaz += "unzip -t "; // rovnou i test vytvoreneho archivu
//prikaz += "pause && unzip -t "; // rovnou i test vytvoreneho archivu
prikaz += '"';
prikaz += cesta_cil;
prikaz += datum;
prikaz += polozka_3;
prikaz += ".zip";
prikaz += '"';
// pridano aby cekal v pauze pri chybne testu archivu
prikaz += " || ";
prikaz += "pause";

cout<<prikaz<<endl;
Sleep(5000); // milis.
system(prikaz.c_str()); // prevede string na const char*

Sleep(5000); // milis.
//system("pause");
return 0;
}
