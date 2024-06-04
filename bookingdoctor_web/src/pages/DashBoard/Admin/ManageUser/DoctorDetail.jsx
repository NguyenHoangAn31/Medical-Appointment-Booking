import React, { useContext, useEffect, useState } from 'react'
import { useLocation } from 'react-router-dom';
import { findUserById } from '../../../../services/API/userService';
import { findDoctorByUserId, updateDoctor } from '../../../../services/API/doctorService';
import { getAllDepartment } from '../../../../services/API/departmentService';
import { Button, Input, Select, Switch } from 'antd';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import { changeStatus } from '../../../../services/API/changeStatus';

function DoctorDetail() {


  const [user, setUser] = useState({});
  const [doctor, setDoctor] = useState({});
  const [department, setDepartment] = useState([]);
  const [departmentId, setDepartmentId] = useState(0);
  const [price, setPrice] = useState();
  const { openNotificationWithIcon } = useContext(AlertContext);


  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const id = queryParams.get("id");

  useEffect(() => {
    loadUser();
    loadDoctorAndDepartment();
  }, []);

  const loadUser = async () => {
    setUser(await findUserById(id));
  };
  const loadDoctorAndDepartment = async () => {
    setDoctor(await findDoctorByUserId(id));
    setDepartment(await getAllDepartment());

  };

  const onInputChange = (name, value) => {
    if (name == 'price') {
      setDoctor({ ...doctor, [name]: value });
      setPrice(value)
    }
    else {
      setDepartmentId(value)
    }
  };

  const handleSubmit = async () => {
    try {
      if (price != null || departmentId != 0) {
        await updateDoctor(doctor.id, doctor.price, departmentId)
        openNotificationWithIcon('success', 'Editing Doctor Successfully', '')
      }

    } catch (error) {
      console.log(error)
    }
  }


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


  return (
    !Object.keys(user).length != 0 ? null :
      <>
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
        {doctor.image!=null?<img src={"http://localhost:8080/images/doctors/" + doctor.image} width="150"/>:null}

        <p>Email : {user.email}</p>
        <p>Phone : {user.phone}</p>
        <p>Full Name : {user.fullName}</p>
        {
          !Object.keys(doctor).length != 0 ? null :
            <>
              <p>Address : {doctor.address}</p>
              <p>Biography : {doctor.biography}</p>
              <p>Birthday : {doctor.birthday}</p>
              <p>Gender : {doctor.gender}</p>
              <div>
                Qualifications :
                {doctor.qualifications.map((value, index) => (
                  <div key={index}>
                    <p>{value.degreeName}</p>
                    <p>{value.universityName}</p>
                    <p>{value.course}</p>

                  </div>

                ))}
              </div>
              <div>
                <label htmlFor="">Examination price : </label>
                <input value={doctor.price} onChange={(e) => onInputChange('price', e.target.value)} required />
              </div>
              <div>
                <label htmlFor="">Departmnt :</label>
                <Select defaultValue={{
                  value: doctor.department.id,
                  label: doctor.department.name,
                }}
                  style={{
                    width: 180,
                  }}
                  placeholder="Select Department" onChange={(e) => onInputChange('department', e)} >
                  {department.map((value, index) => {
                    return (
                      <Select.Option key={index} value={value.id}>{value.name}</Select.Option>
                    )
                  })}
                </Select>
              </div>
              <div>
                <Button type="primary" className='float-end' onClick={handleSubmit}>Update</Button>
              </div>
            </>
        }
      </>


  )
}

export default DoctorDetail