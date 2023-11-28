from db import Base , session
from flask import Blueprint , render_template , request , flash
from sqlalchemy.exc import IntegrityError
from utils import requires_role

# creating blueprint for doctor
doctor_blueprint = Blueprint('doctor_blueprint', __name__)

@doctor_blueprint.route('/doctor_section/')
@requires_role(['Admin'])
def doctor_section():

    return render_template('doctor/doctor.html')

# function for adding doctor 
@doctor_blueprint.route('/add_doctor/' , methods=("POST" ,"GET"))
@requires_role(['Admin'])
def add_doctor():
	
	if request.method == 'POST':
		doctor_id    = request.form['doctor_id']	
		First_name    = request.form['First_name']
		Last_name    = request.form['Last_name']
		Gender    = request.form['Gender']
		contact    = request.form['contact']
		Doctor_Charge    = request.form['Doctor_Charge']
		Specialty_id    = request.form['Specialty_id']
		

		msg = None
		error = None 

		if doctor_id is None: 

			error = "Enter doctor Id" 
		elif Specialty_id is None :

			error  = "Enter Specialty Id"
		
		if error is None: 

			try:

				doctor = Base.classes.Doctor(Doctor_id = doctor_id , First_name = First_name  ,Last_name = Last_name , Gender = Gender , contact = contact , Doctor_Charge = Doctor_Charge , Specialty_id = Specialty_id)

				session.add(doctor)
				session.commit()
				
				msg = "doctor Added Successfully"

				return render_template('success.html')
			except IntegrityError as e:

				error = 'doctor Already available '
		if error is not None:
			flash(error)
		
	return render_template('doctor/add_doctor.html')

# function for deleting function
@doctor_blueprint.route('/delete_doctor/<int:doctor_id>')
@requires_role(['Admin'])
def delete_doctor(doctor_id):

		doctor = session.query(Base.classes.Doctor).filter_by(Doctor_id=doctor_id).first()
		if doctor is not None:
			session.delete(doctor)
			session.commit()
			return render_template('success.html')
		else:
			return  'Doctor Not Found'
		



# function for doctor detail
@doctor_blueprint.route('/single_doctor/', methods=('POST', 'GET'))
@requires_role(['Admin'])
def single_doctor():
	
    doctor_id = request.form.get('doctor_id')
	
    if request.method == 'POST':
        if not doctor_id:
            flash('Please enter a doctor ID.')
        else:
            doctor = session.query(Base.classes.Doctor).filter_by(Doctor_id=doctor_id).join(Base.classes.Doctor_Speciality, Base.classes.Doctor.Doctor_id == Base.classes.Doctor_Speciality.Doctor_id).first()
			
            doctor_specililty=(session.query(Base.classes.Doctor ,Base.classes.Doctor_Speciality.Specialty_name).filter(Base.classes.Doctor.Doctor_id==doctor_id).join(Base.classes.Doctor_Speciality, Base.classes.Doctor.Specialty_id == Base.classes.Doctor_Speciality.Specialty_id).all())

            if doctor is not None:
                return render_template('doctor/single_doctor.html', doctor=doctor , doctor_specililty = doctor_specililty)
            else:
                flash('Doctor not found.')

    return render_template('doctor/single_doctor.html')

@doctor_blueprint.route("/all_doctor_detail/")
@requires_role(['Admin'])
def all_doctor_detail():
	
	page = request.args.get('page', default=1, type=int)
	per_page = 10

	# fetching the Doctor table
	Doctor = Base.classes.Doctor

	# retrieving the data from the Doctor table
	doctor_query = session.query(Doctor)
	total_doctor = doctor_query.count()

	doctors = doctor_query.limit(per_page).offset(((page-1) *per_page)).all()

	session.close()

	# rendering the Patient data to html page
	return render_template('doctor/doctor_list.html', doctors=doctors, page=page, per_page=per_page, total_doctor=total_doctor)

# function for updating the doctor
@doctor_blueprint.route('/update_doctor/<int:doctor_id>' , methods=['POST' ,'GET'])
@requires_role(['Admin'])
def update_doctor(doctor_id):
	if request.method == 'POST':

		to_update = request.form['to_update']
		updated_value = request.form['update_value']
		error = None
		print(doctor_id)

		if to_update is None :
			error = 'Enter the column name to update'
		print(to_update)
		if updated_value is None:
			error = 'Enter the new value for updation'
		print(updated_value)
		if error is None:
		
			try: 
				# checking if the column exist in table Patient
				
					doctor = session.query(Base.classes.Doctor).filter_by(Doctor_id=doctor_id).first()

					if doctor :

						# updating the doctor value
						setattr(doctor, to_update, updated_value)
						session.commit()	
						return render_template('success.html')
					else:
						error = 'User not found'


			except :
				error = 'Something went wrong try again'
			finally:
				session.commit()
		flash(error)
	return render_template('doctor/update_doctor.html' ,doctor = doctor_id )


