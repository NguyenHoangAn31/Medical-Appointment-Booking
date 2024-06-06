import React, { useContext, useEffect, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import Spinner from '../../../../components/Spinner';
import { getAllDoctorWithStatus } from '../../../../services/API/doctorService';

import { Button, Select, Space, Tabs } from 'antd';
import { createSchedule, findScheduleByDay, updateScheduleForAdmin } from '../../../../services/API/scheduleService';
import { getAllDepartment } from '../../../../services/API/departmentService';
import { getAllSlot } from '../../../../services/API/slotService';
import { CloseSquareFilled } from '@ant-design/icons';


function ScheduleDetail() {

  // thông báo
  const { openNotificationWithIcon } = useContext(AlertContext);
  // lấy date từ url
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const day = queryParams.get("day");
  const status = queryParams.get("status")


  // tabs
  const [tabPosition, setTabPosition] = useState('left');

  const [clinic, setClinic] = useState({});
  const [doctors, setDoctors] = useState([]);
  const [departmentsForCreate, setDepartmentsForCreate] = useState([]);
  const [slots, setSlots] = useState([]);
  const [slotsForCreate, setSlotsForCreate] = useState([]);
  const [departmentId, setDepartmentId] = useState();
  const [slotsList, setSlotsList] = useState([]);

  useEffect(() => {
    loadClinic();
    loadDoctors();
  }, []);

  const loadClinic = async () => {
    const s = await findScheduleByDay(day)
    const d = await getAllDepartment();
    const slotwithvalueandlabel = await getAllSlot()
    


    d.forEach(d => {
      d.value = d.id;
      d.label = d.name
    })

    slotwithvalueandlabel.forEach(s => {
      s.value = s.id;
      s.label = s.startTime + ' - ' + s.endTime
    })
    setDepartmentsForCreate(d)
    setClinic(s);
    setSlots(slotwithvalueandlabel)
  };




  const loadDoctors = async () => {
    var doctorList = await getAllDoctorWithStatus();
    doctorList.forEach(doctor => {
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

  const handleChangeDepartment = (value) => {
    setDepartmentId(value);
    var s = clinic.departments[value]?.slots ?? [];
    if (s.length != 0) {
      const filteredSlots = slotsForCreate.filter(
        s => !x.some(slot => slot.id === s.id)
      );
      filteredSlots.forEach(s => {
        s.value = s.id;
        s.label = s.startTime + ' - ' + s.endTime
      })
      setSlotsForCreate(filteredSlots)
    }
    else {
      setSlotsForCreate(slots)
    }

  };
  const handleChangeSlot = async (value) => {
    setSlotsList(value)
  };

  const handleCreateSchedule = async () => {
    try {
      await createSchedule(day, departmentId, slotsList)
      loadClinic()
      openNotificationWithIcon('success', 'Create Schedule Successfully', '')
    } catch (error) {
      console.log(error)
      openNotificationWithIcon('warning', 'Work Schedule Has Been Created', '')
    }
  }




  return !Object.keys(clinic).length != 0 ? (
    <Spinner />
  ) : (
    <>
      <h1 className='mb-5'>Work Day : {day} <span style={{ color: status === 'completed' ? 'red' : '#09ff00' }}>{status}</span></h1>
      <Select
        style={{
          display: 'block',
          width: '40%'
        }}
        placeholder="select department"
        onChange={handleChangeDepartment}
        options={departmentsForCreate}
        optionRender={(option) => (
          <Space>
            <span role="img" aria-label={option.data.name}>
              {option.data.name}
            </span>
          </Space>
        )}
      />

      <Select
        mode="multiple"
        style={{
          display: 'block',
          width: '40%',
          height: 30
        }}
        placeholder="select slots"
        onChange={handleChangeSlot}
        options={slotsForCreate}
        optionRender={(option) => (
          <Space>
            <span role="img" aria-label={option.data.label}>
              {option.data.startTime} - {option.data.endTime}
            </span>
          </Space>
        )}
      />
      <Button disabled={slotsList.length == 0} onClick={handleCreateSchedule}>Create</Button>
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
                  disabled={status == 'completed'}
                  mode="multiple"
                  style={{ width: '50%' }}
                  placeholder="select doctor"
                  defaultValue={slot.doctorsForSchedules.map(doctor => doctor.id)}
                  onChange={(value) => handleChange(deptValue.id, slot.id, value)}
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