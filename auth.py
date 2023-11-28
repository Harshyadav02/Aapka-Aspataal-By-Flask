from flask import Blueprint ,request , redirect , url_for , flash , render_template
from db import session 
from sqlalchemy.exc import IntegrityError
from werkzeug.security import check_password_hash, generate_password_hash
from flask import session as flask_session
from models import Admin, Nurse
from db import Base
# from init import  login_manager


auth_blue_print = Blueprint('auth' , __name__)


@auth_blue_print.route('/register/', methods=('POST','GET'))
def register():
	if request.method == 'POST':
		
		# reterving the username and password from html form
		username = request.form['username']
		password = generate_password_hash(request.form['password'])

		error = None

		# if username  or password is  none 
		if not username:
			error = 'Username is required.'
		elif not password:
			error = 'Password is required.'

		if error is None:
			try:

				# inserting data to admin table 
				# admin = Admin(username=username, password=password)
				admin = Admin(username=username, password=password)
				session.add(admin)
				session.commit()
				# redirect(url_for('auth.login'))
				return redirect(url_for('auth.login'))

			# handling th error if user input is duplicate
			except IntegrityError as e:
				
				error = 'Username already exists.'
				
			
			finally:
				session.close()
		
		flash(error)
	return render_template('auth/register.html')
	

@auth_blue_print.route('/login/' , methods=('POST' , 'GET'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        error = None

	#  fetching the username from Admin table
        user = session.query(Admin).filter_by(username=username).first()

        if user is None:
            error = 'Incorrect username.'
        elif not check_password_hash(user.password, password):
            error = 'Incorrect password.'

        if error is None:
            # adding user to flask sesssion
            flask_session['role'] = 'Admin'
            return redirect(url_for('blue_print.dashboard' , user= username))

        flash(error)

    return render_template('auth/login.html')


@auth_blue_print.route('/admin-dashboard/<user>')
def admin_dashboard(user):
	page = request.args.get('page', default=1, type=int)
	# fetching the user from database
	username = session.query(Admin).filter_by(username=user).first()
	# if username is None:
		
	# 	return 'user not found '
	# else:
	return render_template('dashboard.html' ,user = user , page = page)


@auth_blue_print.route('/logout/')
def logout():
    # Removing all the logined user form the session	
    flask_session.pop('username', None) 
    flask_session.pop('Doctor_id', None)
    flask_session.pop('Nurse_id', None)   
    return redirect(url_for('index'))

@auth_blue_print.route('/login_required/')
def login_required():
    return render_template('pls_login.html')
    

@auth_blue_print.route('/doctor_login/', methods=['POST', 'GET'])
def doctor_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        doctor = session.query(Base.classes.Doctor).filter_by(Doctor_id=username).first()

        if doctor is None:
            flash('Doctor not found')
        elif not check_password_hash(doctor.Password, password):
            flash('Invalid password')
        else:
            flask_session['Doctor_id'] = doctor.Doctor_id  # Use 'Doctor_id' for session key
            print(flask_session.keys())
            return redirect(url_for('auth.admin_dashboard', user=username))
    return render_template('auth/Doctor_login.html')

	
@auth_blue_print.route('/doctor_registration/' , methods=['POST', 'GET'])
def doctor_registration():

	if request.method == 'POST' :

		username = request.form['username']
		password = generate_password_hash(request.form['password'])
		to_update = 'Password'
		user = session.query(Base.classes.Doctor).filter_by(Doctor_id = username).first()

		if user :

			setattr(user , to_update , password )
			session.commit()
			return render_template('success.html')
		else:
			flash('User not found')
		return render_template('success.html')
	return render_template('auth/Doctor_register.html')


@auth_blue_print.route('/nurse_login/', methods=['POST', 'GET'])
def nurse_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        nurse = session.query(Base.classes.Nurse).filter_by(username=username).first()

        if nurse is None:
            flash('Nurse not found')
        elif not check_password_hash(nurse.Password, password):
            flash('Invalid password')
        else:
            flask_session['role'] = 'nurse'  # Use 'Nurse_id' for session key
            print(type(flask_session))
            return redirect(url_for('blue_print.dashboard', user=username))
    return render_template('auth/Nurse_login.html')

@auth_blue_print.route('/Nurse_registration/' , methods=['POST', 'GET'])
def Nurse_registration():

	if request.method == 'POST' :

		username = request.form['username']
		password = generate_password_hash(request.form['password'])
		to_update = 'Password'
		nurse =session.query(Base.classes.Nurse).filter_by(username=username).first()

		if nurse :

			setattr(nurse , to_update , password )
			session.commit()
			return render_template('success.html')
		else:
			flash('User not found')
		
	return render_template('auth/Nurse_registration.html')

@auth_blue_print.route('/chemist_login/')
def chemist_login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        chemist = session.query(Base.classes.chemist).filter_by(chemist_id=username).first()

        if chemist is None:
            flash('chemist not found')
        elif not check_password_hash(chemist.Password, password):
            flash('Invalid password')
        else:
            flask_session['chemist_id'] = chemist.chemist_id  # Use 'chemist_id' for session key
            print(flask_session.keys())
            return redirect(url_for('auth.admin_dashboard', user=username))
    return render_template('auth/chemist_login.html')
