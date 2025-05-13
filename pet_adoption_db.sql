-- Drop tables if re-running
DROP TABLE IF EXISTS CareRecords, Adoptions, Applications, Pets, Breeds, Adopters, Veterinarians;

-- Adopters table
CREATE TABLE Adopters (
    adopter_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    registered_date DATE NOT NULL
);

-- Veterinarians table
CREATE TABLE Veterinarians (
    vet_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    contact_number VARCHAR(15)
);

-- Breeds table
CREATE TABLE Breeds (
    breed_id INT PRIMARY KEY AUTO_INCREMENT,
    species VARCHAR(50) NOT NULL,
    breed_name VARCHAR(100) NOT NULL
);

-- Pets table
CREATE TABLE Pets (
    pet_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    species VARCHAR(50) NOT NULL,
    breed_id INT,
    age INT,
    gender ENUM('Male', 'Female'),
    intake_date DATE NOT NULL,
    adoption_status ENUM('Available', 'Adopted', 'Pending') DEFAULT 'Available',
    FOREIGN KEY (breed_id) REFERENCES Breeds(breed_id)
);

-- Adoption Applications table
CREATE TABLE Applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    adopter_id INT,
    pet_id INT,
    application_date DATE,
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (adopter_id) REFERENCES Adopters(adopter_id),
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id)
);

-- Adoptions table
CREATE TABLE Adoptions (
    adoption_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_id INT UNIQUE,
    adopter_id INT,
    adoption_date DATE NOT NULL,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
    FOREIGN KEY (adopter_id) REFERENCES Adopters(adopter_id)
);

-- Care Records (vet visits, treatments, etc.)
CREATE TABLE CareRecords (
    record_id INT PRIMARY KEY AUTO_INCREMENT,
    pet_id INT,
    vet_id INT,
    visit_date DATE,
    notes TEXT,
    FOREIGN KEY (pet_id) REFERENCES Pets(pet_id),
    FOREIGN KEY (vet_id) REFERENCES Veterinarians(vet_id)
);
