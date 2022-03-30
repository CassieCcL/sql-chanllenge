-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
DROP TABLE "dept_emp";
DROP TABLE "dept_manager";
DROP TABLE "departments";
DROP TABLE "salaries";
DROP TABLE "employees";
DROP TABLE "titles";


CREATE TABLE "departments" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(30)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_ID" VARCHAR(30)   NOT NULL,
    "birth_date" VARCHAR(30)   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" VARCHAR(30)   NOT NULL,
    "hire_date" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" FLOAT   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(30)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(30)   NOT NULL,
    "emp_no" INT   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_ID" FOREIGN KEY("emp_title_ID")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT employees.emp_no
		,first_name
		,last_name
		,sex
		,salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;


--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name
		,last_name
		,hire_date
FROM employees
WHERE hire_date like '%1986';


--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT employees.first_name
		,employees.last_name
		,employees.emp_no
		,departments.dept_no
		,departments.dept_name
FROM dept_manager
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN employees
on employees.emp_no = dept_manager.emp_no;


--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT employees.first_name
		,employees.last_name
		,employees.emp_no
		,departments.dept_name
FROM dept_emp
JOIN employees
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;


--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name
		,last_name
		,sex
FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';


--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT employees.first_name
		,employees.last_name
		,employees.emp_no
		,departments.dept_name
FROM dept_emp
JOIN employees
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT employees.first_name
		,employees.last_name
		,employees.emp_no
		,departments.dept_name
FROM dept_emp
JOIN employees
ON employees.emp_no = dept_emp.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Developments';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name
		,count(last_name) as "Counts"
FROM employees
GROUP BY last_name
ORDER BY "Counts" DESC;

SELECT first_name
		,last_name
FROM employees
WHERE emp_no = '499942'
		
		
		