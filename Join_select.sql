select * from Doctor_Speciality;
# Inner join

select Patient.First_name ,Attende.First_name ,Patient.Attende_id , Patient_id  from Patient  
inner join Attende  on Patient.Attende_id = Attende.Attende_id;

# Getting name of doctor who has more the one Speciality 

SELECT Doctor.First_name, Doctor.Last_name
FROM Doctor
JOIN Doctor_Speciality ON Doctor.Doctor_id = Doctor_Speciality.Doctor_id
GROUP BY Doctor.Doctor_id
HAVING COUNT(Doctor_Speciality.Specialty_id) > 1;


# Quries to find the names of all patients and their attending doctors.

SELECT Patient.First_name , Patient.Last_name from Patient
join Doctor on Patient.Doctor_id = Doctor.Doctor_id; 

# Query to find the names of all patients who have been admitted to the ICU ward.

SELECT Patient.First_name, Patient.Last_name 
FROM Patient 
JOIN Admission ON Patient.Patient_id = Admission.Patient_id
JOIN Ward ON Admission.Ward_id = Ward.Ward_id
WHERE Ward.Ward_type = 'General' and Patient.First_name  = 'Harsh' ;


# query to find the names of all patients who have been prescribed a certain medicine.
SELECT p.First_name, p.Last_name
FROM Medication m
JOIN Patient p ON m.Patient_id = p.Patient_id
JOIN Medecine me ON m.Medicine_id = me.Medicine_id
WHERE me.Drug_name = 'Loratadine';

# query to find the total amount of money that a patient has paid for their medical bills.

SELECT Total_amount from Bill 
join Patient on Bill.Patient_id  = Patient.Patient_id 
where Patient.First_name = "Emily";

# query to find the names of all patients who have been treated by a specific doctor 
SELECT Patient.First_name , Patient.Last_name  from Patient
join Doctor on Patient.Doctor_id = Doctor.Doctor_id
where Doctor.Doctor_id = 1010;

insert into Admission values('ADM021' , '2023-08-02' , 1021 , '2023-08-08' , 1003 , 2003); 

# query to find the names of all patients who have been admitted to the hospital on a specific date 

SELECT Patient.First_name , Patient.Last_name from Patient
join Admission on Admission.Patient_id = Patient.Patient_id 
where Admit_date = '2023-09-01';

#  query to find the names of all patients who have been treated for a specific disease

SELECT Patient.First_name , Patient.Last_name from Patient 
join Disease on Disease.Patient_id = Patient.Patient_id 
where Disease_name = 'Asthma';


# query to find the total amount of money that a doctor has received from patients

SELECT Doctor.First_name, SUM(Bill.Total_amount) AS Total_received
FROM Doctor
JOIN Bill ON Doctor.Doctor_id = Bill.Doctor_id
GROUP BY Doctor.First_name;

# query to find the names of all patients who have been admitted to the same ward

SELECT Patient.Patient_id ,Patient.First_name , Patient.Last_name from Patient 
join Ward on Ward.Ward_id = Patient.Ward_id
where Ward.Ward_type = 'General'
GROUP BY Patient.Patient_id , Patient.First_name , Patient.Last_name;




select Doctor.Doctor_id  , count(Medication.Doctor_id) from Doctor join Medication on Doctor.Doctor_id = Medication.Doctor_id group by Doctor.Doctor_id;


# Nested Quries 

# patients who have been admitted to the General Ward. 

select * from Patient where Ward_id = (select Ward_id from Ward where Ward_type = 'General');

# patients who have been admitted by a doctor who specializes in Cardiology.
select First_name , Last_name from Patient where Doctor_id = (select Doctor_id from Doctor_Speciality where Specialty_name = 'Cardiology'); 

# patient who has stayed in the hospital for the longest time for a particular ward.
