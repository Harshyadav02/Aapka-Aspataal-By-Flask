
# from  sqlalchemy import create_engine 
# from sqlalchemy.ext.automap import automap_base
# from sqlalchemy.orm import Session ,sessionmaker


# # creating engine to use the database
# engine = create_engine("mysql+pymysql://root:root@localhost/HOSPITAL")

# # create a base class for orm and create python classes  based on our tables present in our db
# Base = automap_base()

# Base.prepare(engine, reflect=True)

# Session = sessionmaker(bind=engine)
# # creating a session for db
# session = Session()


from sqlalchemy import create_engine 
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session, sessionmaker

engine = create_engine("mysql+pymysql://root:root@localhost/HOSPITAL")
Base = automap_base()
Base.prepare(engine, reflect=True)
Session = sessionmaker(bind=engine)
session = Session()

print(Base.classes)




