
from sqlalchemy import create_engine 
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session, sessionmaker

# creating engine for database
engine = create_engine("mysql+pymysql://root:root@localhost/HOSPITAL")

# maping the existing database with SQLAlchemy
Base = automap_base()
Base.prepare(engine, reflect=True)
Session = sessionmaker(bind=engine)
session = Session()






