/* eslint-disable no-unused-vars */
import React, { useState, useEffect, useContext } from 'react';
import axios from 'axios';
import { PlusOutlined } from '@ant-design/icons';
import { Button, message, DatePicker } from 'antd';
import dayjs from 'dayjs';
import { AlertContext } from '../../../components/Layouts/DashBoard';

function Schedule() {
  const [slots, setSlots] = useState([]);
  const [patients, setPatients] = useState({});
  const { currentUser } = useContext(AlertContext);
  const [selectedDate, setSelectedDate] = useState(dayjs());
  const [selectedSlot, setSelectedSlot] = useState(null);

  useEffect(() => {
    const fetchSlotData = async () => {
      if (!currentUser || !currentUser.user || !currentUser.user.id) return;
      try {
        const dayMonthYear = selectedDate.format('YYYY-MM-DD');
        const response = await axios.get(`http://localhost:8080/api/schedules/doctor/${currentUser.user.id}/day/${dayMonthYear}`);
        const slotData = response.data;
        setSlots(slotData);
        // Fetch patient details for each slot
        slotData.forEach(slotItem => {
          fetchPatientData(slotItem.startTime, slotItem.scheduledoctorId);
        });
      } catch (error) {
        console.error('Error fetching doctor data:', error);
        message.error('Failed to fetch slot data');
      }
    };

    fetchSlotData();
  }, [currentUser, selectedDate]);

  const fetchPatientData = async (startTime, doctorId) => {
    try {
      const response = await axios.get(`http://localhost:8080/api/patient/patientbyscheduledoctoridandstarttime/${doctorId}/${startTime}`);
      const patientData = response.data;
      setPatients(prevPatients => ({
        ...prevPatients,
        [`${startTime}-${doctorId}`]: patientData
      }));
    } catch (error) {
      console.error('Error fetching patient data:', error);
    }
  };

  const handleDateChange = (date) => {
    setSelectedDate(date);
  };

  const handleSlotClick = (slotItem) => {
    setSelectedSlot(slotItem);
  };

  return (
    <div className="schedule">
      <Button
        type="primary"
        icon={<PlusOutlined />}
        style={{ backgroundColor: '#52c41a', marginBottom: '16px' }}
      >
        Add New Schedule
      </Button>
      <hr />
      <DatePicker
        value={selectedDate}
        onChange={handleDateChange}
        style={{ marginBottom: '16px' }}
      />
      <div className="row">
        {slots.map((slotItem, index) => (
          <div key={index} className="col-lg-2">
            <div
              className="card mb-2"
              style={slotItem.status !== 1 ? { border: '2px solid blue' } : {}}
              onClick={() => handleSlotClick(slotItem)}
            >
              <div className="card-header text-center">
                <strong>{slotItem.startTime}</strong>
              </div>
              <div className="card-body text-center">
                {slotItem.status === 1 ? 'No Booking' : 'Booking'}
                {/* {patients[`${slotItem.startTime}-${slotItem.scheduledoctorId}`] && (
                  <div>
                    {patients[`${slotItem.startTime}-${slotItem.scheduledoctorId}`].map((patient, patientIndex) => (
                      <div key={patientIndex}>
                        <p><img src={"http://localhost:8080/images/patients/" + patient.image} alt="" width={'50px'} style={{ borderRadius: '50%' }} /> <span className='h3'>{patient.fullName}</span> </p>
                      </div>
                    ))}
                  </div>
                )} */}
              </div>
            </div>
          </div>
        ))}
      </div>
      <hr />
      {selectedSlot && patients[`${selectedSlot.startTime}-${selectedSlot.scheduledoctorId}`] && (
        <div className="selected-slot-info">
          {/* <h3>Patient Information</h3> */}
          {patients[`${selectedSlot.startTime}-${selectedSlot.scheduledoctorId}`].map((patient, index) => (
            <table key={index} className='table align-middle'>
              <thead>
                <tr>
                  <th></th>
                  <th>Full Name</th>
                  <th>Birthday</th>
                  <th>Gender</th>
                  <th>Medicals</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td><img src={"http://localhost:8080/images/patients/" + patient.image} alt="" width={'50px'} height={'50px'} style={{ borderRadius: '50%' }} /></td>
                  <td>{patient.fullName}</td>
                  <td>{patient.birthday}</td>
                  <td>{patient.gender}</td>
                  <td>
                    {Array.isArray(patient.medicals) && patient.medicals.map((medical, index) => {
                      const name = medical.name;
                      const content = medical.content;
                      return (
                        <p key={index}>{name}: {content}</p>
                      );
                    })}
                  </td>
                  <td>
                    <select>
                      <option value="">waiting</option>
                      <option value="">no show</option>
                      <option value="">cancel</option>
                      <option value="">finished</option>
                    </select>
                  </td>
                </tr>
              </tbody>
            </table>
            // <div key={index}>
            //   <p> <span className='h3'></span> </p>
            //   <p>Age: </p>
            //   <p>Gender: </p>
            //   {Array.isArray(patient.medicals) && patient.medicals.map((medical, index) => {
            //     const name = medical.name;
            //     const content = medical.content;
            //     return (
            //       <p key={index}>{name}: {content}</p>
            //     );
            //   })}
            // </div>
          ))}
        </div>
      )}
    </div>
  );
}

export default Schedule;
