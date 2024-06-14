import { Button, Form, Select } from 'antd'
import React, { useContext, useEffect, useState } from 'react'
import { changeStatus, getAppointmentDetail } from '../../../../services/API/appointmentService';
import { useInternalNotification } from 'antd/es/notification/useNotification';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import { Link, useLocation } from 'react-router-dom';
import Spinner from '../../../../components/Spinner';

function AppointmentDetail() {
  const { openNotificationWithIcon } = useContext(AlertContext);

  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const id = queryParams.get("id");


  const [status, setStatus] = useState('');
  const [appointmentDetail, setAppointmentDetail] = useState({});

  useEffect(() => {
    loadAppointment();
  }, []);


  console.log(appointmentDetail)

  const loadAppointment = async () => {
    setAppointmentDetail(await getAppointmentDetail(id));
  }

  const onInputChange = (value) => {
    setStatus(value)
  }
  const handleSubmit = async () => {
    try {
      await changeStatus(id, status);
      openNotificationWithIcon('success', 'Change Status Successfully', '')
      loadAppointment();
    } catch (error) {
      openNotificationWithIcon('error', 'Something Went Wrong', '')
      console.log(error)
    }
  }
  console.log(appointmentDetail)
  return (
    <div>




      {
        !Object.keys(appointmentDetail).length != 0 ? <Spinner /> : <>

          <div className='general-information'>
            <p>Appointment Date : {appointmentDetail.appointmentDate}</p>
            <p>Medical Examination Day : {appointmentDetail.medicalExaminationDay}</p>
            <p>Medical Examination Hours : {appointmentDetail.clinicHours}</p>
            <p>Medical Examination Price Paid : {appointmentDetail.doctor.price} VND</p>

            <p>Booking Price : {appointmentDetail.price} VND</p>
          </div>
          <div className='appointment-patient'>
            <img src={"http://localhost:8080/images/doctors/" + appointmentDetail.doctor.image} alt="" width='50' />
            <p>Doctor Name : {appointmentDetail.doctor.fullName}</p>
          </div>
          <div className='appointment-doctor'>
            <img src={"http://localhost:8080/images/patients/" + appointmentDetail.patient.image} alt="" width='50' />

            <p>Patient Name : {appointmentDetail.patient.fullName}</p>
            <p>Note : {appointmentDetail.note}</p>

          </div>

          {appointmentDetail.status != 'success' && appointmentDetail.status != 'cancel' ? <><Form.Item label="Status" style={{ width: '20%' }}>
            <Select placeholder="Choose Status" onChange={(e) => onInputChange(e)}>
              <Select.Option value="cancel">Cancel</Select.Option>
              <Select.Option value="success">Success</Select.Option>
            </Select>
          </Form.Item>
            <Button disabled={status == ''} onClick={handleSubmit}>Change Status</Button></> : <h1>Appointment has been {appointmentDetail.status}</h1>}
        </>
      }

    </div>
  )
}

export default AppointmentDetail