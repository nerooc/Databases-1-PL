#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <libpq-fe.h>
#include "lab9pq.h"

void doSQL(PGconn *conn, char *command){
  PGresult *result;
  printf("------------------------------\n");
  printf("%s\n", command);
  result = PQexec(conn, command);
  printf("status is : %s\n", PQresStatus(PQresultStatus(result)));
  printf("#rows affected: %s\n", PQcmdTuples(result));
  printf("result message: %s\n", PQresultErrorMessage(result));
  switch(PQresultStatus(result)) {
    case PGRES_TUPLES_OK:{
      int n = 0, r = 0;
      int nrows   = PQntuples(result);
      int nfields = PQnfields(result);
      printf("number of rows returned = %d\n", nrows);
      printf("number of fields returned = %d\n", nfields);
      for(r = 0; r < nrows; r++) {
        for(n = 0; n < nfields; n++)
           printf("%s = %s", PQfname(result, n),PQgetvalue(result,r,n));
        printf("\n");
      }
    }/*end case*/
  }/* end switch */
  PQclear(result);
} 

int main(int argc, char *argv[])
{
  PGconn *conn;
  char connection_str[256];

	strcpy(connection_str, "host=");
	strcat(connection_str, dbhost);
	strcat(connection_str, " port=");
	strcat(connection_str, dbport);
	strcat(connection_str, " dbname=");
	strcat(connection_str, dbname);
	strcat(connection_str, " user=");
	strcat(connection_str, dbuser);
	strcat(connection_str, " password=");
	strcat(connection_str, dbpassword);

  conn = PQconnectdb(connection_str);
  if (PQstatus(conn) == CONNECTION_BAD) {
     fprintf(stderr, "Connection to %s failed, %s",connection_str,PQerrorMessage(conn));
  } else {
      // Potwierdzenie połączenia
      printf("Connection working \n");

      // Tablica char'ów, w której zapiszemy nasze zapytanie
      char task[300];

      // Jeśli użytkownik nie sprecyzuje żadnych ID kursów, to wypisuje wszystkich uczestników
      if(argc == 1){
        strcpy(task, "SELECT DISTINCT imie, nazwisko, id_kurs FROM uczestnik JOIN uczest_kurs ON uczest_kurs.id_uczestnik = uczestnik.id_uczestnik;");
      } else {
      // Jeśli użytkowanik sprecyzuje ID kursów, to najpierw wypisujemy warunek dla pierwszego kursu, a potem za pomocą pętli dołączamy kolejne warunki
          strcpy(task, "SELECT DISTINCT imie, nazwisko, id_kurs FROM uczestnik JOIN uczest_kurs ON uczest_kurs.id_uczestnik = uczestnik.id_uczestnik WHERE uczest_kurs.id_kurs = ");
          strcat(task, argv[1]);

          // Za każdym podanym ID dodajemy warunek na kolejny kurs
          for (int i = 2; i < argc; i++) {
            char or[50];
            sprintf(or, " OR uczest_kurs.id_kurs = %s", argv[i]);
            strcat(task, or);
          }
      }

      // Wykonujemy zapytanie
      doSQL(conn, task);
  }

  PQfinish(conn);
  return EXIT_SUCCESS;
}
