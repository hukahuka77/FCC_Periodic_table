#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only -c"


if [[ -z $1 ]]
  then
  echo Please provide an element as an argument.
fi

if [[ $1 =~ ^[0-9]+ ]]
  then
  DB_NAME=$($PSQL "SELECT p.atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type from properties as p inner join elements as e USING(atomic_number) inner join types USING(type_id) WHERE name='$1' or symbol='$1' or atomic_number=$1")
  if [[ -z $DB_NAME ]]
  then
    echo I could not find that element in the database.
  else
    echo $DB_NAME | while IFS=" |" read ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL NAME TYPE
    do
      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi

if [[ $1 =~ ^[A-Za-z]+ ]]
  then
  DB_NAME=$($PSQL "SELECT p.atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type from properties as p inner join elements as e USING(atomic_number) inner join types USING(type_id) WHERE name='$1' or symbol='$1'")
  if [[ -z $DB_NAME ]]
  then
    echo I could not find that element in the database.
  else
    echo $DB_NAME | while IFS=" |" read ATOMIC_NUMBER ATOMIC_MASS MELTING_POINT BOILING_POINT SYMBOL NAME TYPE
    do
      echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi
