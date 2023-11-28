from functools import wraps
from flask import  redirect, url_for
from flask import session as flask_session

def requires_role(roles):
    def decorator(view_func):
        @wraps(view_func)
        def wrapped_view(*args, **kwargs):
            if flask_session.get('role') in roles:
                return view_func(*args, **kwargs)
            else:
                return 'Access Denied'

        return wrapped_view

    return decorator

