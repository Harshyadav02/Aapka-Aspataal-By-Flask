from sqlalchemy import Column, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user

# making object of declartive_base
Base = declarative_base()

# Admin class
class Admin(Base,UserMixin):
    __tablename__ = 'Admin' 
    
    username = Column(String(20), primary_key=True)
    password = Column(String(255))
# Nurse class
class Nurse(Base , UserMixin):
    __tablename__ = 'Nurse'

    username = Column(String(20) , primary_key=True)
    password = Column(String(255) , nullable=False)
    First_Name  = Column(String(20) , nullable=False)
    Last_Name = Column(String(20) , nullable=False)
    contact = Column(Integer , nullable=False)
    role = Column(String(20) , default='Nurse' , nullable=False)

class Chemist(Base , UserMixin):
    __tablename__ = 'Chemist'

    username = Column(String(20) , primary_key=True)
    password = Column(String(255) , nullable=False , default=None)
    First_Name  = Column(String(20) , nullable=False)
    Last_Name = Column(String(20) , nullable=False)
    contact = Column(Integer , nullable=False)
    role = Column(String(20) , default='Chemist' , nullable=False)

