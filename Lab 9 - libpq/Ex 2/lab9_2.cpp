#include <iostream>
#include <sstream>
#include <string>
#include <pqxx/pqxx>
#include "lab9.h" 

using namespace std;
using namespace pqxx;

int main(int argc, char* argv[]) {

	stringstream ss;
	ss << "dbname = " << labdbname << " user = " << labdbuser << " password = " << labdbpass \
		<< " host = " << labdbhost << " port = " << labdbport; 
	string s = ss.str();

	try {
		connection connlab(s);
		if (connlab.is_open()) {
         
			work trsxn{connlab};
			
      		// Tablica char'ów, w której zapiszemy nasze zapytanie
			char task[300];

			if(argc == 1){
				// Jeśli użytkownik nie sprecyzuje żadnych ID kursów, to wypisuje wszystkich uczestników
				result res { trsxn.exec("SELECT DISTINCT imie, nazwisko, id_kurs FROM uczestnik JOIN uczest_kurs ON uczest_kurs.id_uczestnik = uczestnik.id_uczestnik;")};
				for (auto row: res)
				cout << row["id_kurs"].as<int>() << " " << row["imie"].c_str() << " " << row["nazwisko"].c_str() << std::endl;
			} else {
				// Jeśli użytkowanik sprecyzuje ID kursów, to najpierw wypisujemy warunek dla pierwszego kursu, a potem za pomocą pętli dołączamy kolejne warunki
				strcpy(task, "SELECT DISTINCT imie, nazwisko, id_kurs FROM uczestnik JOIN uczest_kurs ON uczest_kurs.id_uczestnik = uczestnik.id_uczestnik WHERE uczest_kurs.id_kurs = ");
				strcat(task, argv[1]);

          		// Za każdym podanym ID dodajemy warunek na kolejny kurs
				for (int i = 2; i < argc; i++) {
					char additionalOr[50];

					strcat(additionalOr, " OR uczest_kurs.id_kurs =");
					strcat(additionalOr, argv[i]);
					strcat(task, additionalOr);
				}

				result res { trsxn.exec(task)};
				for (auto row: res)
				cout << row["id_kurs"].as<int>() << " " << row["imie"].c_str() << " " << row["nazwisko"].c_str() << std::endl;
			}

		} else {
			cout << "Problem with connection " << endl;
			return 3;
		}
		connlab.disconnect ();
	} catch (pqxx::sql_error const &e) {
		cerr << "SQL error: " << e.what() << std::endl;
		cerr << "Polecenie SQL: " << e.query() << std::endl;
		return 2;
	} catch (const std::exception &e) {
		cerr << e.what() << std::endl;
		return 1;
	}
}

