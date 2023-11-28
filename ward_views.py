from flask import Blueprint , render_template ,flash  , request
from db import Base , session
from sqlalchemy.exc import IntegrityError
from utils import requires_role 
ward_blueprint = Blueprint('ward_blueprint' , __name__)



@ward_blueprint.route('/ward_section/')
@requires_role(['Admin'])
def ward_section():
	return render_template('ward/ward.html')



@ward_blueprint.route('/add_ward/' ,methods=['GET' ,'POST'])
@requires_role(['Admin'])
def add_ward():
    if request.method == 'POST':
        Ward_id = request.form['Ward_id']
        Ward_type = request.form['Ward_type']
        ward_charge = request.form['ward_charge']

       
        error = None

        if Ward_id is None:
            error = "Enter Ward Id"
        elif Ward_type is None:
            error = "Enter Ward Type"
        elif ward_charge is None:
            error = "Enter Ward Charge"

        if error is None:
            try:
                ward = Base.classes.Ward(Ward_id=Ward_id, Ward_type=Ward_type, ward_charge=ward_charge)
                session.add(ward)
                session.commit()
                return render_template('success.html')
            except IntegrityError as e:
                session.rollback()
                error = 'Ward Already available'
            except Exception as e:
                session.rollback()
                error = 'Something went wrong'
        flash(error)

    return render_template('ward/add_ward.html')
    
@ward_blueprint.route('/update_ward/<ward_id>',methods=['GET' ,'POST'])
@requires_role(['Admin'])

def update_ward(ward_id):

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
				
				if hasattr(Base.classes.Ward, to_update):
					ward = session.query(Base.classes.Ward).filter_by(Ward_id=ward_id).first()
					
					if ward is None :
						error = 'ward not found'
					
					if ward :

						setattr(ward, to_update, updated_value)
						session.commit()	
						return render_template('success.html')

			except :
				error = 'Something went wrong try again'
			finally:
				session.commit()
		flash(error)
	return render_template('ward/update_ward.html' ,ward_id = ward_id)

     
@ward_blueprint.route('/delete_ward/<ward_id>')
@requires_role(['Admin'])
def delete_ward(ward_id):


		error  = None
		if error is  None:
			try:
				ward = session.query(Base.classes.Ward).filter_by(Ward_id=ward_id).first()
				if ward is not None:
					session.delete(ward)
					session.commit()
					return render_template('success.html')
				else:
					error = 'ward Not Found'
			except Exception :

				error = 'Something went wrong try again'
		flash(error)


@ward_blueprint.route('/single_ward/' , methods=['GET' ,'POST'])
@requires_role(['Admin'])
def single_ward():

    if request.method == 'POST':
        ward_id = request.form['ward_id']
        if not ward_id:
            flash('Please enter a ward ID.')
        else:
            ward = session.query(Base.classes.Ward).filter_by(Ward_id=ward_id).first()
            if ward is not None:
                return render_template('ward/single_ward.html', ward=ward)
            else:
                flash('ward not found.')

    return render_template('ward/single_ward.html')



@ward_blueprint.route("/all_ward_detail/")

def all_ward_detail():

	page = request.args.get('page' , default=1 ,type=int)
	per_page = 10 

	Ward = Base.classes.Ward 
	ward_query = session.query(Ward)
	total_ward = ward_query.count()
 
	# retriving all the data from db
  

	# taotal number of patient
 

	# limiting the number of patients per page  and the offset is used to skip the data 
	wards = ward_query.limit(per_page).offset((page-1)*per_page).all()
	
	
	# rendering the ward data to html page
	return render_template('ward/ward_list.html',ward=wards,page=page, per_page=per_page, total_patients=total_ward)


