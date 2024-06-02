import React, { useEffect, useState } from 'react'
import { useLocation } from 'react-router-dom';
import { findUserById } from '../../../../services/API/userService';
import { findDoctorByUserId } from '../../../../services/API/doctorService';

function DoctorDetail() {


  const [user, setUser] = useState({});
  const [doctor, setDoctor] = useState({});
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const id = queryParams.get("id");

  useEffect(() => {
    loadUser();
    loadDoctor();
  }, []);

  const loadUser = async () => {
    setUser(await findUserById(id));
  };
  const loadDoctor = async () => {
    setDoctor(await findDoctorByUserId(id));
  };

  console.log("user : " , user)
  console.log("doctor : " , doctor)
  return (
    <>
      <h1>Profile</h1>
      <p>Email : {user.email}</p>
      <p>Phone : {user.phone}</p>
      <p>Full Name : {user.fullName}</p>
    </>


  )
}

export default DoctorDetail