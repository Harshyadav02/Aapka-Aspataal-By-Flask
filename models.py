from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user


Base = declarative_base()

class Admin(Base,UserMixin):
    __tablename__ = 'Admin' 
    
    username = Column(String(20), primary_key=True)
    password = Column(String(255))

