/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name from animals WHERE neutered = 'y' AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg < 10.5;
SELECT * from animals WHERE neutered = 'y';
SELECT * from animals WHERE name NOT LIKE 'Gabumon';
SELECT * from animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- 1

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

-- 2

BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT * from animals;

-- 3

BEGIN;
DELETE FROM animals;

-- 4

ROLLBACK;
SELECT * from animals;
COMMIT;

-- 5

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-1-1';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK to sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT MAX(escape_attempts), neutered FROM animals GROUP BY neutered;
SELECT MAX(weight_kg), MIN(weight_kg), species FROM animals GROUP BY species;
SELECT AVG(escape_attempts), species FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2020-01-01' GROUP BY species;

SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */
SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'pokemon';

/* List all owners and their animals */
SELECT owners.full_name, animals.name  FROM owners  LEFT OUTER JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species? */
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY (species.name);

/* List all Digimon owned by Jennifer Orwell. */
SELECT animals.name FROM animals 
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Digimon'
AND owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */
SELECT animals.name FROM animals 
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND escape_attempts = 0;

/* Who owns the most animals? */
SELECT owners.full_name, COUNT(*) FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY (owners.full_name)
ORDER BY count DESC 
LIMIT 1;

/* Who was the last animal seen by William Tatcher */
SELECT animals.name FROM animals 
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/* How many different animals did Stephanie Mendez see */
SELECT COUNT (animals.name) FROM animals 
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties */
SELECT  vets.name, species.name  FROM species 
JOIN specializations ON species.id = specializations.species_id
RIGHT JOIN vets ON vets.id = specializations.vet_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */
SELECT animals.name, visits.date_of_visit FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30'

/* What animal has the most visits to vets */
SELECT animals.name, COUNT(*) FROM visits 
JOIN animals ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY count DESC
LIMIT 1;

/* Who was Maisy Smith's first visit */
SELECT animals.name FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT animals.name, vets.name, visits.date_of_visit FROM animals 
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id 
ORDER BY visits.date_of_visit DESC
LIMIT 1;

/*How many visits were with a vet that did not specialize in that animal's species */
SELECT COUNT(*) FROM species  
JOIN specializations ON species.id = specializations.species_id
RIGHT JOIN vets ON vets.id = specializations.vet_id
JOIN visits ON visits.vet_id = vets.id
WHERE species.name IS NULL;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
SELECT species.name FROM vets 
JOIN visits ON visits.vet_id = vets.id
JOIN animals ON animals.id = visits.animal_id
JOIN species ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY (species.name)
ORDER BY COUNT (species.name) DESC
Limit 1;