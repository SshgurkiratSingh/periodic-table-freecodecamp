PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else 
# check if input exist 
CHECK=$($PSQL "select atomic_number,symbol,name,type,atomic_mass,boiling_point_celsius,melting_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where name='$1' or symbol='$1'")
if [[ -z $CHECK ]]
then 
CHECK=$($PSQL "select atomic_number,symbol,name,type,atomic_mass,boiling_point_celsius,melting_point_celsius from elements inner join properties using(atomic_number) inner join types using(type_id) where atomic_number=$1")
fi
if [[ -z $CHECK ]]
then
echo "I could not find that element in the database."
else 
echo $CHECK | while IFS="|" read NUMBER SYMBOL NAME TYPE MASS BOIL_POINT MELT_POINT
do
echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
done
fi

fi
