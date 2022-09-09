BEGIN TRANSACTION;

-- Table: employee
CREATE TABLE employee (
    employee_id INTEGER   PRIMARY KEY AUTOINCREMENT,
    name        CHAR (50) NOT NULL,
    surename    CHAR (50) NOT NULL,
    birth_date  DATE      NOT NULL
);


-- Table: employee_position
CREATE TABLE employee_position (
    employee_position_id INTEGER   PRIMARY KEY AUTOINCREMENT,
    title                CHAR (30) NOT NULL,
    employee_id          INTEGER   REFERENCES employee (employee_id) 
                                   NOT NULL
);


-- Table: project
CREATE TABLE project (
    project_id        INTEGER   PRIMARY KEY AUTOINCREMENT,
    name              CHAR (40) NOT NULL
                                UNIQUE,
    date_of_creation  DATE      NOT NULL,
    date_of_closure   DATE      NOT NULL,
    project_status_id INTEGER   REFERENCES project_status (project_status_id) 
                                NOT NULL,
    employee_position INTEGER   REFERENCES employee_position (employee_position_id) 
                                NOT NULL
);


-- Table: project_status
CREATE TABLE project_status (
    project_status_id INTEGER  PRIMARY KEY AUTOINCREMENT,
    status            CHAR (6) NOT NULL
);


-- Table: project_task
CREATE TABLE project_task (
    task_id    INTEGER REFERENCES task (task_id) 
                       NOT NULL,
    project_id INTEGER REFERENCES project (project_id) 
                       NOT NULL
);


-- Table: task
CREATE TABLE task (
    task_id            INTEGER PRIMARY KEY AUTOINCREMENT,
    deadline           DATE    NOT NULL,
    task_status_set_id INTEGER REFERENCES task_status_set (task_status_set_id) 
                               NOT NULL
);


-- Table: task_status
CREATE TABLE task_status (
    task_status_id INTEGER   PRIMARY KEY AUTOINCREMENT,
    status         CHAR (20) NOT NULL
                             UNIQUE
);


-- Table: task_status_set
CREATE TABLE task_status_set (
    task_status_set_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date               DATE    NOT NULL,
    task_status_id     INTEGER REFERENCES task_status (task_status_id) 
                               NOT NULL,
    employee_id        INTEGER REFERENCES employee (employee_id) 
                               NOT NULL
);


COMMIT TRANSACTION;
