import { Content } from 'antd/es/layout/layout'
import React, { useContext, useEffect, useState } from 'react'
import { UserContext } from '../../components/Layouts/Client';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const Account = () => {
  const { currentUser } = useContext(UserContext);
  const [patient, setPatient] = useState(null);
  const [error, setError] = useState(null);
  console.log(patient)
  useEffect(() => {
    fechDataPatient();
  }, []);
  const fechDataPatient = async () => {
    try {
      if (currentUser?.user.id) {
        const response = await axios.get(`http://localhost:8080/api/patient/${currentUser?.user.id}`);
        setPatient(response.data);
      } else {
        setError("No current user found");
      }
    } catch (error) {
      setError("Failed to fetch patient data");
    }
  }
  return (
    <div>
      {patient ? (
        <div>
          <h1>Account</h1>
          <p>Name: {patient.fullName}</p>
          <p>Email: {patient.email}</p>
          <p>Phone: {patient.phone}</p>
          <p>Address: {patient.address}</p>
        </div>
      ) : (
        <div>
          <h1>Account</h1>
          Bạn chưa có thông tin account
        </div>
      )}
    </div>
  )
}

export default Account;
