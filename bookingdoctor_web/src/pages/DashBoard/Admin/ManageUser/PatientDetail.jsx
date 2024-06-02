import React, { useEffect, useState } from 'react'
import { useLocation } from 'react-router-dom';
import { getPatientByUserId } from '../../../../services/API/patientService';
import { findUserById } from '../../../../services/API/userService';

function PatientDetail() {
  
  const [user, setUser] = useState({});
  const [patient, setPatient] = useState({});
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const id = queryParams.get("id");

  useEffect(() => {
    loadUser();
    loadPatient();
  }, []);

  const loadUser = async () => {
    setUser(await findUserById(id));
  };
  const loadPatient = async () => {
    setPatient(await getPatientByUserId(id));
  };

  console.log("user : " , user)
  console.log("patient : " , patient)
  console.log("id : ",id)
  return (
    <>
      <h1>Profile</h1>
      <p>Email : {user.email}</p>
      <p>Phone : {user.phone}</p>
      <p>Full Name : {user.fullName}</p>
    </>


  )
}

export default PatientDetail