# Predicting Patient No-Shows to Improve Outpatient Clinic Utilization | SQL Healthcare Analytics Project

## Executive Summary
Missed medical appointments create significant operational and financial challenges for healthcare systems. 
This project analyzes 110,000+ outpatient appointments using SQL to identify drivers of patient no-shows and develop a risk segmentation framework to support proactive scheduling interventions.
The analysis simulates a real healthcare analytics engagement focused on improving clinic utilization, reducing lost revenue, and enhancing patient access to care.

## Business Problem
Healthcare organizations frequently experience high patient no-show rates, resulting in underutilized providers, delayed care delivery, and lost reimbursement revenue.
Clinic leadership needs data-driven insight into which patients are most likely to miss appointments so that targeted operational interventions can be implemented.

## Stakeholder Perspective 
The Director of Ambulatory Operations is responsible for ensuring that outpatient clinics run efficiently, patients receive timely care, and clinic resources are fully utilized. 
High no-show rates reduce provider productivity, delay patient treatment, and decrease revenue. 
This analysis provides actionable insights into which patients are most likely to miss appointments, enabling the stakeholder to implement targeted interventions to improve attendance and operational performance.

## Key Performance Indicators (KPIs)
**Primary KPI:** Appointment No-Show Rate  
- Formula: No-Show Rate = Missed Appointments / Total Scheduled Appointments  
- Baseline (dataset): ~20%  
- Target (industry benchmark): ≤15%  
- Operational impact: A reduction in no-shows directly improves provider utilization, clinic workflow efficiency, and revenue capture.  

**Supporting KPIs:**  
- **Average Lead Time:** Number of days between scheduling and appointment (`lead_time_days`). Longer lead times are associated with higher no-show risk.  
- **Prior Patient Attendance Rate:** Measures patient reliability based on historical behavior. Calculated as `1 - (prior_no_shows / prior_appointments)`.  
- **SMS Reminder Effectiveness:** Compares no-show rates between patients who received reminders (`SMS_received = 1`) and those who did not.  
- **Chronic Condition Attendance:** Tracks whether patients with chronic conditions (Hypertension, Diabetes, etc) show up more reliably, informing patient engagement strategies.  

**Estimated Financial Impact:**  
Assumptions:  
- Average reimbursement per outpatient visit: $150  
- Total annual appointments (scaled from dataset): 50,000  
- Potential reduction in no-show rate: 5%

## Dataset Overview & SQL Data Model

**Dataset:** Medical Appointment No-Shows (Kaggle)  
- 110,000+ outpatient appointments  
- 14 patient- and appointment-level variables  

**Key Fields:**

| Column        | Description                                      |
|---------------|--------------------------------------------------|
| PatientId     | Unique patient identifier                        |
| AppointmentID | Unique appointment/encounter identifier         |
| Gender        | Male or Female                                   |
| ScheduledDay  | Date the appointment was scheduled              |
| AppointmentDay| Date of the scheduled appointment               |
| Age           | Patient age in years                             |
| Neighbourhood | Clinic location                                  |
| Scholarship   | Socioeconomic support indicator (Bolsa Família) |
| Hypertension  | Chronic condition flag                           |
| Diabetes      | Chronic condition flag                           |
| Alcoholism    | Behavioral health flag                           |
| Handcap       | Disability flag                                  |
| SMS_received  | Number of appointment reminders sent            |
| No-show       | Outcome: whether patient attended or not        |

**SQL Data Model Approach:**
- Created a staging table to load raw CSV data
- Performed data cleaning and type conversions:
  - Converted dates to TIMESTAMP
  - Created a binary flag for `no_show` (1 = no-show, 0 = attended)
  - Filtered out invalid ages (<0)
- Engineered operational features:
  - `lead_time_days` = days between scheduling and appointment
  - `appointment_weekday` = day of the week of appointment
  - `prior_no_shows` = cumulative count of prior missed appointments per patient (calculated using SQL window function)
  - `chronic_condition_count` = sum of Hypertension, Diabetes, Handcap

## Key Findings & Recommendations
*(Insights will be added after SQL analysis is complete. This section will summarize high-risk patient segments, operational patterns, and actionable recommendations for clinic leadership.)*
