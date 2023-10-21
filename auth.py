from flask import Blueprint ,request , redirect , url_for , flash , render_template
from db import session 
from sqlalchemy.exc import IntegrityError
from werkzeug.security import check_password_hash, generate_password_hash
from flask import session as flask_session
from models import Admin 
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
            flask_session['username'] = user.username
            return redirect(url_for('auth.admin_dashboard' , user= username))

        flash(error)

    return render_template('auth/login.html')


@auth_blue_print.route('/admin-dashboard/<user>')
def admin_dashboard(user):
	page = request.args.get('page', default=1, type=int)
	# fetching the user from database
	username = session.query(Admin).filter_by(username=user).first()
	if username is None:
		
		return 'user not found '
	else:
		return render_template('admin_dash.html' ,user = user , page = page)


@auth_blue_print.route('/logout/')
def logout():
    flask_session.pop('username', None)  
    return redirect(url_for('auth.login'))


# def authenticate_user(username, password):
#     admin = session.query(Admin).filter_by(username=username).first()
#     if admin and admin.password == password:
#         return admin


@auth_blue_print.route('/login_required/')
def login_required():
    return render_template('pls_login.html')
    
    

