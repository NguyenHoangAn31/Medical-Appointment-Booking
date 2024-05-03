// eslint-disable-next-line no-unused-vars
import React, { useState, useEffect } from 'react';
import axios from 'axios';
// import moment from 'moment';
// eslint-disable-next-line no-unused-vars
import getUserData from '../../../route/CheckRouters/token/Token'
function ProfileDoctor() {
  const [doctor, setDoctor] = useState(null);
  // const id = getUserData.user.id; // cái này là user_id
  useEffect(() => {
    const id = getUserData.user.id;
    const fetchDoctorData = async () => {
      try {
        const response = await axios.get(`http://localhost:8080/api/doctor/${id}`); // cái này là tìm doctor theo id chứ k phải tìm theo user_id
        const doctorData = response.data;
        console.log(doctorData);
        setDoctor(doctorData);
      } catch (error) {
        console.error('Error fetching doctor data:', error);
      }
    };
    fetchDoctorData();
  }, []);

  if (!doctor) {
    return <div>Loading...</div>;
  }


  // const formattedBirthday = moment(doctor.birthday).format('DD/MM/YYYY');

  return (
    <div className='container-fluid'>
      <div className="row">
        <div className="col-md-6">
          <img
            src={doctor.gender === 'Male'
              ? "../../../../public/images/doctors/2.png"
              : "../../../../public/images/doctors/6.png"}
            alt=""
            className=""
          />
        </div>
        <div className="col-md-6">
          <h1>{doctor.title} {doctor.fullName}</h1>
          <p>
            {/* chuyển này về định dạng localDate */}
            <strong>Birthday: </strong>
            {/* {doctor.birthday} */}
            {doctor.birthday && <span>{doctor.birthday[2]}/{doctor.birthday[1]}/{doctor.birthday[0]}</span>}
          </p>
          <p>
            <strong>Address: </strong>
            {doctor.address}
          </p>
          <hr />
          <p>
            <strong>Email: </strong>
            {getUserData.user.email}
          </p>
          <p>
            <strong>Phone: </strong>
            {getUserData.user.phone}
          </p>
          <hr />
          <p>
            <strong>Kinh nghiệm:</strong>
            <p></p>
            <ul>
              {Array.isArray(doctor.workings) && doctor.workings.map((working, index) => {
                const startWorkYear = working.startWork.split('-')[0];
                const endWorkYear = working.endWork.split('-')[0];
                return (
                  <li key={index}>
                    <p>
                      <strong>{startWorkYear} - {endWorkYear}: </strong>
                      {working.company}
                    </p>
                  </li>
                );
              })}
            </ul>
          </p>
        </div>
      </div>

    </div>
  )
}
export default ProfileDoctor