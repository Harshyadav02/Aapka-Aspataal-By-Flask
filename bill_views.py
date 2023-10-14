from flask import Blueprint, render_template, flash, request, redirect, url_for
from db import Base, session
from sqlalchemy.exc import IntegrityError
from utils import login_required

bill_blueprint = Blueprint('bill_blueprint', __name__)

@bill_blueprint.route('/bill_section/')
@login_required
def bill_section():
	return render_template('bill/bill.html')

@bill_blueprint.route('/add_bill/', methods=("POST", "GET"))
@login_required
def add_bill():

    if request.method == 'POST':

        Bill_id = request.form['Bill_id']
        Patient_id = request.form['Patient_id']
        Doctor_id = request.form['Doctor_id']
        Medical_id = request.form['Medical_id']
        Total_amount = request.form['Total_amount']
        Admit_id = request.form['Admit_id']

        error = None

        if Bill_id is None:
            error = "Enter Bill ID"
        elif Patient_id is None:
            error = "Enter Patient ID"
        elif Doctor_id is None:
            error = "Enter Doctor ID"
        elif Medical_id == '':
            Medical_id = None
        elif Total_amount is None:
            error = "Enter Total Amount"
        elif Admit_id == '':
            Admit_id = None

        if error is None:
            try:
                patient = session.query(Base.classes.Patient).filter_by(Patient_id=Patient_id)
                if patient :
                    doctor = session.query(Base.classes.Doctor).filter_by(Doctor_id=Doctor_id)
                    if doctor:    
                        bill = Base.classes.Bill(Bill_id=Bill_id ,Patient_id=Patient_id,Doctor_id=Doctor_id, Medical_id=Medical_id, Total_amount=Total_amount, Admit_id=Admit_id)
                        session.add(bill)
                        session.commit()
                        return render_template('success.html')
                    else:
                        error = "Doctor not found"
                else: 
                    error = "Patient not found"
            except IntegrityError as e:
                session.rollback()
                error = 'Bill Already available'
            except Exception as e:
                session.rollback()
                error = 'Something went wrong'
        flash(error)

    return render_template('bill/add_bill.html')

# Route for updating a bill
@bill_blueprint.route('/update_bill/', methods=['GET', 'POST'])
@login_required
def update_bill():
    if request.method == 'POST':
        bill_id = request.form['bill_id']
        to_update = request.form['to_update']
        updated_value = request.form['update_value']

        error = None

        if not bill_id:
            error = "Enter Bill ID"
        elif not to_update:
            error = "Enter the column name to update"
        elif not updated_value:
            error = "Enter the new value for updation"

        if error is None:
            try:
                # Checking if the column exists in the Bill table
                if hasattr(Base.classes.Bill, to_update):
                    bill = session.query(Base.classes.Bill).filter_by(Bill_id=bill_id).first()

                    if bill is None:
                        error = 'Bill not found'

                    if bill:
                        setattr(bill, to_update, updated_value)
                        session.commit()
                        return render_template('success.html')

            except Exception:
                error = 'Something went wrong, please try again'
            finally:
                session.commit()
        flash(error)

    return render_template('bill/update_bill.html')

# Route for deleting a bill
@bill_blueprint.route('/delete_bill/', methods=['GET', 'POST'])
@login_required
def delete_bill():
    if request.method == 'POST':
        bill_id = request.form['bill_id']

        error = None

        if not bill_id:
            error = 'Enter Bill ID'

        if error is None:
            try:
                bill = session.query(Base.classes.Bill).filter_by(Bill_id=bill_id).first()
                if bill is not None:
                    session.delete(bill)
                    session.commit()
                    return render_template('success.html')
                else:
                    error = 'Bill not found'
            except Exception:
                error = 'Something went wrong, please try again'
        flash(error)

    return render_template('bill/delete_bill.html')

# Route for viewing a single bill
@bill_blueprint.route('/single_bill/', methods=['GET', 'POST'])
@login_required
def single_bill():
    if request.method == 'POST':
        bill_id = request.form['bill_id']

        if not bill_id:
            flash('Please enter a Bill ID.')
        else:
            bill = session.query(Base.classes.Bill).filter_by(Bill_id=bill_id).first()
            if bill is not None:
                return render_template('bill/single_bill.html', bill=bill)
            else:
                flash('Bill not found.')

    return render_template('bill/single_bill.html')

# # Route for listing all bill details
# @bill_blueprint.route("/all_bill_detail/")
# def all_bill_detail():
#     # Retrieving the data from the Bill table
#     bill_list = session.query(Base.classes.Bill).all()

#     # Rendering the bill data to the HTML page
#     return render_template('bill/bill_list.html', bill=bill_list)
