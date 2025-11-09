// ===================== HOSPITAL DATABASE SETUP =====================
use hospital_db

// ======================= INSERT OPERATIONS =======================

// Insert one patient
db.patients.insertOne({
  patient_id: 201,
  name: "Ravi Mehta",
  age: 45,
  gender: "Male",
  contact: "9876543210",
  city: "Pune",
  disease: "Diabetes",
  admitted: true,
  room_no: 301,
  doctor_assigned: "Dr. Sharma",
  bill_amount: 15000,
  admitted_date: new Date("2025-11-01"),
  discharge_date: null,
  medicines: ["Metformin", "Insulin"],
  emergency_contact: { name: "Priya Mehta", relation: "Wife", phone: "9812345678" }
});

// Insert multiple patients
db.patients.insertMany([
  {
    patient_id: 202,
    name: "Aditi Rao",
    age: 30,
    gender: "Female",
    contact: "9988776655",
    city: "Bangalore",
    disease: "Fever",
    admitted: false,
    doctor_assigned: "Dr. Kapoor",
    bill_amount: 2500,
    medicines: ["Paracetamol", "Vitamin C"],
    emergency_contact: { name: "Rohan Rao", relation: "Brother", phone: "9000000001" }
  },
  {
    patient_id: 203,
    name: "Suresh Kumar",
    age: 60,
    gender: "Male",
    contact: "9123456789",
    city: "Delhi",
    disease: "Heart Disease",
    admitted: true,
    room_no: 205,
    doctor_assigned: "Dr. Verma",
    bill_amount: 45000,
    admitted_date: new Date("2025-10-28"),
    discharge_date: null,
    medicines: ["Aspirin", "Atorvastatin"],
    emergency_contact: { name: "Neha Kumar", relation: "Daughter", phone: "9812312345" }
  },
  {
    patient_id: 204,
    name: "Ananya Sharma",
    age: 25,
    gender: "Female",
    contact: "9991122334",
    city: "Mumbai",
    disease: "Migraine",
    admitted: false,
    doctor_assigned: "Dr. Nair",
    bill_amount: 1200,
    medicines: ["Sumatriptan"],
    emergency_contact: { name: "Raj Sharma", relation: "Father", phone: "9876500000" }
  },
  {
    patient_id: 205,
    name: "Aman Yadav",
    age: 38,
    gender: "Male",
    contact: "9090909090",
    city: "Lucknow",
    disease: "Asthma",
    admitted: true,
    room_no: 407,
    doctor_assigned: "Dr. Gupta",
    bill_amount: 22000,
    admitted_date: new Date("2025-11-05"),
    discharge_date: null,
    medicines: ["Inhaler", "Montelukast"],
    emergency_contact: { name: "Pooja Yadav", relation: "Wife", phone: "9911223344" }
  }
]);

// ======================= READ OPERATIONS =======================

// Find all patients
db.patients.find();

// Find one patient
db.patients.findOne();

// Show only name and disease (hide _id)
db.patients.find({}, { _id: 0, name: 1, disease: 1 });

// Find patients currently admitted
db.patients.find({ admitted: true });

// Find patients from Delhi
db.patients.find({ city: "Delhi" });

// ======================= UPDATE OPERATIONS =======================

// Update bill amount for a patient
db.patients.updateOne(
  { patient_id: 203 },
  { $set: { bill_amount: 47000 } }
);

// Add a new medicine to a patient
db.patients.updateOne(
  { patient_id: 205 },
  { $push: { medicines: "Salbutamol" } }
);

// Remove a medicine
db.patients.updateOne(
  { patient_id: 204 },
  { $pull: { medicines: "Sumatriptan" } }
);

// Update many patients – add hospital name
db.patients.updateMany({}, { $set: { hospital_name: "CityCare Hospital" } });

// Remove a field (example: discharge_date)
db.patients.updateOne(
  { patient_id: 202 },
  { $unset: { discharge_date: "" } }
);

// Upsert (insert if not exists)
db.patients.updateOne(
  { patient_id: 206 },
  {
    $set: {
      name: "Kiran Das",
      age: 50,
      gender: "Female",
      city: "Kolkata",
      disease: "Arthritis",
      admitted: false,
      doctor_assigned: "Dr. Sinha",
      bill_amount: 3500
    }
  },
  { upsert: true }
);

// ======================= DELETE OPERATIONS =======================

// Delete one patient record
db.patients.deleteOne({ patient_id: 204 });

// Delete all discharged patients
db.patients.deleteMany({ admitted: false });

// Delete all records (if needed)
// db.patients.deleteMany({});

// ======================= AGGREGATION OPERATIONS =======================

// Group by city – count patients
db.patients.aggregate([
  {
    $group: {
      _id: "$city",
      total_patients: { $sum: 1 }
    }
  }
]);

// Average bill amount by doctor
db.patients.aggregate([
  {
    $group: {
      _id: "$doctor_assigned",
      avg_bill: { $avg: "$bill_amount" }
    }
  }
]);

// Group by gender – count
db.patients.aggregate([
  {
    $group: {
      _id: "$gender",
      total: { $sum: 1 }
    }
  }
]);

// Top 3 patients with highest bill amount
db.patients.aggregate([
  { $sort: { bill_amount: -1 } },
  { $limit: 3 },
  { $project: { _id: 0, name: 1, disease: 1, bill_amount: 1 } }
]);
