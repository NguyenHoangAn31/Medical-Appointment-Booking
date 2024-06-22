import React, { useContext, useEffect, useState } from 'react'
import { useLocation, useNavigate } from 'react-router-dom';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import Spinner from '../../../../components/Spinner';
import { getAllDoctorWithStatus } from '../../../../services/API/doctorService';

import { Button, Select, Space, Tabs, Tag } from 'antd';
import { createSchedule, deleteSlot, findScheduleByDay, updateScheduleForAdmin } from '../../../../services/API/scheduleService';
import { getAllDepartment } from '../../../../services/API/departmentService';
import { getAllSlot } from '../../../../services/API/slotService';
import AOS from "aos";
import "aos/dist/aos.css";
import Slider from "react-slick"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"




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
  const [slotsForCreate, setSlotsForCreate] = useState([]);
  const [departmentId, setDepartmentId] = useState();
  const [slotsList, setSlotsList] = useState([]);

  useEffect(() => {
    loadClinic();
    loadDoctors();
  }, []);

  const loadClinic = async () => {
    const s = await findScheduleByDay(day)
    setClinic(s);
  };


  const loadDoctors = async () => {
    const doctorWithValueAndLabel = await getAllDoctorWithStatus();
    const departmenWithValueAndLable = await getAllDepartment();

    departmenWithValueAndLable.forEach(d => {
      d.value = d.id;
      d.label = d.name
    })
    doctorWithValueAndLabel.forEach(d => {
      d.value = d.id;
      d.label = d.fullName
    })
    setDoctors(doctorWithValueAndLabel);
    setDepartmentsForCreate(departmenWithValueAndLable)
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

  const handleChangeDepartment = async (value) => {
    setDepartmentId(value);
    if (slotsForCreate.length == 0) {
      console.log("first")
      const slotwithvalueAndlabel = await getAllSlot()
      slotwithvalueAndlabel.forEach(s => {
        s.value = s.id;
        s.label = s.startTime + ' - ' + s.endTime
      })
      setSlotsForCreate(slotwithvalueAndlabel)
    }
  };


  useEffect(() => {
    AOS.init({
      duration: 2000
    });
  }, []);

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

  const handleDeleteSlot = async (departmentId, slotId) => {
    try {
      await deleteSlot(day, departmentId, slotId)
      loadClinic()
      openNotificationWithIcon('success', 'Delete Slot Successfully', '')
    } catch (error) {
      console.log(error)
      openNotificationWithIcon('danger', 'Error Deleting Slot', '')
    }
  }





  return !Object.keys(clinic).length != 0 ? (
    <Spinner />
  ) : (
    <>
      <div className='d-lg-flex'>
        <div data-aos="fade-down" className='w-50 mt-4'>
          <h2>Work Day : {day} <Tag className='position-absolute' color={status === 'completed' ? 'red' : 'green'}>{status}</Tag></h2>
          <h3 className='mt-5'>Create Schedule</h3>
          <div className='mt-3'>
            <div className='mb-3'>
              <label htmlFor="" className='mb-1'>Choose Department</label>
              <Select
                style={{
                  display: 'block',
                }}
                disabled={status == 'completed'}
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
            </div>
            <div className='mb-3'>
              <label htmlFor="" className='mb-1'>Choose Work Hours</label>
              <Select
                mode="multiple"
                style={{
                  display: 'block',
                  height: 30,
                  marginBottom: 10
                }}
                placeholder="select slots"
                onChange={handleChangeSlot}
                disabled={status == 'completed'}
                options={slotsForCreate}
                optionRender={(option) => (
                  <Space>
                    <span role="img" aria-label={option.data.label}>
                      {option.data.startTime} - {option.data.endTime}
                    </span>
                  </Space>
                )}
              />
            </div>

            <div className='text-end mt-4'>
              <Button type='primary' disabled={slotsList.length == 0 || status == 'completed'} onClick={handleCreateSchedule}>Create</Button>

            </div>
          </div>

        </div>
        <div data-aos="fade-left" className='w-50'>
          <img src='/images/dashboard/schedule_create.jpg' alt="" className='w-100' />
        </div>

      </div>


      <div data-aos="fade-up">
        <h3 className='my-3'>List Schedule</h3>
        <Tabs
          // tabPosition={tabPosition}
          defaultActiveKey={null}
          centered
          items={clinic.departments.map((deptValue, i) => {
            const id = String(i + 1);
            return {
              label: <div className='d-flex gap-3'><img src={"http://localhost:8080/images/department/" + deptValue.icon} width='20' />{deptValue.name}   </div>,
              key: id,
              children: <Tabs
                tabPosition={tabPosition}
                defaultActiveKey={null}
                centered
                items={deptValue.slots.map((slot, slotIndex) => {
                  const id = String(slotIndex + 1);

                  return {
                    label: <span>{slot.startTime} : {slot.endTime} </span>,
                    key: id,
                    children: <div>

                      <Select
                        style={{ width: '85%', height: 30, marginRight: 15 }}
                        disabled={status == 'completed'}
                        mode="multiple"
                        placeholder="select doctor"
                        defaultValue={slot.doctorsForSchedules.map(doctor => doctor.id)}
                        onChange={(value) => handleChange(deptValue.id, slot.id, value)}
                        options={doctors.filter(doctor => doctor.department.id == deptValue.id)}
                        optionRender={(option) => (
                          <Space>
                            <span role="img" aria-label={option.data.fullName}>
                              <img src={"http://localhost:8080/images/doctors/" + option.data.image} alt="" style={{ width: 30, height: 30, objectFit: 'cover', borderRadius: '50%', objectPosition: 'top' }} />
                              <span className='ms-3'>{option.data.fullName}</span>
                            </span>
                          </Space>
                        )}
                      />
                      <Button type='primary' danger disabled={!slot.doctorsForSchedules.length == 0 || status == 'completed'} onClick={() => handleDeleteSlot(deptValue.id, slot.id)}>Delete Slot</Button>

                      <Slider {...{
                        dots: false,
                        infinite: slot.doctorsForSchedules.length>3,
                        slidesToShow: slot.doctorsForSchedules.length,
                        slidesToScroll: 2
                      }} className='mt-5'>
                        {slot.doctorsForSchedules.map((doctor, doctorIndex) => (
                          <div key={doctorIndex} className='text-center'>
                            <img src={"http://localhost:8080/images/doctors/" + doctor.image} alt="" style={{ backgroundImage: 'linear-gradient(120deg, rgb(161, 196, 253) 0%, rgb(194, 233, 251) 100%)',width:200,display:'block',margin:'auto' }} />
                            <p className='mt-3'>{doctor.fullName}</p>
                          </div>
                        ))}
                      </Slider>
                    </div>
                  }
                })}
              />
              // children:
              //  deptValue.slots.map((slot, slotIndex) => (
              //   <div key={slotIndex} className='d-flex align-items-center justify-content-between' style={{ maxWidth: 850, marginBottom: 15 }}>
              //     <div style={{ display: 'flex', gap: '20px', alignItems: 'center' }}>
              //       <span>{slot.startTime} : {slot.endTime} </span>
              //       {slot.doctorsForSchedules ? <>
              //         {slot.doctorsForSchedules.map((doctor, doctorIndex) => (
              //           <div key={doctorIndex}>
              //             <img src={"http://localhost:8080/images/doctors/" + doctor.image} alt="" style={{ width: 50, height: 50, objectFit: 'cover', borderRadius: '50%', objectPosition: 'top' }} />
              //           </div>
              //         ))}
              //       </> : null}
              //     </div>

              //     <Select
              //       disabled={status == 'completed'}
              //       mode="multiple"
              //       placeholder="select doctor"
              //       defaultValue={slot.doctorsForSchedules.map(doctor => doctor.id)}
              //       onChange={(value) => handleChange(deptValue.id, slot.id, value)}
              //       options={doctors.filter(doctor => doctor.department.id == deptValue.id)}
              //       optionRender={(option) => (
              //         <Space>
              //           <span role="img" aria-label={option.data.fullName}>
              //             <img src={"http://localhost:8080/images/doctors/" + option.data.image} alt="" style={{ width: 30, height: 30, objectFit: 'cover', borderRadius: '50%', objectPosition: 'top' }} />
              //             {option.data.fullName}
              //           </span>
              //           {option.data.birthday}
              //         </Space>
              //       )}
              //     />
              //     <Button type='primary' danger disabled={!slot.doctorsForSchedules.length == 0 || status == 'completed'} onClick={() => handleDeleteSlot(deptValue.id, slot.id)}>Delete Slot</Button>
              //   </div>
              // )),
            };
          })}
        />
      </div>

    </>
  );
}

export default ScheduleDetail