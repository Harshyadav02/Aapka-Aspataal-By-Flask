
# Aapka Aspatal

## 1. Introduction

Aapka Aspatal is a Hospital Management System. This system performs some basic operations like: 

    1. Add Patient 
    2. Delete Patient 
    3. Update Patient
    4. Add Doctor 
    5. Update Doctor and many more ...  

The application also has key features like **authentication** and **authorization**.

## 2. Technology

The technology used in this project:
#### 2.1 Frontend   
- HTML
- CSS
- JavaScript

#### 2.2 Backend
- Python
- Flask
- SQLAlchemy

## 3. Prerequisites

Before the installation of the application, you must have the following dependencies installed on your system:

- Python(3.x)
- Git
## 4. Installation 

Clone the git repository to your desired location by the below command.

    git clone https://github.com/Harshyadav02/Aapka-Aspataal 

Now navigate to the **Aapaka-Aspataal** directory by

    cd Aapka-Aspataal 
Run the following command to install all the packages and libraries required for the project. Make sure you have activated the [virtual environment](https://docs.python.org/3/library/venv.html).

    pip install -r requirement.txt  

## 5. Importing the .sql file to our database.

Login to your MySQL server. Create a new database named `HOSPITAL`. Now run the following command

    source /path/to/Aapaka-Aspataal/BILLING.sql

## 6. Changing the credentials.

Open `init.py` and `db.py`  and change your `username` and `password` to your actual username and password.

## 7. Running the Application 

To run the application just run the init.py file by:

    flask --app init.py run

This will start the Flask development server, and you can access the Aapka Aspatal application in your web browser at http://localhost:5000.

## 8. Project Structure 

Here's an overview of the application directory structure:

- `init.py`: The main file of the project. 
- `auth.py`: file which contains **authorization** and **authentication**.  
- `view.py`: This file contains Patient related views. 
- `doctor_views.py`: This file contains Doctor related views.  
- `medicine_views.py`: This file contains Medicine related views. 
- `ward_views.py`: This file contains ward-related views. 
- `bill_views.py`: This file contains Bill related views. 
- `db.py`: This file contains database-related configuration for the project.   
- `models.py`: This file contains models.
  
##### Directory 
- `templates`: This directory contains all the HTML files.
- `static`: This directory contains CSS, JavaScript, and image files.
