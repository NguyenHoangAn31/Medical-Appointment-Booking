
// Hien create: 28/4/2024

// eslint-disable-next-line no-unused-vars
import React, { useState, useEffect } from 'react';
import axios from 'axios';
// eslint-disable-next-line no-unused-vars
import { Link } from 'react-router-dom';
import { GoArrowUpRight } from "react-icons/go";


const ListDoctor = () => {
    const [doctors, setDoctors] = useState([]);

    useEffect(() => {
        fetchDoctors();
    }, []);

    const fetchDoctors = async () => {
        const response = await axios.get(`http://localhost:8080/api/doctor/all`);
        const doctors = response.data;
        setDoctors(doctors);
    };

    return (
        <>
            <div className="container mt-5">
                <h1>List Doctor</h1>
                <hr />
                <div className="row">
                    {doctors.map((doctor, index) => (
                        <div className="col-md-3" key={index}>
                            <div>
                                <div className="doctor__list">
                                    <div className="doctor__list_background"></div>
                                    {/* <img src="../../../../public/images/doctors/2.png" alt="" className="doctor__list_image" /> */}
                                    <img
                                        src={doctor.gender === 'Male'
                                            ? "../../../../public/images/doctors/2.png"
                                            : "../../../../public/images/doctors/6.png"}
                                        alt=""
                                        className="doctor__list_image"
                                    />
                                    <div className="doctor__list_background_title"></div>
                                    <span className="doctor__list_title">{doctor.title} {doctor.fullName}</span>
                                    <span className="doctor__list_department">Khoa: {doctor.department.name}</span>
                                    <div className="doctor__list_icon">
                                        <Link to={`/doctor/${doctor.id}`}>
                                            <GoArrowUpRight />
                                        </Link>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            </div>
        </>
    );
}

export default ListDoctor;
