CREATE TABLE Doctor_Speciality (
    Specialty_id VARCHAR(10) PRIMARY KEY,
    Specialty_name VARCHAR(100)
    
);

CREATE TABLE Doctor (
    Doctor_id  bigint unsigned PRIMARY KEY,
    First_name varchar(30) NOT NULL,
    Last_name  varchar(30) NOT NULL,
    Gender     varchar(10) NOT NULL,
    contact    varchar(20) NOT NULL,
    Password   varchar(255) ,
    Doctor_Charge int unsigned NOT NULL, 
    Specialty_id VARCHAR(10),
    FOREIGN KEY (Specialty_id) REFERENCES Doctor_Speciality(Specialty_id) 
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
alter table Doctor_Speciality 
	add constraint fk_speciality  foreign key (Doctor_id) references Doctor(Doctor_id)   on delete cascade on update cascade;
   

CREATE TABLE Ward (
    Ward_id bigint unsigned PRIMARY KEY,
    Ward_type varchar(30),
    ward_charge int unsigned
);


CREATE TABLE Attende (
    Attende_id varchar(30) primary key,
    First_name varchar(20),
    Last_name varchar(20),
    Contact varchar(20)
);

CREATE TABLE Patient (
    Patient_id  bigint unsigned PRIMARY KEY,
    First_name  varchar(30) NOT NULL,
    Last_name   varchar(30) NOT NULL,
    Gender      varchar(10) NOT NULL,
    Age         TINYINT unsigned NOT NULL,
    contact     varchar(20) NOT NULL, 
    Street      varchar(20),
    State       varchar(15) NOT NULL,
    City        varchar(20) NOT NULL,
    Postal_code VARCHAR(16) NOT NULL,
    Doctor_id   bigint unsigned,
    Ward_id     bigint unsigned,
    Attende_id  varchar(30),
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (Ward_id) REFERENCES Ward(Ward_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (Attende_id) REFERENCES Attende(Attende_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE Admission (
    Admit_id varchar(30) PRIMARY KEY,
    Admit_date date,
    Patient_id bigint unsigned,
    Discharge_date date,
    Doctor_id bigint unsigned,
    Ward_id bigint unsigned,
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
    ON DELETE SET NULL
	ON UPDATE CASCADE ,
    FOREIGN KEY (Ward_id) REFERENCES Ward(Ward_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE Disease (
    Disease_id varchar(20) PRIMARY KEY,
    Disease_name varchar(30),
    Patient_id bigint unsigned,
    Dieases_reason varchar(50),
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
    ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE Medecine (
    Medicine_id varchar(30) primary key,
    Drug_name varchar(50),
    Drug_company varchar(30),
    Dosage varchar(20),
    Med_description varchar(40),
    cost int
);

CREATE TABLE Medication (
    Medication_id bigint unsigned PRIMARY KEY,
    Medicine_id  varchar(30) ,
    Prescription varchar(255),
    Disease_id  varchar(30),
    Patient_id bigint unsigned,
    Doctor_id bigint unsigned,
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
	FOREIGN KEY ( Disease_id) REFERENCES  Disease( Disease_id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
		ON DELETE SET NULL
		ON UPDATE CASCADE,
    FOREIGN KEY (Medicine_id) REFERENCES Medecine(Medicine_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE Mediclaim (
    Claim_id varchar(20) primary key,
    Claim_date date,
    Claim_amount int unsigned,
    Claim_status varchar(30),
    Company_name varchar(50),
    Claim_type varchar(50),
    Patient_id bigint unsigned,
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
    ON DELETE SET NULL
	ON UPDATE CASCADE
);

CREATE TABLE Bill (
    Bill_id int unsigned PRIMARY KEY,
    Patient_id bigint unsigned,
    Doctor_id bigint unsigned,
    Medical_id varchar(20),
    Total_amount int unsigned,
    Admit_id varchar(30),
    FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (Doctor_id) REFERENCES Doctor(Doctor_id)
    ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (Medical_id) REFERENCES Mediclaim(Claim_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (Admit_id) REFERENCES Admission(Admit_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


CREATE TABLE Payment (
    Payment_id bigint unsigned primary key,
    Bill_id int unsigned,
    Transaction_id bigint unsigned,
    Paid_amount int unsigned,
    Mode_of_payment varchar(20),
    FOREIGN KEY (Bill_id) REFERENCES Bill(Bill_id)
        ON DELETE CASCADE
        on update cascade
   
);

CREATE TABLE Payment_transaction (
    Transaction_id bigint unsigned primary key,
    Transaction_time time,
    Transaction_date date,
    Payment_id bigint unsigned,
    FOREIGN KEY (Payment_id) REFERENCES Payment(Payment_id)
    ON DELETE SET NULL
        ON UPDATE CASCADE
);

INSERT INTO Doctor_Speciality (Specialty_id, Specialty_name) VALUES
    ('SP001', 'Cardiology'),
    ('SP002', 'Neurology'),
    ('SP003', 'Orthopedics'),
    ('SP004', 'Dermatology'),
    ('SP005', 'Ophthalmology'),
    ('SP006', 'Gastroenterology'),
    ('SP007', 'Endocrinology'),
    ('SP008', 'Pediatrics'),
    ('SP009', 'Oncology'),
    ('SP010', 'Psychiatry'),
    ('SP011', 'Radiology'),
    ('SP012', 'Urology'),
    ('SP013', 'Nephrology'),
    ('SP014', 'Pulmonology'),
    ('SP015', 'Obstetrics'),
    ('SP016', 'Gynecology'),
    ('SP017', 'Anesthesiology'),
    ('SP018', 'Rheumatology'),
    ('SP019', 'Dentistry'),
    ('SP020', 'Emergency Medicine');
    
    
INSERT INTO Doctor (Doctor_id, First_name, Last_name, Gender, contact, Doctor_Charge, Specialty_id) VALUES
    (1001, 'John', 'Smith', 'Male', '1234567890', 200, 'SP001'),
    (1002, 'Jane', 'Doe', 'Female', '9876543210', 250, 'SP002'),
    (1003, 'Michael', 'Johnson', 'Male', '5551234567', 180, 'SP003'),
    (1004, 'Emily', 'Brown', 'Female', '5555678901', 220, 'SP004'),
    (1005, 'Robert', 'Williams', 'Male', '4445556677', 230, 'SP005'),
    (1006, 'Amanda', 'Davis', 'Female', '2223334444', 210, 'SP006'),
    (1007, 'Christopher', 'Martinez', 'Male', '6667778888', 240, 'SP007'),
    (1008, 'Jessica', 'Taylor', 'Female', '9998887777', 260, 'SP008'),
    (1009, 'David', 'Anderson', 'Male', '1112223333', 190, 'SP009'),
    (1010, 'Melissa', 'Wilson', 'Female', '7776665555', 200, 'SP010'),
    (1011, 'William', 'White', 'Male', '5554443333', 270, 'SP011'),
    (1012, 'Elizabeth', 'Jackson', 'Female', '4443332222', 280, 'SP012'),
    (1013, 'Joshua', 'Lee', 'Male', '2221110000', 210, 'SP013'),
    (1014, 'Sarah', 'Harris', 'Female', '8889991111', 220, 'SP014'),
    (1015, 'Daniel', 'Thompson', 'Male', '7778889999', 230, 'SP015'),
    (1016, 'Olivia', 'Moore', 'Female', '4445556666', 250, 'SP016'),
    (1017, 'James', 'Hall', 'Male', '1112223333', 240, 'SP017'),
    (1018, 'Sophia', 'King', 'Female', '6665554444', 260, 'SP018'),
    (1019, 'Benjamin', 'Nelson', 'Male', '5554443333', 270, 'SP019'),
    (1020, 'Isabella', 'Johnson', 'Female', '4443332222', 280, 'SP020');

INSERT INTO Ward (Ward_id, Ward_type, ward_charge) VALUES
    (2001, 'Rehabilitation', 280),
    (2002, 'Hospice', 200),
    (2003, 'General', 100),
    (2004, 'Private', 300),
    (2005, 'Semi-Private', 200),
    (2006, 'ICU', 500),
    (2007, 'Pediatrics', 150),
    (2008, 'Maternity', 250),
    (2009, 'Isolation', 400),
    (2010, 'Neonatal', 350),
    (2011, 'Orthopedic', 180),
    (2012, 'Psychiatric', 280),
    (2013, 'Cardiac', 400),
    (2014, 'Oncology', 320),
    (2015, 'Burn Unit', 450),
    (2016, 'Geriatric', 220),
    (2017, 'Neurology', 380),
    (2018, 'Emergency', 600),
    (2019, 'Surgery', 400),
    (2020, 'Transplant', 550);
    
    
INSERT INTO Attende (Attende_id, First_name, Last_name, Contact) VALUES
    ('AT001', 'Michael', 'Johnson', '555-1234'),
    ('AT002', 'Emily', 'Brown', '555-5678'),
    ('AT003', 'David', 'Smith', '555-9876'),
    ('AT004', 'Sarah', 'Wilson', '555-4321'),
    ('AT005', 'James', 'Miller', '555-6789'),
    ('AT006', 'Olivia', 'Taylor', '555-2345'),
    ('AT007', 'Daniel', 'Martinez', '555-8765'),
    ('AT008', 'Sophia', 'Anderson', '555-3456'),
    ('AT009', 'William', 'Clark', '555-6543'),
    ('AT010', 'Isabella', 'Lee', '555-2109'),
    ('AT011', 'Benjamin', 'Garcia', '555-1092'),
    ('AT012', 'Emma', 'Thomas', '555-9081'),
    ('AT013', 'Alexander', 'Hernandez', '555-6543'),
    ('AT014', 'Ava', 'Lopez', '555-4321'),
    ('AT015', 'Noah', 'Perez', '555-7890'),
    ('AT016', 'Mia', 'Davis', '555-8901'),
    ('AT017', 'Liam', 'Brown', '555-4567'),
    ('AT018', 'Sofia', 'Rodriguez', '555-9876'),
    ('AT019', 'Jackson', 'Gonzalez', '555-2345'),
    ('AT020', 'Amelia', 'Rivera', '555-6789');
    
    
INSERT INTO Patient (Patient_id, First_name, Last_name, Gender, Age, contact, Street, State, City, Postal_code, Doctor_id, Ward_id, Attende_id) VALUES
    (3003, 'Michael', 'Smith', 'Male', 35, '7778889999', '789 Oak St', 'TX', 'Houston', '77001', 1003, 2003, 'AT003'),
    (3004, 'Emily', 'Davis', 'Female', 45, '5554443333', '456 Maple St', 'CA', 'San Francisco', '94101', 1004, 2004, 'AT004'),
    (3005, 'James', 'Wilson', 'Male', 60, '3332221111', '890 Pine St', 'FL', 'Miami', '33101', 1005, 2005, 'AT005'),
    (3006, 'Olivia', 'Jones', 'Female', 22, '9998887777', '567 Birch St', 'TX', 'Dallas', '75201', 1006, 2006, 'AT006'),
    (3007, 'Daniel', 'Anderson', 'Male', 28, '4445556666', '678 Cedar St', 'NY', 'Albany', '12201', 1007, 2007, 'AT007'),
    (3008, 'Sophia', 'Brown', 'Female', 50, '8889991111', '234 Elm St', 'CA', 'San Diego', '92101', 1008, 2008, 'AT008'),
    (3009, 'William', 'Taylor', 'Male', 65, '1112223333', '345 Oak St', 'FL', 'Tampa', '33601', 1009, 2009, 'AT009'),
    (3010, 'Isabella', 'Miller', 'Female', 32, '6665554444', '123 Maple St', 'TX', 'Austin', '78701', 1010, 2010, 'AT010'),
    (3011, 'Benjamin', 'Martinez', 'Male', 38, '5556667777', '456 Pine St', 'NY', 'Rochester', '14601', 1011, 2011, 'AT011'),
    (3012, 'Emma', 'Johnson', 'Female', 18, '4443332222', '789 Birch St', 'CA', 'Fresno', '93701', 1012, 2012, 'AT012'),
    (3013, 'Ava', 'Davis', 'Female', 29, '1110009999', '234 Cedar St', 'TX', 'Houston', '77001', 1013, 2013, 'AT013'),
    (3014, 'Noah', 'Smith', 'Male', 40, '7778889999', '567 Oak St', 'NY', 'Buffalo', '14201', 1014, 2014, 'AT014'),
    (3015, 'Mia', 'Wilson', 'Female', 55, '4445556666', '678 Maple St', 'FL', 'Orlando', '32801', 1015, 2015, 'AT015'),
    (3016, 'Liam', 'Anderson', 'Male', 27, '8889991111', '123 Pine St', 'CA', 'Los Angeles', '90001', 1016, 2016, 'AT016'),
    (3017, 'Sofia', 'Brown', 'Female', 70, '5556667777', '456 Cedar St', 'TX', 'Dallas', '75201', 1017, 2017, 'AT017'),
    (3018, 'Jackson', 'Taylor', 'Male', 31, '6665554444', '789 Elm St', 'NY', 'New York', '10001', 1018, 2018, 'AT018'),
    (3019, 'Amelia', 'Miller', 'Female', 42, '4443332222', '234 Oak St', 'FL', 'Miami', '33101', 1019, 2019, 'AT019'),
    (3020, 'Lucas', 'Johnson', 'Male', 20, '1110009999', '567 Maple St', 'CA', 'San Francisco', '94101', 1020, 2020, 'AT020');
 insert into Patient values(1021 ,  'Harsh' , 'Yadav' , 'Male' ,20, 9669841861 , 'Indore' , 'MP' ,'Indore' , '3445' ,1001, 2003, 'AT003');

 
 INSERT INTO Admission (Admit_id, Admit_date, Patient_id, Discharge_date, Doctor_id, Ward_id) VALUES
   
    ('ADM003', '2023-08-02', 3003, '2023-08-08', 1003, 2003),
    ('ADM004', '2023-08-05', 3004, '2023-08-15', 1004, 2004),
    ('ADM005', '2023-08-07', 3005, '2023-08-18', 1005, 2005),
    ('ADM006', '2023-08-09', 3006, '2023-08-20', 1006, 2006),
    ('ADM007', '2023-08-10', 3007, '2023-08-22', 1007, 2007),
    ('ADM008', '2023-08-11', 3008, '2023-08-25', 1008, 2008),
    ('ADM009', '2023-08-14', 3009, '2023-08-30', 1009, 2009),
    ('ADM010', '2023-08-16', 3010, '2023-09-02', 1010, 2010),
    ('ADM011', '2023-08-18', 3011, '2023-09-05', 1011, 2011),
    ('ADM012', '2023-08-20', 3012, '2023-09-10', 1012, 2012),
    ('ADM013', '2023-08-22', 3013, '2023-09-12', 1013, 2013),
    ('ADM014', '2023-08-24', 3014, '2023-09-15', 1014, 2014),
    ('ADM015', '2023-08-26', 3015, '2023-09-18', 1015, 2015),
    ('ADM016', '2023-08-28', 3016, '2023-09-20', 1016, 2016),
    ('ADM017', '2023-08-30', 3017, '2023-09-22', 1017, 2017),
    ('ADM018', '2023-09-01', 3018, '2023-09-25', 1018, 2018),
    ('ADM019', '2023-09-03', 3019, '2023-09-28', 1019, 2019),
    ('ADM020', '2023-09-05', 3020, '2023-09-30', 1020, 2020);
    
    
INSERT INTO Disease (Disease_id, Disease_name, Patient_id, Dieases_reason) VALUES
   
    ('D003', 'Diabetes', 3003, 'High blood sugar levels'),
    ('D004', 'Asthma', 3004, 'Difficulty breathing'),
    ('D005', 'Arthritis', 3005, 'Joint inflammation'),
    ('D006', 'Depression', 3006, 'Persistent low mood'),
    ('D007', 'Cancer', 3007, 'Uncontrolled cell growth'),
    ('D008', 'Pneumonia', 3008, 'Lung infection'),
    ('D009', 'Anemia', 3009, 'Low red blood cells'),
    ('D010', 'Bronchitis', 3010, 'Inflamed airways'),
    ('D011', 'Epilepsy', 3011, 'Seizures'),
    ('D012', 'Gastroenteritis', 3012, 'Stomach and intestine inflammation'),
    ('D013', 'Insomnia', 3013, 'Difficulty sleeping'),
    ('D014', 'Kidney Stones', 3014, 'Hard deposits in the kidneys'),
    ('D015', 'Osteoporosis', 3015, 'Weakened bones'),
    ('D016', 'Rheumatoid Arthritis', 3016, 'Autoimmune joint disorder'),
    ('D017', 'Stroke', 3017, 'Blood supply to the brain is disrupted'),
    ('D018', 'Tuberculosis', 3018, 'Bacterial lung infection'),
    ('D019', 'Ulcerative Colitis', 3019, 'Inflammatory bowel disease'),
    ('D020', 'Varicella', 3020, 'Chickenpox virus infection');


INSERT INTO Medecine (Medicine_id, Drug_name, Drug_company, Dosage, Med_description, cost) VALUES
    ('MED001', 'Aspirin', 'PharmaCorp', '100 mg', 'Pain reliever', 5),
    ('MED002', 'Lisinopril', 'HealthMeds', '10 mg', 'Blood pressure medication', 10),
    ('MED003', 'Ibuprofen', 'MediCare', '200 mg', 'Anti-inflammatory', 6),
    ('MED004', 'Metformin', 'PharmaCorp', '500 mg', 'Diabetes medication', 8),
    ('MED005', 'Albuterol', 'HealthMeds', '2 mg', 'Bronchodilator', 15),
    ('MED006', 'Sertraline', 'MediCare', '50 mg', 'Antidepressant', 12),
    ('MED007', 'Tamoxifen', 'PharmaCorp', '20 mg', 'Breast cancer treatment', 20),
    ('MED008', 'Amoxicillin', 'HealthMeds', '500 mg', 'Antibiotic', 7),
    ('MED009', 'Iron Supplement', 'MediCare', '325 mg', 'Anemia treatment', 9),
    ('MED010', 'Prednisone', 'PharmaCorp', '5 mg', 'Anti-inflammatory', 8),
    ('MED011', 'Levothyroxine', 'HealthMeds', '100 mcg', 'Thyroid hormone replacement', 10),
    ('MED012', 'Loratadine', 'MediCare', '10 mg', 'Antihistamine', 6),
    ('MED013', 'Acetaminophen', 'PharmaCorp', '500 mg', 'Pain reliever', 4),
    ('MED014', 'Simvastatin', 'HealthMeds', '20 mg', 'Cholesterol medication', 12),
    ('MED015', 'Ciprofloxacin', 'MediCare', '500 mg', 'Antibiotic', 15),
    ('MED016', 'Omeprazole', 'PharmaCorp', '20 mg', 'Acid reflux medication', 9),
    ('MED017', 'Losartan', 'HealthMeds', '50 mg', 'Blood pressure medication', 11),
    ('MED018', 'Warfarin', 'MediCare', '5 mg', 'Blood thinner', 10),
    ('MED019', 'Folic Acid', 'PharmaCorp', '400 mcg', 'Vitamin supplement', 5),
    ('MED020', 'Atorvastatin', 'HealthMeds', '40 mg', 'Cholesterol medication', 14);
    
    
    INSERT INTO Medication (Medication_id, Medicine_id, Prescription, Disease_id, Patient_id, Doctor_id) VALUES
 
    (5003, 'MED003', 'Take 2 tablets as needed for pain', 'D003', 3003, 1003),
    (5004, 'MED004', 'Take 1 tablet twice a day with meals', 'D004', 3004, 1004),
    (5005, 'MED005', 'Use inhaler as needed for breathing', 'D005', 3005, 1005),
    (5006, 'MED006', 'Take 1 tablet daily in the evening', 'D006', 3006, 1006),
    (5007, 'MED007', 'Take 1 tablet daily with food', 'D007', 3007, 1007),
    (5008, 'MED008', 'Take 1 capsule three times a day', 'D008', 3008, 1008),
    (5009, 'MED009', 'Take 1 tablet daily with orange juice', 'D009', 3009, 1009),
    (5010, 'MED010', 'Take 2 tablets in the morning for 5 days', 'D010', 3010, 1010),
    (5011, 'MED011', 'Take 1 tablet daily on an empty stomach', 'D011', 3011, 1011),
    (5012, 'MED012', 'Take 1 tablet as needed for allergies', 'D012', 3012, 1012),
    (5013, 'MED013', 'Take 2 tablets every 4-6 hours for pain', 'D013', 3013, 1013),
    (5014, 'MED014', 'Take 1 tablet daily at bedtime', 'D014', 3014, 1014),
    (5015, 'MED015', 'Take 1 tablet twice a day for 7 days', 'D015', 3015, 1015),
    (5016, 'MED016', 'Take 1 capsule 30 minutes before breakfast', 'D016', 3016, 1016),
    (5017, 'MED017', 'Take 1 tablet daily in the morning', 'D017', 3017, 1017),
    (5018, 'MED018', 'Take 1 tablet daily with dinner', 'D018', 3018, 1018),
    (5019, 'MED019', 'Take 1 tablet daily with a meal', 'D019', 3019, 1019),
    (5020, 'MED020', 'Take 1 tablet daily at bedtime', 'D020', 3020, 1020);



INSERT INTO Mediclaim (Claim_id, Claim_date, Claim_amount, Claim_status, Company_name, Claim_type, Patient_id) VALUES
    
    ('CLM003', '2023-08-15', 800, 'Denied', 'MediCare', 'Medication', 3003),
    ('CLM004', '2023-08-20', 500, 'Pending', 'HealthGuard', 'Diagnostics', 3004),
    ('CLM005', '2023-08-25', 1000, 'Approved', 'HealthSure', 'Surgery', 3005),
    ('CLM006', '2023-08-30', 300, 'Denied', 'CareCover', 'Medical Expenses', 3006),
    ('CLM007', '2023-09-05', 1200, 'Pending', 'MediCare', 'Hospitalization', 3007),
    ('CLM008', '2023-09-10', 700, 'Approved', 'HealthGuard', 'Medication', 3008),
    ('CLM009', '2023-09-15', 250, 'Denied', 'HealthSure', 'Diagnostics', 3009),
    ('CLM010', '2023-09-20', 1800, 'Pending', 'CareCover', 'Surgery', 3010),
    ('CLM011', '2023-09-25', 600, 'Approved', 'MediCare', 'Medical Expenses', 3011),
    ('CLM012', '2023-09-30', 1300, 'Denied', 'HealthGuard', 'Hospitalization', 3012),
    ('CLM013', '2023-10-05', 400, 'Pending', 'HealthSure', 'Medication', 3013),
    ('CLM014', '2023-10-10', 900, 'Approved', 'CareCover', 'Diagnostics', 3014),
    ('CLM015', '2023-10-15', 750, 'Denied', 'MediCare', 'Surgery', 3015),
    ('CLM016', '2023-10-20', 1600, 'Pending', 'HealthGuard', 'Medical Expenses', 3016),
    ('CLM017', '2023-10-25', 350, 'Approved', 'HealthSure', 'Hospitalization', 3017),
    ('CLM018', '2023-10-30', 1100, 'Denied', 'CareCover', 'Medication', 3018),
    ('CLM019', '2023-11-05', 220, 'Pending', 'MediCare', 'Diagnostics', 3019),
    ('CLM020', '2023-11-10', 1400, 'Approved', 'HealthGuard', 'Surgery', 3020);


INSERT INTO Bill (Bill_id, Patient_id, Doctor_id, Medical_id, Total_amount, Admit_id) VALUES
   
    (10003, 3003, 1003, NULL, 800, 'ADM003'),
    (10004, 3004, 1004, NULL, 1200, 'ADM004'),
    (10005, 3005, 1005, 'CLM005', 3500, 'ADM005'),
    (10006, 3006, 1006, NULL, 400, 'ADM006'),
    (10007, 3007, 1007, NULL, 1800, 'ADM007'),
    (10008, 3008, 1008, NULL, 900, 'ADM008'),
    (10009, 3009, 1009, NULL, 500, 'ADM009'),
    (10010, 3010, 1010, 'CLM010', 2800, 'ADM010'),
    (10011, 3011, 1011, NULL, 600, 'ADM011'),
    (10012, 3012, 1012, NULL, 1500, 'ADM012'),
    (10013, 3013, 1013, NULL, 300, 'ADM013'),
    (10014, 3014, 1014, 'CLM014', 1300, 'ADM014'),
    (10015, 3015, 1015, NULL, 1000, 'ADM015'),
    (10016, 3016, 1016, NULL, 2200, 'ADM016'),
    (10017, 3017, 1017, NULL, 600, 'ADM017'),
    (10018, 3018, 1018, NULL, 1100, 'ADM018'),
    (10019, 3019, 1019, NULL, 200, 'ADM019'),
    (10020, 3020, 1020, 'CLM020', 1700, 'ADM020');
    
INSERT INTO Payment (Payment_id, Bill_id, Transaction_id, Paid_amount, Mode_of_payment) VALUES
  
    (20003, 10003, 30003, 800, 'Cash'),
    (20004, 10004, 30004, 1000, 'Online Transfer'),
    (20005, 10005, 30005, 3000, 'Credit Card'),
    (20006, 10006, 30006, 200, 'Cash'),
    (20007, 10007, 30007, 1600, 'Debit Card'),
    (20008, 10008, 30008, 900, 'Online Transfer'),
    (20009, 10009, 30009, 500, 'Cash'),
    (20010, 10010, 30010, 2500, 'Credit Card'),
    (20011, 10011, 30011, 600, 'Debit Card'),
    (20012, 10012, 30012, 1200, 'Online Transfer'),
    (20013, 10013, 30013, 300, 'Cash'),
    (20014, 10014, 30014, 1300, 'Credit Card'),
    (20015, 10015, 30015, 800, 'Debit Card'),
    (20016, 10016, 30016, 1800, 'Online Transfer'),
    (20017, 10017, 30017, 500, 'Cash'),
    (20018, 10018, 30018, 1000, 'Credit Card'),
    (20019, 10019, 30019, 150, 'Debit Card'),
    (20020, 10020, 30020, 1600, 'Online Transfer');
    
  
    
INSERT INTO Payment_transaction (Transaction_id, Transaction_time, Transaction_date, Payment_id) VALUES
   
    (30003, '18:45:00', '2023-08-07', 20003),
    (30004, '11:30:00', '2023-08-08', 20004),
    (30005, '15:20:00', '2023-08-09', 20005),
    (30006, '12:00:00', '2023-08-10', 20006),
    (30007, '16:45:00', '2023-08-11', 20007),
    (30008, '10:30:00', '2023-08-12', 20008),
    (30009, '19:15:00', '2023-08-13', 20009),
    (30010, '13:45:00', '2023-08-14', 20010),
    (30011, '08:30:00', '2023-08-15', 20011),
    (30012, '17:00:00', '2023-08-16', 20012),
    (30013, '14:15:00', '2023-08-17', 20013),
    (30014, '09:45:00', '2023-08-18', 20014),
    (30015, '18:30:00', '2023-08-19', 20015),
    (30016, '11:00:00', '2023-08-20', 20016),
    (30017, '15:45:00', '2023-08-21', 20017),
    (30018, '10:15:00', '2023-08-22', 20018),
    (30019, '19:00:00', '2023-08-23', 20019),
    (30020, '13:30:00', '2023-08-24', 20020);
    
   
ALTER TABLE Payment 
  ADD FOREIGN KEY (Transaction_id) REFERENCES Payment_transaction(Transaction_id) ON DELETE cascade  ON UPDATE CASCADE;
  
  


UPDATE Doctor_Speciality
set Doctor_id = 1001
Where Specialty_id   = 'SP001' ;
    

UPDATE Doctor_Speciality
SET Doctor_id = 1002
WHERE Specialty_id = 'SP002';

UPDATE Doctor_Speciality
SET Doctor_id = 1003
WHERE Specialty_id = 'SP003';

UPDATE Doctor_Speciality
SET Doctor_id = 1004
WHERE Specialty_id = 'SP004';

UPDATE Doctor_Speciality
SET Doctor_id = 1005
WHERE Specialty_id = 'SP005';

UPDATE Doctor_Speciality
SET Doctor_id = 1006
WHERE Specialty_id = 'SP006';

UPDATE Doctor_Speciality
SET Doctor_id = 1007
WHERE Specialty_id = 'SP007';

UPDATE Doctor_Speciality
SET Doctor_id = 1008
WHERE Specialty_id = 'SP008';

UPDATE Doctor_Speciality
SET Doctor_id = 1009
WHERE Specialty_id = 'SP009';

UPDATE Doctor_Speciality
SET Doctor_id = 1005
WHERE Specialty_id = 'SP010';

UPDATE Doctor_Speciality
SET Doctor_id = 1011
WHERE Specialty_id = 'SP011';

UPDATE Doctor_Speciality
SET Doctor_id = 1012
WHERE Specialty_id = 'SP012';

UPDATE Doctor_Speciality
SET Doctor_id = 1013
WHERE Specialty_id = 'SP013';

UPDATE Doctor_Speciality
SET Doctor_id = 1004
WHERE Specialty_id = 'SP014';

UPDATE Doctor_Speciality
SET Doctor_id = 1015
WHERE Specialty_id = 'SP015';

UPDATE Doctor_Speciality
SET Doctor_id = 1002
WHERE Specialty_id = 'SP016';

UPDATE Doctor_Speciality
SET Doctor_id = 1017
WHERE Specialty_id = 'SP017';

UPDATE Doctor_Speciality
SET Doctor_id = 1018
WHERE Specialty_id = 'SP018';

UPDATE Doctor_Speciality
SET Doctor_id = 1001
WHERE Specialty_id = 'SP019';

UPDATE Doctor_Speciality
SET Doctor_id = 1020
WHERE Specialty_id = 'SP020';



select * from Patient ;

delete from Patient where Patient_id = 3020;

insert into Patient values(3020, 'Lucas', 'Johnson', 'Male', 20, '1110009999', '567 Maple St', 'CA', 'San Francisco', '94101', 1020, 2020, 'AT020');
update Patient set Attende_id = 'AT019' where Patient_id = 3020;

select *  from Patient;
select * from Bill;


ALTER TABLE Doctor 
	ADD COLUMN Doctor_tag varchar(20);
    
    

