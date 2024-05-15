import React, { useState, useEffect } from 'react'
import { MdSearch, MdOutlineStarPurple500, MdCalendarMonth, MdOutlinePhoneInTalk } from "react-icons/md";
import { BiCommentDots, BiSolidVideo } from "react-icons/bi";
//import * as department from '../../services/API/departmentService';
// import ServiceItem from '../../components/Card/ServiceItem';
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css';
import 'bootstrap-datepicker';
import Slider from "react-slick"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"
import $ from 'jquery';
import { startOfWeek, addDays, format } from 'date-fns';

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
  const [activeDayIndex, setActiveDayIndex] = useState(0);
  const [activeDoctorIndex, setActiveDoctorIndex] = useState(0);
  const [services, setServices] = useState([]);
  const [doctors, setDoctors] = useState([]);
  const [days, setDays] = useState([]);
  const [doctorId, setDoctorId] = useState('');
  //console.log(doctors)
  // Khởi tạo state cho ngày
  const [day, setDay] = useState(`${currentMonth}, ${currentYear}`);
  const loadDepartments = async () => {
    const fetchedDepartments = await axios.get('http://localhost:8080/api/department/all');
    setServices(fetchedDepartments.data);
  };

  const loadDoctors = async () => {
    const fetchedDoctors = await axios.get('http://localhost:8080/api/doctor/all');
    setDoctors(fetchedDoctors.data);
  };

  const loadDayDefaults = () => {
    const ngayHienTai = new Date(); // Ngày hiện tại
    const ngayDauTuan = startOfWeek(ngayHienTai); // Ngày đầu tiên của tuần hiện tại
    const daysOfWeekNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    const cacNgayTrongTuan = [];
    let activeDayIndex = -1;
    for (let i = 0; i < 7; i++) {
      const ngay = addDays(ngayDauTuan, i);
      const ngayOfMonth = ngay.getDate(); // Lấy ngày trong tháng
      const thang = ngay.getMonth() + 1; // Tháng tính từ 0, nên cần cộng thêm 1
      const nam = ngay.getFullYear(); // Năm
      // Thứ, 0 là Chủ Nhật, 1 là Thứ Hai, ..., 6 là Thứ Bảy
      const tenThu = daysOfWeekNames[ngay.getDay()];
      cacNgayTrongTuan.push({ ngayOfMonth, thang, nam, tenThu, i });
      if(ngay.toDateString() === ngayHienTai.toDateString()){
        activeDayIndex = i;
      }
    }
    setActiveDayIndex(activeDayIndex);
    setDays(cacNgayTrongTuan);
   // console.log(cacNgayTrongTuan)
  }
  // Hàm tìm slot của bác sỹ khám bệnh

  // thực hiện load dữ liệu 1 lần 
  useEffect(() => {
    $('#datepicker').datepicker({
      format: "MM, yyyy", // Định dạng hiển thị chỉ có tháng và năm
      startView: "months", // Bắt đầu hiển thị từ view tháng
      minViewMode: "months", // Chế độ hiển thị tối thiểu là tháng
      autoclose: true // Tự động đóng khi chọn xong
    });
    loadDoctors();
    loadDepartments();
    loadDayDefaults();
  }, []);

  const handleClick = async (index) => {
    setActiveIndex(index);
    try {
      const fetchedDoctorDepartment = await axios.get('http://localhost:8080/api/doctor/related-doctor/' + index);
      setDoctors(fetchedDoctorDepartment.data)
      console.log(fetchedDoctorDepartment.data)
    } catch (error) {

    }
  }
  const handleDayClick = async (index) => {
    setActiveDayIndex(index);
  }
  const handleDoctorClick = async (index) => {
    setActiveDoctorIndex(index);
  }

  const handleSubmitBook = () => {

  }

  const settings = {
    dots: false,
    infinite: true,
    speed: 500,
    slidesToShow: 2,
    slidesToScroll: 2
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
                    {services.map((item) => (
                      <div key={item.id} className={`service__item ${activeIndex === item.id ? 'active' : ''}`} onClick={() => handleClick(item.id)}>
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
                      <Slider {...settings}>
                        {doctors.map((item) => (
                          <div className={`card__doctor ${activeDoctorIndex === item.id ? 'active' : ''}`} key={item.id} onClick={() => handleDoctorClick(item.id)}>
                            <div className='doctr_image'>
                              <img src={`http://localhost:8080/images/doctors/` + item.image} alt="" className='img-fluid' />
                            </div>
                            <div className='doctr_info'>
                              <div>
                                <div className='name'>Dr. {item.fullName}</div>
                                <div className='department'>{item.department.name}</div>
                              </div>
                              <div className='icon'><MdOutlineStarPurple500 className='icon_item' /> {item.rate}</div>
                            </div>
                          </div>
                        )
                        )}
                      </Slider>

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
                      {days.map((day, i) => (
                        <div key={i} className={`day_item ${activeDayIndex === i ? 'active' : ''}`} onClick={() => handleDayClick(i)}>
                          <span className='day-title'>{day.tenThu}</span>
                          <span className='day-number'>{day.ngayOfMonth}</span>
                        </div>
                      )
                      )}
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
                        <div className='btn__booking-appointment' onClick={handleSubmitBook}>
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
          <div className='doctor__profile'>
            <div className='info__card'>
              <img src="/images/doctors/1.png" alt="" className='img__doctor' />
              <div className="doctor_info">
                <div className='name'>Dr. Liza Martin</div>
                <div className='department'>Cardiologist</div>
              </div>
              <div className='doctor_contact'>
                <div className='contact_icon'>
                  <BiCommentDots />
                </div>
                <div className='contact_icon'>
                  <MdOutlinePhoneInTalk />
                </div>
                <div className='contact_icon'>
                  <BiSolidVideo />
                </div>
              </div>
            </div>
            <div className="biography">
              <div className="title">Biography</div>
              <div className="content">
                Lorem ipsum dolor sit, amet consectetur adipisicing elit. Nulla deserunt voluptates laudantium ad debitis dicta sed totam nihil, laboriosam alias,
                ea incidunt nemo tempore vel voluptatum fuga. Voluptatibus, omnis facilis! <a href="#">Read more</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  )
}

export default Booking