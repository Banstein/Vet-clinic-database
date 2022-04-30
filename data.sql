/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, '1', 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, '1', 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-07-07', 1, '0', 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, '1', 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, '0', 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, '1', 5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, '1', 12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, '1', 45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, '1', 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, '1', 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, '1', 22);

INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

INSERT INTO species(name) VALUES ('pokemon');
INSERT INTO species(name) VALUES ('Digimon');

-- Update species_id column

BEGIN;
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'Digimon') WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name = 'pokemon') WHERE species_id IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Update owner_id column

BEGIN;
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2020-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

/*Insert date into specializations table */

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM species WHERE name='Pokemon'));

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Digimon'));

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Pokemon'));

INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM species WHERE name='Digimon'));


/*Insert date to visits table */
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM animals WHERE name='Agumon'),'2020-05-24');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM animals WHERE name='Agumon'),'2020-07-22');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM animals WHERE name='Gabumon'),'2021-02-02');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Pikachu'),'2020-01-05');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Pikachu'),'2020-03-08');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Pikachu'),'2020-05-14');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM animals WHERE name='Devimon'),'2021-05-04');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM animals WHERE name='Charmander'),'2021-02-24');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Plantmon'),'2019-12-21');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM animals WHERE name='Plantmon'),'2020-08-10');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Plantmon'),'2021-04-07');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM animals WHERE name='Squirtle'),'2019-09-29');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM animals WHERE name='Angemon'),'2020-10-03');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM animals WHERE name='Angemon'),'2020-11-04');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Boarmon'),'2019-01-24');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Boarmon'),'2019-05-15');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Boarmon'),'2020-02-27');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Maisy Smith'), (SELECT id FROM animals WHERE name='Boarmon'), '2020-08-03');	

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM animals WHERE name='Blossom'),'2020-05-24');

INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM animals WHERE name='Blossom'),'2021-01-11');