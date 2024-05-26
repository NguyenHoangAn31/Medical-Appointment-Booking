import React, { useContext, useEffect, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import Spinner from '../../../../components/Spinner';
import { findScheduleByDay, updateSchedule } from '../../../../services/API/ClinicService';
import { getAllDoctorWithStatus } from '../../../../services/API/doctorService';

import { Button, Select, Tabs } from 'antd';


function ScheduleDetail() {
  const navigate = useNavigate();
  // thông báo
  const Alert = useContext(AlertContext);
  // lấy date từ url
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const date = queryParams.get("date");

  // tabs
  const [tabPosition, setTabPosition] = useState('left');

  const [schedule, setSchedule] = useState({});
  const [doctors, setDoctors] = useState([]);

  useEffect(() => {
    loadSchedule();
    loadDoctors();
  }, []);

  const loadSchedule = async () => {
    setSchedule(await findScheduleByDay(date));
  };
  const loadDoctors = async () => {
    setDoctors(await getAllDoctorWithStatus());
  };

  // assign doctor
  const handleChange = async (doctor_id, schedule_id) => {
    try {
      await updateSchedule(doctor_id, schedule_id);
      loadSchedule();
      Alert('success', 'Updating Scheudle Successfully', '')
    }
    catch (error) {
      console.log(error)
      Alert('error', 'Error Editing Scheudle', '')
    }
  };

  console.log(schedule.schedules)

  return !Object.keys(schedule).length ? (
    <Spinner />
  ) : (
    <>
      <h1>Creator</h1>
      <p>{schedule.user.email}</p>
      <p>{schedule.user.fullName}</p>
      <p>work day : {schedule.dayWorking}</p>
      <h1>List Departments</h1>
      <Tabs
        tabPosition={tabPosition}

        defaultActiveKey={schedule.schedules.length}
        centered
        items={schedule.schedules.map((deptValue, i) => {
          const id = String(i + 1);
          return {
            label: <div className='d-flex gap-3'><img src={"http://localhost:8080/images/department/" + deptValue.departmentDto.icon} width='20' />{deptValue.departmentDto.name} ({schedule.schedules[i].schedules.filter(item => item.doctorDto !== null).length}/{schedule.schedules[i].schedules.length})</div>,
            key: id,
            children: deptValue.schedules.map((scheduleValue, scheduleIndex) => (
              <div key={scheduleIndex} className='d-flex align-items-center justify-content-between' style={{ maxWidth: 600, height: 100 }}>
                <div style={{ display: 'flex', gap: '20px', alignItems: 'center' }}>
                  <span>{scheduleValue.slot.startTime} : {scheduleValue.slot.endTime} </span>
                  {scheduleValue.doctorDto ? <>
                    <img src={"http://localhost:8080/images/doctors/" + scheduleValue.doctorDto.image} alt="" style={{ width: 50, height: 50, objectFit: 'cover', borderRadius: '50%', objectPosition: 'top' }} />
                    <span>{scheduleValue.doctorDto.fullName}</span>
                  </> : null}
                </div>

                <Select
                  mode="tags"
                  style={{
                    width: '50%',
                  }}
                  placeholder="Select Doctor"
                  onBlur={(value) => {
                    handleChange(value, scheduleValue.id);
                  }} options={doctors
                    .filter(doctor => doctor.department.id == deptValue.departmentDto.id)
                    .map(doctor => ({
                      label: <div className='d-flex gap-3 align-items-center'>
                        {/* <img src={"http://localhost:8080/images/doctors/" + doctor.image} alt="" style={{ width: 50, height: 50, objectFit: 'cover', borderRadius: '50%', objectPosition: 'top', background: 'white' }} /> */}
                        <span>{doctor.fullName}</span></div>,
                      value: doctor.id
                    }))}
                />
              </div>
            )),
          };
        })}
      />
    </>

  );
}

export default ScheduleDetail