# Delete all patients who have been admitted to the hospital for a particular disease 

DELETE Patient  from Patient
 join Admission on Patient.Patient_id  =  Admission.Patient_id 
 join Disease on Admission.Patient_id = Disease.Patient_id
 where Disease_id = (select Disease_id from Disease where Disease_name = 'Depression');

