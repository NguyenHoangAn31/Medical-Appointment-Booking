
// eslint-disable-next-line no-unused-vars
import React, { useState, useEffect } from 'react';
// eslint-disable-next-line no-unused-vars
import axios from 'axios';
//import ListDoctor from '../../components/UI/Doctor/ListDoctor'
import DoctorItem from '../../components/Card/DoctorItem';

const Doctor = () => {
  const [doctors, setDoctors] = useState([]);

  useEffect(() => {
      fetchDoctors();
  }, []);

  const fetchDoctors = async () => {
      const response = await axios.get(`http://localhost:8080/api/doctor/all`);
      const doctors = response.data;
      console.log(doctors);
      setDoctors(doctors);
  };


  return (
    <>
      {/* Hien create: 28/4/2024 */}
      {/* <ListDoctor /> */}
      <div className="container mt-5">
                <h1>List Doctor</h1>
                <hr />
                <div className="row">
                {doctors.map((item) => (
                    <div className="col-md-3">
                        <DoctorItem item={item} key={item.id} />
                    </div>
                ))}
                </div>
      </div>
    </>
  );
}

export default Doctor