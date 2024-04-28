

// Hien Create: 28/4/2024

// eslint-disable-next-line no-unused-vars
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';
const DoctorDetail = () => {
  const { id } = useParams();
  const [doctor, setDoctor] = useState(null);
  useEffect(() => {
    fetchDoctor();
  }, [id]);
  const fetchDoctor = async () => {
    try {
      const response = await axios.get(`http://localhost:8080/api/doctor/${id}`);
      const doctor = response.data;
      setDoctor(doctor);
    } catch (error) {
      console.error('Error fetching doctor:', error);
    }
  };
  if (!doctor) {
    return <div>Loading...</div>;
  }
  return (

    <>
      <div className="container">
        <div className="row doctor__detail_header" >
          <div className="col-md-6 doctor__detail_header_left">
            <img
              src={doctor.gender === 'Male'
                ? "../../../../public/images/doctors/2.png"
                : "../../../../public/images/doctors/6.png"}
              alt=""
              className=""
            />
          </div>
          <div className="col-md-6 doctor__detail_header_right">
            <div className="btn">
              <span className="noselect">
                {doctor.title}{doctor.fullName}
              </span>
            </div>
          </div>
        </div>
      </div>
      {/* <div>
        <h1>Doctor Detail</h1>
        <p>ID: {doctor.id}</p>
        <p>Avatar: {doctor.image}</p>
        <p>Full Name: {doctor.fullName}</p>
        <p>Title: {doctor.title}</p>
        <p>Gender: {doctor.gender}</p>
        <p>Birthday: {doctor.birthday}</p>
        <p>Address: {doctor.address}</p>
      </div> */}
    </>

  );
};
export default DoctorDetail;

