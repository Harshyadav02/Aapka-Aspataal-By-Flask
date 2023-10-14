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
