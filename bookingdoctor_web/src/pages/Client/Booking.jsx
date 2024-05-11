import React, { useState, useEffect } from 'react'
import { MdSearch, MdOutlineStarPurple500, MdCalendarMonth  } from "react-icons/md";
//import * as department from '../../services/API/departmentService';
import ServiceItem from '../../components/Card/ServiceItem';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css';
import 'bootstrap-datepicker';
import $ from 'jquery';

const Booking = () => {
  const currentDate = new Date();
  // Lấy tháng hiện tại
  // const currentMonth = currentDate.getMonth() + 1; // Tháng bắt đầu từ 0 nên cần cộng thêm 1
  //const currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0');
  const months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];
  // Lấy tên của tháng hiện tại
  const currentMonth = months[currentDate.getMonth()];
  // Lấy năm hiện tại
  const currentYear = currentDate.getFullYear();
  const [activeIndex, setActiveIndex] = useState(0);
  const [services, setServices] = useState([]);
  
  // Khởi tạo state cho ngày
  const [day, setDay] = useState(`${currentMonth}, ${currentYear}`);
  

  const loadDepartments = async () => {
    const fetchedDepartments = await axios.get('http://localhost:8080/api/department/all');
    setServices(fetchedDepartments.data);
  };
  // thực hiện load dữ liệu 1 lần 
  useEffect(() => {
    $('#datepicker').datepicker({
      format: "MM, yyyy", // Định dạng hiển thị chỉ có tháng và năm
      startView: "months", // Bắt đầu hiển thị từ view tháng
      minViewMode: "months", // Chế độ hiển thị tối thiểu là tháng
      autoclose: true // Tự động đóng khi chọn xong
    });

    loadDepartments();
  }, []);

  const handleClick = (index) => {
    setActiveIndex(index);
  };
  return (
    <section className='container'>
      <div className="row">
        <div className="col-md-7">
          <div className="col-md-12">
            <div className="row">
              <div className="col-12">
                <div className='booking__search'>
                  <MdSearch className='booking__search-icon' />
                  <input type="text" placeholder='Search doctor, services' className='booking__search-input' />
                </div>
              </div>
              <div className="col-12">
                <h3 className='booking_title'>Making appointment</h3>
              </div>
              <div className="col-12">
                <div className="booking__catagory">
                  <h4 className='title'>Choose category</h4>
                  <div className='services'>
                    {services.map((item, index) => (
                      <div key={index} className={`service__item ${activeIndex === index ? 'active' : ''}`} onClick={() => handleClick(index)}>
                        <img src="/images/departments/pediatrics.png" alt="" className='service__item-img' />
                        <div className='service__item-name'>{item.name}</div>
                      </div>
                    ))}
                  </div>
                </div>
                <div className="col-12">

                  <div className="booking__list">
                    <div className="title">Choose doctor</div>
                    <div className="card__body">
                      <div className='card__doctor active'>
                        <div className='doctr_image'>
                          <img src="/images/doctors/1.png" alt="" className='img-fluid' />
                        </div>
                        <div className='doctr_info'>
                          <div>
                            <div className='name'>Dr. Cameron William</div>
                            <div className='department'>Cardiologist</div>
                          </div>
                          <div className='icon'><MdOutlineStarPurple500 className='icon_item' /> 5.0</div>
                        </div>
                      </div>
                      <div className='card__doctor'>
                        <div className='doctr_image'>
                          <img src="/images/doctors/2.png" alt="" className='img-fluid' />
                        </div>
                        <div className='doctr_info'>
                          <div>
                            <div className='name'>Dr. Cameron </div>
                            <div className='department'>Cardiologist</div>
                          </div>
                          <div className='icon'><MdOutlineStarPurple500 className='icon_item' /> 5.0</div>
                        </div>
                      </div>
                    </div>

                  </div>

                </div>
                <div className="col-12">
                  <div className="booking__date">
                    <div className='header_date'>
                      <div className="title">Choose date and time</div>
                      <div className="date_choose_input">
                        <div className="input__group">
                          <input type="text" className="input_date" id="datepicker" 
                          value={day} onChange={(e) => 
                          setDay(e.target.value)} />
                          <span className="input_group-text">
                              <MdCalendarMonth />
                          </span>
                        </div>
                      </div>
                    </div>
                    <div className='body_day'>
                      <div className='day_item'>
                        <span className='day-title'>Mon</span>
                        <span className='day-number'>6</span>
                      </div>
                      <div className='day_item'>
                        <span className='day-title'>Tue</span>
                        <span className='day-number'>7</span>
                      </div>
                      <div className='day_item'>
                        <span className='day-title'>Web</span>
                        <span className='day-number'>8</span>
                      </div>
                      <div className='day_item'>
                        <span className='day-title'>Thu</span>
                        <span className='day-number'>9</span>
                      </div>
                      <div className='day_item active'>
                        <span className='day-title'>Fri</span>
                        <span className='day-number'>10</span>
                      </div>
                      <div className='day_item'>
                        <span className='day-title'>Sat</span>
                        <span className='day-number'>11</span>
                      </div>
                      <div className='day_item'>
                        <span className='day-title'>Sun</span>
                        <span className='day-number'>12</span>
                      </div>
                    </div>
                    <div className="body_date">
                      <div className='hour_item active'>
                        <div>08:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>08:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>09:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>09:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>10:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>10:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>11:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>11:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>13:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>13:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>14:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>14:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>15:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>15:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>16:00</div>
                      </div>
                      <div className='hour_item'>
                        <div>16:30</div>
                      </div>
                      <div className='hour_item'>
                        <div>17:00</div>
                      </div>
                    </div>
                    <div className="footer_date">
                      <div className="date_view">
                        <div className='date_view_day'><span>9</span><span> November,</span><span> 2024</span> | <span className='hour'>09:30</span></div>
                        <div className='btn__booking-appointment'>
                          Book
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="col-md-5">
          <div className='doctor__info'>
            adasd
          </div>
        </div>
      </div>
    </section>
  )
}

export default Booking