/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD species VARCHAR(250);

-- Create a table named owners

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(250),
    age INT,
    PRIMARY KEY(id)
);

-- Create a table named species

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    age INT,
    PRIMARY KEY(id)
);

-- Modify animals table / delete species

ALTER TABLE animals
DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id);

ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners (id);

CREATE TABLE vets (
id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
name VARCHAR(400) NOT NULL,
age INT,
date_of_graduation DATE,
PRIMARY KEY (id)
);

/* create specializations table */
CREATE TABLE specializations (
vet_id INT, 
species_id INT,
FOREIGN KEY (species_id) REFERENCES species (id),
FOREIGN KEY (vet_id) REFERENCES vets (id) 
);

/* create visits table */
CREATE TABLE visits (
animal_id INT NOT NULL,
vet_id INT NOT NULL,
date_of_visit DATE,
FOREIGN KEY (animal_id) REFERENCES animals (id),
FOREIGN KEY (vet_id) REFERENCES vets (id) 
);