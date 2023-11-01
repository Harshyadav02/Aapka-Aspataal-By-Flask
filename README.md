
# Aapka Aspatal

## 1. Introduction

Aapka Aspatal is a Hospital Management System. This system performs some basic opertions like 

    1. Add Patient 
    2. Delete Patient 
    3. Update Patient
    4. Add Doctor 
    5. Update Doctor  and many more ...  

There are also  key feature like **authencation**  and **autherization**  in the application.

## 2. Technology

The technology used in this project :-
#### 2.1 Frontend   
- HTML
- CSS
- JavaScript

#### 2.2 Backend
- Python
- Flask
- SQLAlchemy


## 3. Installation 

Simply clone the git repository to your desired location by the below command.

    git clone https://github.com/Harshyadav02/Aapaka-Aspataal 

Now navigate to the **Aapaka-Aspataal** directory  by

    cd Apaka-Aspataal 
Run the following command for installation of all  the packages and libaries required for the project.

    pip install -r requirement.txt  

## 4.  Runing the Application 

To run the application just run the init.py file by

    flask --app init.py run

This will start the Flask development server, and you can access the Aapka Aspatal application in your web browser at http://localhost:5000.

## 5. Project Structure 

Here's an overview of the project's directory structure:

- init.py : The main file of the project 
- auth.py : file which contain **authorization** and **authentication** 
- view.py : This file contain Patient related views
- Doctor_views.py : This file contain Doctor related views 
- Medicine_views.py : This file contain Medicine related views
- ward_views.py : This file contain ward related views
- Bill_views.py : This file contain Bill related views
- db.py : This file contain database related confrigation for the project 
- models.py : This file contain models

##### Directory 
- Templates : This directory contain all the HTML files
- static : This directory contain CSS, IMAGES and JavaScript file








