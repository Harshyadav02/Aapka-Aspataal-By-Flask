from db import session , Base
from flask import  render_template , Blueprint , request , render_template , flash ,redirect , url_for  
from sqlalchemy.exc import IntegrityError
from utils import login_required , doctor_required
import sqlalchemy
from db import session

from sqlalchemy import  text
blue_print  = Blueprint('blue_print',__name__ )

@blue_print.route('/patient_section/')
@login_required
def patient_section():
	return render_template('patient.html')


@blue_print.route('/main_page/')
@login_required
def index():
	return render_template('index.html')

@blue_print.route('/add_patient/' , methods=("POST" ,"GET"))
@login_required 
def add_patient():
	
	if request.method == 'POST':

		Patient_id = request.form['Patient_id']	
		First_name = request.form['First_name']
		Last_name = request.form['Last_name']
		Gender = request.form['Gender']
		State = request.form['State']
		Age = request.form['Age']
		Contact = request.form['Contact']
		Street = request.form['Street']
		City = request.form['City']
		Postal_code = request.form.get('Postal_code')
		Doctor_id = request.form['Doctor_id']
		Ward_id = request.form.get('Ward_id')
		Attende_id = request.form.get('Attende_id')

		msg = None
		error = None 

		if Patient_id is None: 

			error = "Enter Patient Id" 
		elif Doctor_id is None :

			error  = "Enter Doctor Id"
		
		if Attende_id == '':
			Attende_id = None
		if Ward_id ==  '':
			Ward_id  = sqlalchemy.null()
		if Postal_code == '':
			Postal_code = None

		if  Street == '':
			Street = None

		if error is None: 

			try:

				patient = Base.classes.Patient(Patient_id = Patient_id , First_name = First_name  ,Last_name = Last_name , Gender = Gender , Age = Age , contact = Contact , Street = Street ,State = State , City = City , Postal_code = Postal_code , Doctor_id = Doctor_id , Ward_id = Ward_id ,Attende_id = Attende_id)

				session.add(patient)

				return render_template('success.html')
			except IntegrityError as e:
				session.rollback()
				error = 'Patient Already available '
			except sqlalchemy.exc.PendingRollbackError as e:
					session.rollback()
					render_template('error_handling.html')
			except Exception as e:
				session.rollback()
				error = 'Something went wrong'
			finally:
				session.commit()
		
		flash(error)
		
	return render_template('add_patient.html')



def search_patient(user):
	user = session.query()

@blue_print.route('/all_patients_detail/')
@login_required
def all_patient_detail():
    page = request.args.get('page', default=1, type=int)
    per_page = 10
	
    Patient = Base.classes.Patient  # Get the mapped Patient class

	# retriving all the data from db
    patients_query = session.query(Patient)

	# taotal number of patient
    total_patients = patients_query.count()

	# limiting the number of patients per page  and the offset is used to skip the data 
    patients = patients_query.limit(per_page).offset((page-1)*per_page).all()
	# patients=patients, page=page, per_page=per_page
    session.close()

    return render_template('patient_list.html',  total_patients=total_patients , patients=patients , page=page, per_page=per_page)

@blue_print.route('/patients_search/', methods=['GET' ,  "POST"])
def patients_search():
    search_query = request.args.get('search', '').strip().lower()
    
    if search_query:
        search_results = session.query(Base.classes.Patient).filter(
            text(f"LOWER(First_name) LIKE :query OR LOWER(Last_name) LIKE :query")
        ).params(query=f"%{search_query}%").all()
    else:
        search_results = []

    return render_template('patient_list.html', patients=session.query(Base.classes.Patient).all(), search_results=search_results, search_query=search_query)


@blue_print.route('/delete_patient/<int:patient_id>')
def delete_patient(patient_id):

	patient = session.query(Base.classes.Patient).filter_by(Patient_id=patient_id).first()
	if patient is not None:
		session.delete(patient)
		session.commit()
		return render_template('success.html')
	else:
		error = 'Patient Not Found'


@blue_print.route('/update_patient/<int:patient_id>' , methods=('POST' ,'GET'))
@login_required
def update_patient(patient_id):
	patient_id = patient_id

	if request.method == 'POST':

		to_update = request.form['to_update']
		updated_value = request.form['update_value']
		error = None
		

		if to_update is None :
			error = 'Enter the column name to update'
		
		if updated_value is None:
			error = 'Enter the new value for updation'
		
		if error is None:
		
			try: 
				# checking if the column exist in table Patient
				if hasattr(Base.classes.Patient, to_update):
					patient = session.query(Base.classes.Patient).filter_by(Patient_id=patient_id).first()
					
					
					
					if patient :

						# updating the patient value
						setattr(patient, to_update, updated_value)
						session.commit()	
						return render_template('success.html')
					else:
						error = 'User not found'


			except :
				error = 'Something went wrong try again'
			finally:
				session.commit()
		flash(error)
	return render_template('update_single_patient.html' ,patient = patient_id )
	
@blue_print.route('/dashboard/')
def dashboard():

	#  Doctor details 

	doctor_list = session.query(Base.classes.Doctor) 
	doctor_count = doctor_list.count()

	male_doctor = session.query(Base.classes.Doctor).filter_by(Gender='Male');
	male_doctor = male_doctor.count() 
	female_doctor = doctor_count - male_doctor 

	# Patient details
	patient_list = session.query(Base.classes.Patient)
	patient_count = patient_list.count() 

	male_patient = session.query(Base.classes.Patient).filter_by(Gender='Male');
	male_patient = male_patient.count() 

	female_patient = patient_count - male_patient 
	#  Ward details
	ward_list  = session.query(Base.classes.Ward)
	ward_count  = ward_list.count()

	return render_template('dashboard.html' , doctor = doctor_count , patient = patient_count , ward= ward_count , male_doctor=male_doctor , female_doctor = female_doctor , male_patient = male_patient , female_patient= female_patient)

