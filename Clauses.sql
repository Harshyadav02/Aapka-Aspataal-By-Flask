 # query to find the doctor who has prescribed the most expensive medication, using the WHERE clause. 

SELECT Patient.Patient_id
FROM Admission
JOIN Disease ON Admission.Disease_id = Disease.Disease_id
GROUP BY Patient_id, Disease_id
HAVING COUNT(*) = (
    SELECT MAX(COUNT(*))
    FROM Admission
    JOIN Disease ON Admission.Disease_id = Disease.Disease_id
);


# find the patient who has stayed in the hospital  for a particular ward.

SELECT First_name, Ward_type
FROM Patient, Ward
WHERE (Patient.Patient_id, Ward.Ward_id) IN (
    SELECT Admission.Patient_id, Admission.Ward_id
    FROM Admission
    JOIN Ward ON Admission.Ward_id = Ward.Ward_id
    GROUP BY Admission.Patient_id, Admission.Ward_id
);
