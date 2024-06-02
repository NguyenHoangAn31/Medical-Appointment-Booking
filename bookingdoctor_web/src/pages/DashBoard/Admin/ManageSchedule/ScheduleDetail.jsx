import React, { useContext, useEffect, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import Spinner from '../../../../components/Spinner';
import { getAllDoctorWithStatus } from '../../../../services/API/doctorService';

import { Button, Select, Space, Tabs } from 'antd';
import { findScheduleByDay, updateScheduleForAdmin } from '../../../../services/API/scheduleService';


function ScheduleDetail() {

  // thông báo
  const {openNotificationWithIcon} = useContext(AlertContext);
  // lấy date từ url
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const day = queryParams.get("day");
  const status = queryParams.get("status")


  // tabs
  const [tabPosition, setTabPosition] = useState('left');

  const [clinic, setClinic] = useState({});
  const [doctors, setDoctors] = useState([]);

  useEffect(() => {
    loadClinic();
    loadDoctors();
  }, []);

  const loadClinic = async () => {
    setClinic(await findScheduleByDay(day));
  };
  const loadDoctors = async () => {
    var doctorList = await getAllDoctorWithStatus();
    doctorList
      .forEach(doctor => {
        doctor.value = doctor.id;
        doctor.label = doctor.fullName
      })
    setDoctors(doctorList);
  };

  const handleChange = async (departmentId, slotId, value) => {
    try {
      await updateScheduleForAdmin(day, departmentId, slotId, value)
      loadClinic()
      openNotificationWithIcon('success', 'Update Schedule Successfully', '')

    } catch (error) {
      console.log(error)
      openNotificationWithIcon('error', 'Error Update Schedule', '')

    }

  };




  return !Object.keys(clinic).length != 0 ? (
    <Spinner />
  ) : (
    <>
      <h1 className='mb-5'>Work Day : {day} - {status == 1 ? <span className='text-success'>Active</span> : <span className='text-danger'>Finished</span>}</h1>
      <Tabs
        tabPosition={tabPosition}
        defaultActiveKey={null}
        centered
        items={clinic.departments.map((deptValue, i) => {
          const id = String(i + 1);
          return {
            label: <div className='d-flex gap-3'><img src={"http://localhost:8080/images/department/" + deptValue.icon} width='20' />{deptValue.name}   </div>,
            key: id,
            children: deptValue.slots.map((slot, slotIndex) => (
              <div key={slotIndex} className='d-flex align-items-center justify-content-between' style={{ maxWidth: 800 }}>
                <div style={{ display: 'flex', gap: '20px', alignItems: 'center' }}>
                  <span>{slot.startTime} : {slot.endTime} </span>
                  {slot.doctorsForSchedules ? <>
                    {slot.doctorsForSchedules.map((doctor, doctorIndex) => (
                      <div key={doctorIndex}>
                        <img src={"http://localhost:8080/images/doctors/" + doctor.image} alt="" style={{ width: 50, height: 50, objectFit: 'cover', borderRadius: '50%', objectPosition: 'top' }} />
                      </div>
                    ))}
                  </> : null}
                </div>

                <Select
                  disabled={status != 1}
                  mode="multiple"
                  style={{ width: '50%' }}
                  placeholder="select doctor"
                  defaultValue={slot.doctorsForSchedules.map(doctor => doctor.id)}
                  onChange={(value) => handleChange(deptValue.id, slot.slotId, value)}
                  options={doctors.filter(doctor => doctor.department.id == deptValue.id)}
                  optionRender={(option) => (
                    <Space>
                      <span role="img" aria-label={option.data.fullName}>
                      <img src={"http://localhost:8080/images/doctors/" + option.data.image} alt="" style={{ width: 30, height: 30, objectFit: 'cover', borderRadius: '50%', objectPosition: 'top' }} />
                        {option.data.fullName}
                      </span>
                      {option.data.birthday}
                    </Space>
                  )}
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