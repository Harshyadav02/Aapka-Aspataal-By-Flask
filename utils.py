from functools import wraps
from flask import  redirect, url_for
from flask import session as flask_session
def login_required(view_func):
    @wraps(view_func)
    def check_login(*args, **kwargs):
        if 'username' not in flask_session:
            
            return redirect(url_for('auth.login_required'))
        
        return view_func(*args, **kwargs)
    
    return check_login

def doctor_required(view_func):
    @wraps(view_func)
    def check_doctor(*args, **kwargs):
        if 'Doctor_id' not in flask_session:
            print('Doctor not logged in')
            return redirect(url_for('auth.login_required'))  # Redirect to doctor login if not logged in as a doctor
        return view_func(*args, **kwargs)
    print('Doctor  is logged in')
    return check_doctor 

def nurse_admin_required(view_func):
    @wraps(view_func)
    def check_nurse_admin(*args, **kwargs):
        if 'Nurse_id' not in flask_session and 'username' not in flask_session:
            print(flask_session.keys())
            return redirect(url_for('auth.login_required'))  # Redirect to doctor login if not logged in as a doctor
        return view_func(*args, **kwargs)
    
    return check_nurse_admin

def medical_admin_required(view_func):

    @wraps(view_func)
    def check_medical_admin(*args , **kwargs):

        if 'Medical_id' not in flask_session and 'username' not in flask_session:

            return redirect(url_for('auth.login_required'))
        return view_func(*args, **kwargs)
    return check_medical_admin 