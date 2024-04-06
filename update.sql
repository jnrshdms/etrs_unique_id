-- etrs_final
SELECT
  etrs_training_record.employee_num,
  etrs_training_record.provider,
  etrs_training_record.unique_id,
  etrs_final.emp_id,
  etrs_final.sp_id,
  etrs_final.unique_id
FROM
  etrs_training_record
INNER JOIN
  etrs_final ON etrs_training_record.employee_num = etrs_final.emp_id
              AND etrs_training_record.provider = etrs_final.sp_id
              AND etrs_training_record.unique_id = etrs_final.unique_id;


ALTER TABLE etrs_final utf8mb4_general_ci	
ADD COLUMN unique_id VARCHAR(50);


-- etrs_final_practice
SELECT
  etrs_training_record.employee_num,
  etrs_training_record.provider,
  etrs_training_record.unique_id,
  etrs_final_practice.emp_id,
  etrs_final_practice.sp_id,
  etrs_final_practice.unique_id
FROM
  etrs_training_record
INNER JOIN
  etrs_final_practice ON etrs_training_record.employee_num = etrs_final_practice.emp_id
              AND etrs_training_record.provider = etrs_final_practice.sp_id
              AND etrs_training_record.unique_id = etrs_final_practice.unique_id;

ALTER TABLE etrs_final_practice
ADD COLUMN unique_id VARCHAR(50);

-- etrs_initial
SELECT
  etrs_training_record.employee_num,
  etrs_training_record.provider,
  etrs_training_record.unique_id,
  etrs_initial.emp_id,
  etrs_initial.sp_id,
  etrs_initial.unique_id
FROM
  etrs_training_record
INNER JOIN
  etrs_initial ON etrs_training_record.employee_num = etrs_initial.emp_id
              AND etrs_training_record.provider = etrs_initial.sp_id
              AND etrs_training_record.unique_id = etrs_initial.unique_id;

ALTER TABLE etrs_initial
ADD COLUMN unique_id VARCHAR(50);


-- inner join etrs_initial_practice
SELECT
  etrs_training_record.employee_num,
  etrs_training_record.provider,
  etrs_training_record.unique_id,
  etrs_initial_practice.emp_id,
  etrs_initial_practice.sp_id,
  etrs_initial_practice.unique_id
FROM
  etrs_training_record
INNER JOIN
  etrs_initial_practice ON etrs_training_record.employee_num = etrs_initial_practice.emp_id
              AND etrs_training_record.provider = etrs_initial_practice.sp_id
              AND etrs_training_record.unique_id = etrs_initial_practice.unique_id;

ALTER TABLE etrs_initial_practice
ADD COLUMN unique_id VARCHAR(50);



--  Query for unique_id is null
SELECT * FROM `etrs_training_record` WHERE unique_id IS NULL;
SELECT * FROM `etrs_final` WHERE unique_id IS NULL;
SELECT * FROM `etrs_final_practice` WHERE unique_id IS NULL;
SELECT * FROM `etrs_initial` WHERE unique_id IS NULL;
SELECT * FROM `etrs_initial_practice` WHERE unique_id IS NULL;

-- Query for update table 
UPDATE etrs_final
LEFT JOIN etrs_training_record ON etrs_training_record.employee_num = etrs_final.emp_id
                               AND etrs_training_record.provider = etrs_final.sp_id
                               SET etrs_final.unique_id = etrs_training_record.unique_id;

UPDATE etrs_final_practice
LEFT JOIN  etrs_training_record ON etrs_training_record.employee_num = etrs_final_practice.emp_id
                               AND etrs_training_record.provider = etrs_final_practice.sp_id
                               SET etrs_final_practice.unique_id = etrs_training_record.unique_id;

UPDATE etrs_initial
LEFT JOIN  etrs_training_record ON etrs_training_record.employee_num = etrs_initial.emp_id
                               AND etrs_training_record.provider = etrs_initial.sp_id
                               SET etrs_initial.unique_id = etrs_training_record.unique_id;

UPDATE etrs_initial_practice
LEFT JOIN  etrs_training_record ON etrs_training_record.employee_num = etrs_initial_practice.emp_id
                               AND etrs_training_record.provider = etrs_initial_practice.sp_id
                               SET etrs_initial_practice.unique_id = etrs_training_record.unique_id;

--  Query for emp_id is null and sp_id is null
SELECT * FROM `etrs_final` WHERE emp_id IS NULL ADD sp_id IS NULL;
SELECT * FROM `etrs_final_practice` WHERE unique_id IS NULL;
SELECT * FROM `etrs_initial` WHERE unique_id IS NULL;
SELECT * FROM `etrs_initial_practice` WHERE unique_id IS NULL;


SELECT * FROM `etrs_training_record` WHERE employee_num  ='N/A' AND provider = 'N/A';
--  THE RESULT employee_num = UNKOWN #
SELECT * FROM `etrs_final` WHERE emp_id = 'N/A' AND sp_id= 'N/A';
SELECT * FROM `etrs_final_practice` WHERE  emp_id  = 'N/A' AND  sp_id = 'N/A';
SELECT * FROM `etrs_initial` WHERE  emp_id  = 'N/A' AND  sp_id = 'N/A';
SELECT * FROM `etrs_initial_practice` WHERE  emp_id  = 'N/A' AND  sp_id = 'N/A';
--  THE RESULT IS DELETED


SELECT *, COUNT(*) AS DUPLICATE FROM `etrs_initial` GROUP BY emp_id, sp_id, initial_process, initial_remarks, initial_status HAVING COUNT(*) > 1
SELECT *, COUNT(*) AS DUPLICATE FROM `etrs_final` GROUP BY emp_id, sp_id, final_process, final_remarks, final_status HAVING COUNT(*) > 1