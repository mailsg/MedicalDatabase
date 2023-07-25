/* patients table */

CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);
 
/* medical_histories table */

 CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(255)
);

/* invoices table */

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    generated_at TIMESTAMP,
    paid_at TIMESTAMP,
    medical_history_id INT REFERENCES medical_histories(id)
);

/* treatments table */

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);

/* invoice_items table */

CREATE TABLE invoice_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10, 2),
    quantity INT,
    total_price DECIMAL(10, 2),
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
   
);


/* Join Table 'treatment_histories' */

CREATE TABLE treatments_histories (
  treatment_id INT REFERENCES treatments (id),
  medical_histories_id INT REFERENCES medical_histories (id),
  PRIMARY KEY (treatment_id, medical_histories_id)
);


/*  FK indexes */

-- Index for medical_histories_id in treatments_histories table
CREATE INDEX index_treatments_histories_medical_histories_id
ON treatment_histories (medical_histories_id);

-- Index for treatment_id in treatment_histories table
CREATE INDEX index_treatment_histories_treatment_id
ON treatment_histories (treatment_id);

-- Index for medical_history_id in invoices table
CREATE UNIQUE INDEX index_invoices_medical_history_id
ON invoices (medical_history_id);

-- Index for patient_id in medical_histories table
CREATE INDEX index_medical_histories_patient_id
ON medical_histories (patient_id);

-- Index for invoice_id in invoices_items table
CREATE INDEX index_invoice_items_invoice_id
ON invoice_items (invoice_id);

-- Index for treatment_id in invoice_items table
CREATE INDEX index_invoice_items_treatment_id
ON invoice_items (treatment_id);
Collapse