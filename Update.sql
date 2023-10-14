# Update Quries For multiple tables


# Update the patient's age to 20 and the discharge date to 2023-09-03 in the admission table where the patient ID is 3003.

update Admission 
join Patient on Patient.Patient_id = Admission.Patient_id 
set Patient.Age = 20 , Admission.Discharge_date = '2023-09-03'
where Admission.Patient_id = 3003;

# Update the doctor's specialty ID to 'Surgery' in the medication table where the medicine ID is 100. 
update Medication 
join Doctor_Speciality on Doctor_Speciality.Doctor_id = Medication.Doctor_id 
set Specialty_name = 'Surgery' 
where Medicine_id = 'MED013';

# Update Doctor Speciality Name for a Specific Doctor:

UPDATE Doctor AS d
JOIN Doctor_Speciality AS ds ON d.Specialty_id = ds.Specialty_id
SET ds.Specialty_name = 'Hacker'
WHERE d.Doctor_id =  1001;

# Updating Doctor Charge on the basis of Paid amount 
update Doctor
	join 
		Bill on Bill.Doctor_id = Doctor.Doctor_id 
	set 
		Doctor.Doctor_charge = Doctor.Doctor_Charge + Bill.Total_amount; 
 
# Update the doctor's Tag  as Legend if the doctor has prescribed more than 100 medications.
UPDATE Doctor
	set Doctor_tag = 'Legend' 
    where Doctor.Doctor_id = (select  Medication.Doctor_id from Medication group by   Medication.Doctor_id HAVING COUNT(*) > 2)  ;
    

# Update the patient's insurance claim amount if the patient has been admitted to the hospital more than 5 times.

update Mediclaim  set Claim_amount = 1000 where Patient_id = (select Patient_id from Admission  group by Patient_id having  count(Patient_id) > 2);
    
# Update the payment to CASH method if the payment amount is greater than 1000.

update Payment set  Mode_of_payment  = 'CASH'  where  Paid_amount  > 1000 ;

# Upadting Docoter name and Patient name in Doctor and Patient Table
UPDATE Patient join Doctor on Doctor.Doctor_id = Patient.Doctor_id 
    set Patient.First_name = 'Shubham' , Doctor.First_name = 'ANNA' where Doctor.Doctor_id = 1017;  