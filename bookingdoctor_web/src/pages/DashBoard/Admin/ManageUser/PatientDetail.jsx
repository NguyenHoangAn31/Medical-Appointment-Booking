import React, { useContext, useEffect, useState } from 'react'
import { useLocation } from 'react-router-dom';
import { getPatientByUserId } from '../../../../services/API/patientService';
import { findUserById } from '../../../../services/API/userService';
import { Switch } from 'antd';
import { changeStatus } from '../../../../services/API/changeStatus';
import { AlertContext } from '../../../../components/Layouts/DashBoard';

function PatientDetail() {

  const [user, setUser] = useState({});
  const [patient, setPatient] = useState({});
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const { openNotificationWithIcon } = useContext(AlertContext);
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

  const handlechangeStatus = async (id, status) => {
    try {
      await changeStatus('user', id, status);
      openNotificationWithIcon('success', 'Change Status Patient Successfully', '')
      loadUser();
    } catch (error) {
      openNotificationWithIcon('error', 'Something Went Wrong', '')
      console.log(error)
    }

  };

  console.log(patient.image)
  return (
    !Object.keys(user).length != 0 ? null : <>
      <div>
        <>
          {user.status ? <Switch
            defaultChecked
            onChange={() => handlechangeStatus(id, user.status)}
          /> : <Switch
            onChange={() => handlechangeStatus(id, user.status)}
          />}
        </>
      </div>
      
      <h1>Profile</h1>
      {patient.image!=null?<img src={"http://localhost:8080/images/patients/" + patient.image} width="150"/>:null}

      <p>Email : {user.email}</p>
      <p>Phone : {user.phone}</p>
      <p>Full Name : {user.fullName}</p>
      {
        !Object.keys(patient).length != 0 ? null :
          <div>
            <p>Address : {patient.address}</p>
            <p>Birthday : {patient.birthday}</p>
            <div>
              Medicals :
              {patient.medicals.map((value, index) => (
                <div key={index}>
                  <p>{value.name}</p>
                  <p>{value.content}</p>
                </div>
              ))}
            </div>
          </div>
      }
    </>
  )
}

export default PatientDetail