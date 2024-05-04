import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { GoArrowUpRight } from "react-icons/go";

const DoctorItem = (props) => {
    const {id, fullName, title, gender, department, image} = props.item;

  return (

        <div className="doctor__list" key={id}>
            <div className="doctor__list_background"></div>
            {/* <img src="../../../../public/images/doctors/2.png" alt="" className="doctor__list_image" /> */}
            <img
                src={gender === 'Male'
                    ? "../../../../public/images/doctors/2.png"
                    : "../../../../public/images/doctors/6.png"}
                alt=""
                className="doctor__list_image"
            />
            <div className="doctor__list_background_title"></div>
            <span className="doctor__list_title">{title} {fullName}</span>
            <span className="doctor__list_department">Khoa: {department.name}</span>
            <div className="doctor__list_icon">
                <Link to={`/doctor/${id}`}>
                    <GoArrowUpRight className='list__icon-rowup' />
                </Link>
            </div>
        </div>

  )
}

export default DoctorItem