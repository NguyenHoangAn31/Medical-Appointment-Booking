import React, { useContext, useEffect, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import Spinner from '../../../../components/Spinner';
import { findScheduleByDay } from '../../../../services/API/ClinicService';
import { Button } from 'antd';


function ScheduleDetail() {
  const navigate = useNavigate();
  // thông báo
  const Alert = useContext(AlertContext);
  // lấy id từ url
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const date = queryParams.get("date");


  const [schedule, setSchedule] = useState({});
  const [doctor, setDoctor] = useState([]);

  useEffect(() => {
    loadSchedule();
  }, []);


  const loadSchedule = async () => {
    setSchedule(await findScheduleByDay(date));
  };


  console.log(schedule)

  // const groupedSchedules = schedule.schedules.reduce((acc, value) => {
  //   if (!acc[value.department_id]) {
  //     acc[value.department_id] = [];
  //   }
  //   acc[value.department_id].push(value);
  //   return acc;
  // }, {});


  // const groupedSchedules = schedule.schedules.reduce((acc, { department_id, ...rest }) => {
  //   (acc[department_id] ||= []).push(rest);
  //   return acc;
  // }, {});

  return !Object.keys(schedule).length ? (
    <Spinner />
  ) : (
    <>
      <h1>Creator</h1>
      <p>{schedule.user.email}</p>
      <p>{schedule.user.fullName}</p>
      <h1>List Departments</h1>
      {
        schedule.schedules.map((deptValue, deptIndex) => (
          <div key={deptIndex}>
            <h5>Department : {deptValue.departmentDto.name}</h5>
            {deptValue.schedules.map((scheduleValue, scheduleIndex) => (
              <div key={scheduleIndex}>
                <div style={{ display: 'flex', gap: '20px' }}>
                  <p>{scheduleValue.slot.startTime} : {scheduleValue.slot.endTime} </p>
                  {scheduleValue.doctorDto ? <>
                    <img src={"http://localhost:8080/images/doctors/" + scheduleValue.doctorDto.image} alt="" style={{width:50,height:50,objectFit:'cover'}}/>
                    <p>{scheduleValue.doctorDto.fullName}</p>
                  </> : <Button>Select Doctor</Button>}

                </div>
              </div>
            ))}
          </div>
        ))
      }
      {/* {Object.entries(schedule.schedules.reduce((acc, value) => {
        if (!acc[value.department_id]) {
          acc[value.department_id] = [];
        }
        acc[value.department_id].push(value);
        return acc;
      }, {})).map(([deptId, group]) => (
        <div key={deptId}>
          <h4>Department ID: {deptId}</h4>
          {group.map((value) => (
            <div key={value.id}>
              <p>
                {value.slot.startTime} : {value.slot.endTime}
                {value.doctorDto ? <span>value.doctorDto.fullName</span> : <Button>Select Doctor</Button>}
              </p>
            </div>
          ))}
        </div>
      ))} */}
    </>

  );
}

export default ScheduleDetail