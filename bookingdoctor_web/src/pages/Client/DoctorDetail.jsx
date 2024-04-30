

// Hien Create: 28/4/2024

// eslint-disable-next-line no-unused-vars
import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router-dom';
import { FaUserDoctor } from "react-icons/fa6";

// eslint-disable-next-line react/prop-types
const DoctorDetail = () => {
  const { id } = useParams();
  const [doctor, setDoctor] = useState(null);
  const [workings, setWorkings] = useState([]);
  const [relateds, setRelateds] = useState([]);

  useEffect(() => {
    fetchDoctor();
    fetchWorkings();
  }, [id]);

  const fetchDoctor = async () => {
    try {
      const response = await axios.get(`http://localhost:8080/api/doctor/${id}`);
      const doctor = response.data;
      setDoctor(doctor);
      // Gọi fetchRelateds khi đã lấy được thông tin bác sĩ
      fetchRelateds(doctor.department.name);
    } catch (error) {
      console.error('Error fetching doctor:', error);
    }
  };

  const fetchWorkings = async () => {
    try {
      const response = await axios.get(`http://localhost:8080/api/working/doctor/${id}`);
      const workings = response.data;
      setWorkings(workings);
    } catch (error) {
      console.error('Error fetching workings:', error);
    }
  };

  const fetchRelateds = async (departmentName) => {
    try {
      const response = await axios.get(`http://localhost:8080/api/doctor/relatedDoctors/${departmentName}`);
      const relatedDoctorsData = response.data;

      // Lấy 4 bác sĩ ngẫu nhiên từ danh sách
      const randomDoctors = relatedDoctorsData.sort(() => 0.5 - Math.random()).slice(0, 4);
      setRelateds(randomDoctors);
    } catch (error) {
      console.error('Error fetching related doctors:', error);
    }
  };

  if (!doctor) {
    return <div>Loading...</div>;
  }
  return (
    <>
      <div className="doctor__detail_background">
        <div className="row bg-white doctor__detail_header">
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
            <h1>{doctor.title} {doctor.fullName}</h1>
            <h3>Chuyên khoa: {doctor.department.name}</h3>
            <a href="" className='btn btn-primary'> ĐẶT KHÁM </a>
          </div>
        </div>
        <div className="container mt-5 pb-5 doctor__detail_">
          <strong>
            Lĩnh vực chuyên môn:
          </strong>
          <p>
            Tầm soát, giáo dục sức khỏe, dự phòng, điều trị cấp cứu và điều trị lâu dài các loại bệnh.
            <br />
            Chẩn đoán, tư vấn và điều trị cho tất cả các bệnh nhân.
          </p>
          <strong>
            Tâm niệm nghề nghiệp:
          </strong>
          <p>
            Góp phần đào tạo đội ngũ y tế chất lượng, làm hết khả năng để bảo vệ và trả lại cuộc sống có chất lượng (về sức khỏe) cho mọi người.
          </p>
        </div>
        <div className="container bg-white p-3 doctor__detail_woking">
          <strong>Kinh nghiệm làm việc:</strong>
          <ol>
            {Array.isArray(workings) && workings.map((working, index) => {
              // Tách ngày thành các phần riêng biệt
              const startWorkYear = working.startWork.split('-')[0];
              const endWorkYear = working.endWork.split('-')[0];
              return (
                <li key={index}>
                  <strong>{startWorkYear} - {endWorkYear}: </strong>
                  <br />
                  {working.company}
                </li>
              );
            })}
          </ol>
        </div>
        <div className="container">
          <div className="row doctor__detail_list">
            <span className='doctor__detail_list_title'><FaUserDoctor />&nbsp;&nbsp;&nbsp;XEM THÊM CÁC BÁC SĨ CÙNG CHUYÊN KHOA&nbsp;&nbsp;&nbsp;<FaUserDoctor /></span>
            {relateds.map((related, index) => (
              <div className="col-md-3" key={index}>
                <div className="card doctor__detail_list_card">
                  {/* <img src="..." className="card-img-top" alt="..."> */}
                  <img
                    src={related.gender === 'Male'
                      ? "../../../../public/images/doctors/2.png"
                      : "../../../../public/images/doctors/6.png"}
                    alt=""
                    className="card-img-top"
                  />
                  <div className="card-body">
                    <h5 className="card-title">
                      <Link to={`/doctor/${related.id}`} className='card-title_link'>
                        {related.title} {related.fullName}
                      </Link>
                    </h5>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
        <div className="m-5">&nbsp;&nbsp;&nbsp;</div>
      </div >
    </>
  );
};
export default DoctorDetail;

