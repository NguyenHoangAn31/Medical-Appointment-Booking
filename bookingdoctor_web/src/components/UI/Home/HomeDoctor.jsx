import React, {useEffect, useState} from 'react'
import DoctorItem from '../../Card/DoctorItem'
import Slider from "react-slick"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"
// import * as doctor from '../../../services/API/';
import axios from 'axios'

const HomeDoctor = () => {

    const [doctors, setDoctors] = useState([]);
    console.log(doctors);
    // tải dữ liệu và gán vào departments thông qua hàm setDepartments
//   const loadDepartments = async () => {
//     const fetchedDoctors = await .getAllDepartment();
//     setDepartments(fetchedDepartments);
//   };
//   // thực hiện load dữ liệu 1 lần 
//   useEffect(() => {
//     loadDepartments();
//   }, []);

    useEffect(() => {
        fetchDoctors();
    }, []);

    const fetchDoctors = async () => {
        const response = await axios.get(`http://localhost:8080/api/doctor/all`);
        const doctors = response.data;
        setDoctors(doctors);
    };


  const settings = {
    dots: true,
    infinite: true,
    slidesToShow: 4,
    slidesToScroll: 5,
    autoplay: false,
    // initialSlide: 0,
    responsive: [
        {
            breakpoint: 1024,
            settings: {
                slidesToShow: 3,
                slidesToScroll: 3,
                infinite: true,
                dots: true
            }
        },
        {
            breakpoint: 600,
            settings: {
                slidesToShow: 2,
                slidesToScroll: 2,
                initialSlide: 2
            }
        },
        {
            breakpoint: 480,
            settings: {
                slidesToShow: 1,
                slidesToScroll: 1
            }
        }
    ],
    appendDots: (dots) => {
        return <ul style={{ margin: "0px" }}>{dots}</ul>
    },
}
  return (
    <section className='container'>
           <div className='mb-5'>
                <div className='main__doctor'>You can find trusted doctor around the globe</div>
           </div>
            <div className='slider-container'>
                <Slider {...settings}>
                    {doctors.map((item) => (
                        <DoctorItem
                            key={item.id}
                            item={item}
                        />
                    )
                    )}
                </Slider>
            </div>
            <div>
            <a className='btn__service' href='/service'>See all</a>
            </div>
            
        </section>
  )
}

export default HomeDoctor