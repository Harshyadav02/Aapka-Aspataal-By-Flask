from flask import Flask, render_template
from models import  Base
from auth import auth_blue_print 
from doctor_views import doctor_blueprint
from medicine_views import medicine_blue_print
from views import blue_print
from bill_views import bill_blueprint
from ward_views import ward_blueprint
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine


def create_app():
    app = Flask(__name__ ,static_folder="static")

    # Set a secret key for your application
    app.secret_key = '#qwertyuiop!!!!234567$$'
    engine = create_engine("mysql+pymysql://root:root@localhost/HOSPITAL")
    Base.metadata.create_all(engine)  # Create tables if they don't exist
    Session = sessionmaker(bind=engine)
    ss = Session()
  

    @app.route("/")
    def index():
        return render_template('index.html')

    # Register your blueprints
    app.register_blueprint(blue_print)
    app.register_blueprint(auth_blue_print)
    app.register_blueprint(doctor_blueprint)
    app.register_blueprint(medicine_blue_print)
    app.register_blueprint(bill_blueprint)
    app.register_blueprint(ward_blueprint)

    

    return app

if __name__ == '__main__':
    app = create_app()
   
    app.run(host='0.0.0.0', port=5000, debug=True)
