-- Create HR user
CREATE USER hr_admin IDENTIFIED BY hr_pwsd;
-- Grant login access to HR user
GRANT CREATE SESSION TO hr_admin;
-- Grant all DML privileges (SELECT, INSERT, UPDATE, DELETE) on all newly
created tables to HR user
GRANT ALL ON Employee TO hr_admin;
GRANT ALL ON Employee_Type TO hr_admin;
GRANT ALL ON Employee_Role TO hr_admin;
GRANT ALL ON Organization TO hr_admin;
GRANT ALL ON Address_Type TO hr_admin;
--- Create Employee user
CREATE USER employee1 IDENTIFIED BY emp1;
-- Grant login access to employee user
GRANT CREATE SESSION TO employee1;
-- Create a view to show only the current logged in employee's details
CREATE OR REPLACE VIEW employee_details AS
SELECT
 e.employee_id,
 e.employee_name,
 e.date_of_birth,
 e.date_of_joining,
 e.salary,
 e.address,
 ad.address_type AS Address_Type,
 e.home_country,
 e.work_country,
 e.gender,
 e.marital_status,
 e.ethnicity,
 et.employee_type,
 er.role_name,
 er.role_desc,
 o.org_name AS organization_name
FROM
 Employee e
JOIN
 Employee_Type et ON e.employee_type_id = et.employee_type_id
JOIN
 Employee_Role er ON e.employee_role_id = er.employee_role_id
JOIN
 Organization o ON e.organization_id = o.organization_id
LEFT JOIN
 Address_Type ad ON e.address_id = ad.address_id
WHERE
 e.employee_id = 1; -- Assuming the logged in employee's id is 1

-- Grant select privileges on the view to the employee
GRANT SELECT ON employee_details TO employee1;