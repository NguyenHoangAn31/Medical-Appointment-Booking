import React, { useContext, useEffect, useState } from 'react'
import { useLocation } from 'react-router-dom';
import { findUserById } from '../../../../services/API/userService';
import { findDoctorByUserId, updateDoctor } from '../../../../services/API/doctorService';
import { getAllDepartment } from '../../../../services/API/departmentService';
import { Button, Input, Select, Switch, Tabs } from 'antd';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import { changeStatus } from '../../../../services/API/changeStatus';
import Spinner from '../../../../components/Spinner';

function DoctorDetail() {


  const [imageDefault, setImageDefault] = useState(false);
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

    try {
      const doctorData = await findDoctorByUserId(id);
      if (doctorData) {
        setDoctor(doctorData);
      }
    } catch (error) {
      setImageDefault(true)
    }

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
    !Object.keys(user).length != 0 ? <Spinner /> :
      <div style={{ display: 'flex', width: '90%', margin: 'auto', gap: '40px' }}>
        <div>
          {!Object.keys(doctor).length == 0 && doctor.image != null ? <img src={"http://localhost:8080/images/doctors/" + doctor.image} width="350" style={{ backgroundImage: "linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%)" }} /> : null}
          {imageDefault ? <img src="/images/login_default.jpg" width='350' /> : null}
          <div className='text-center mt-3 mx-auto' style={{ width: '85%' }}>
            <p style={{ fontSize: '33', fontWeight: '700' }}>Dr.{user.fullName}</p>
            <p>Doctor{doctor.department != null ? `of ${doctor.department.name} department` : null} at Johns Hopkins Hospital</p>
          </div>

        </div>

        <Tabs
          style={{ width: '100%' }}
          defaultActiveKey="1"
          items={[
            {
              label: 'General Information',
              key: '1',
              children: <div>
                <div className='float-end'>

                  {user.status ? <Switch
                    defaultChecked
                    onChange={() => handlechangeStatus(id, user.status)}
                  /> : <Switch
                    onChange={() => handlechangeStatus(id, user.status)}
                  />}
                </div>
                <h1 className='text-primary'>Dr.{user.fullName}</h1>

                <div className='mb-3'>
                  <label className='mb-1'>Email</label>
                  <Input value={user.email} disabled />
                </div>
                <div className='mb-3'>
                  <label className='mb-1'>Phone</label>
                  <Input value={user.phone} disabled />
                </div>

                <div className='mb-3'>
                  <label className='mb-1'>Address</label>
                  <Input value={doctor.address !== null ? doctor.address : ''} disabled />
                </div>
                <div className='mb-3'>
                  <label className='mb-1'>Birthday</label>
                  <Input value={doctor.birthday !== null ? doctor.birthday : ''} disabled />
                </div>
                <div className='mb-3'>
                  <label className='mb-1'>Gender</label>
                  <Input value={doctor.gender !== null ? doctor.gender : ''} disabled />
                </div>
                {
                  !Object.keys(doctor).length != 0 ? null :
                    <>
                      <div className='mb-3'>
                        <label className='mb-1'>Examination price</label>
                        <Input value={doctor.price} onChange={(e) => onInputChange('price', e.target.value)} required />
                      </div>

                      <div className='mb-4'>
                        <label className='mb-1'>Department </label>
                        <Select defaultValue={{
                          value: doctor.department.id,
                          label: doctor.department.name,
                        }}
                          style={{ width: '100%' }}
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
              </div>,
            },
            {
              label: 'Workings',
              key: '2',
              children: <>{!Object.keys(doctor).length != 0 ? null : <><div>
                <p><b>Biography</b> : {doctor.biography}</p>
              </div>
                <div>
                  <b>Working</b>
                  <section style={{ margin: 0, padding: 0 }}>
                    <div className="container py-3 doctor_details_page_in_admin">
                      <div className="main-timeline">
                        {doctor.workings != null ? doctor.workings.map((value, index) => (
                          <div className="timeline right" key={index}>
                            <div className="card">
                              <div className="card-body p-4">
                                <h5>{value.company}</h5>
                                <p className="mb-0">Address : {value.address}</p>
                                <p className="mb-0">Work Time : {value.startWork} to {value.endWork}</p>
                              </div>
                            </div>
                          </div>
                        )) : null}
                      </div>
                    </div>
                  </section>
                </div></>}
              </>,
            },
            {
              label: 'Qualifications',
              key: '3',
              children: <>{!Object.keys(doctor).length != 0 ? null : <><div>
                <p><b>Biography</b> : {doctor.biography}</p>
                <b>Qualifications</b>
                <section style={{ margin: 0, padding: 0 }}>
                  <div className="container py-3 doctor_details_page_in_admin">
                    <div className="main-timeline">
                      {doctor.qualifications != null ? doctor.qualifications.map((value, index) => (
                        <div className="timeline right" key={index}>
                          <div className="card">
                            <div className="card-body p-4">
                              <h5>{value.degreeName}</h5>
                              <p className="mb-0">University : {value.universityName}</p>
                              <p className="mb-0">Course : {value.course}</p>
                            </div>
                          </div>
                        </div>
                      )) : null}
                    </div>
                  </div>
                </section>
              </div>
              </>}
              </>,
            }

          ]}
        />



      </div>


  )
}

export default DoctorDetail