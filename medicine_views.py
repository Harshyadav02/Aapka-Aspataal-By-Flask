from db import Base , session
from flask import Blueprint , render_template , request , flash
from sqlalchemy.exc import IntegrityError
from utils import login_required

medicine_blue_print = Blueprint('medicine_blue_print', __name__)

@medicine_blue_print.route('/medecine_section/')
@login_required
def medecine_section():

    return render_template('medecine/medecine.html')


@medicine_blue_print.route('/add_medecine/' , methods=("POST" ,"GET"))
@login_required
def add_medecine():
	
	if request.method == 'POST':
		medicine_id    = request.form['medicine_id']	
		drug_name    = request.form['drug_name']
		drug_company    = request.form['drug_company']
		dosage    = request.form['dosage']
		Med_description    = request.form['Med_description']
		cost    = request.form['cost']
		

		msg = None
		error = None 

		if medicine_id is None: 

			error = "Enter medecine Id" 
		elif drug_name is None :

			error  = "Enter drug name "
		
		if error is None: 

			try:

				medecine = session.query(Base.classes.Medecine).filter_by(Medicine_id=medicine_id).first()
				if medecine is None:

					medecine = Base.classes.Medecine(Medicine_id = medicine_id , Drug_name = drug_name  ,Drug_company = drug_company , Dosage = dosage , Med_description = Med_description , cost = cost )

					session.add(medecine)
					session.commit()

					return render_template('success.html')
				else:
					error = 'Medecine Already available '
			except IntegrityError as e:

				error = 'Medecine Already available '
		if error is not None:
			flash(error)
		
	return render_template('medecine/add_medecine.html')


@medicine_blue_print.route('/delete_medecine/<medicine_id>')
@login_required
def delete_medecine(medicine_id):

	error = None 
	if error is  None:
		try:
			medecine = session.query(Base.classes.Medecine).filter_by(Medicine_id=medicine_id).first()
			if medecine is not None:
				session.delete(medecine)
				session.commit()
				return render_template('success.html')
			
		except Exception :
			return  'Something went wrong try again'
		
			


@medicine_blue_print.route("/all_medicine_detail/")
@login_required
def all_medicine_detail():
	

	# fetching the medecine table
	medicine = Base.classes.Medecine

	# retrieving the data from the medecine table
	medicine_list = session.query(medicine)
	total_medicine = medicine_list.count()

	medicine = medicine_list.all()

	session.close()
	# rendering the Patient data to html page
	return render_template('medecine/medicine_list.html', medicines=medicine ,  total_medicine=total_medicine)

@medicine_blue_print.route('/update_medecine/<medicine_id>' , methods=['POST' ,'GET'])
@login_required
def update_medecine(medicine_id):

	if (request.method == 'POST'):

		to_update = request.form['to_update']
		updated_value = request.form['updated_value']
		error = None
		
		if to_update is None :
			error = 'Enter the column name to update'
		
		if updated_value is None:
			error = 'Enter the new value for updation'
		
		if medicine_id :
			try :

				medecine = session.query(Base.classes.Medecine).filter_by(Medicine_id = medicine_id).first()

				if medecine:
					setattr(medecine, to_update, updated_value)
					session.commit()
						
						
						
				return render_template('success.html')
			except Exception:
				error = 'Something went wrong try again'

			finally:
				session.commit()

		flash(error)
	return render_template('medecine/update_medecine.html' ,medicine_id = medicine_id)

