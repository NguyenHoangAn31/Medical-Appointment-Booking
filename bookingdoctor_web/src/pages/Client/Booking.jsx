import React, { useState, useEffect } from 'react'
import { MdSearch, MdOutlineStarPurple500, MdCalendarMonth, MdOutlinePhoneInTalk } from "react-icons/md";
import { BiCommentDots, BiSolidVideo } from "react-icons/bi";
import axios from 'axios';
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css';
import 'bootstrap-datepicker';
import Slider from "react-slick"
import "slick-carousel/slick/slick.css"
import "slick-carousel/slick/slick-theme.css"
import $ from 'jquery';
import { startOfWeek, addDays, format } from 'date-fns';
import getUserData from '../../route/CheckRouters/token/Token'
import Payment from '../../components/Card/Payment';

const Booking = () => {
  const currentDate = new Date();
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
  const [activeHourIndex, setActiveHourIndex] = useState(0);
  const [services, setServices] = useState([]);
  const [doctors, setDoctors] = useState([]);
  const [doctor, setDoctor] = useState([]);
  const [days, setDays] = useState([]);
  const [doctorId, setDoctorId] = useState();
  const [searchName, setSearchName] = useState('');
  const [slots, setSlots] = useState([]);
  const [schedules, setSchedules] = useState([]);
  const [scheduleId, setScheduleId] = useState(0);
  const [slotId, setSlotId] = useState(0);
  const [slotName, setSlotName] = useState('');
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [modalData, setModalData] = useState(null);
  // Khởi tạo state cho ngày
  const [day, setDay] = useState(`${currentMonth}, ${currentYear}`);
  const [daySelected, setDaySelected] = useState('');
  const loadDepartments = async () => {
    const fetchedDepartments = await axios.get('http://localhost:8080/api/department/all');
    setServices(fetchedDepartments.data);
  };

  const loadDoctors = async () => {
    const fetchedDoctors = await axios.get('http://localhost:8080/api/doctor/all');
    setDoctors(fetchedDoctors.data);
    const id = fetchedDoctors.data[0].id;
    setActiveDoctorIndex(id);
    try {
      const fetchedDoctor = await axios.get('http://localhost:8080/api/doctor/' + id);
      setDoctor(fetchedDoctor.data)
    } catch (error) {

    }
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
      if (ngay.toDateString() === ngayHienTai.toDateString()) {
        activeDayIndex = i;
      }
    }
    setActiveDayIndex(activeDayIndex);
    setDays(cacNgayTrongTuan);
  }

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
    loadSlots();
  }, []);


  // Hàm tìm department của bác sỹ khám bệnh
  const handleServiceClick = async (index) => {

    setActiveIndex(index);
    try {
      const fetchedDoctorDepartment = await axios.get('http://localhost:8080/api/doctor/related-doctor/' + index);
      setDoctors(fetchedDoctorDepartment.data)
    } catch (error) {

    }
  }
  const loadSlots = async () => {
    try {
      const fetchedSclots = await axios.get('http://localhost:8080/api/slot/all');
      setSlots(fetchedSclots.data)
    } catch (error) {

    }
  }
  const handleDayClick = async (index, day) => {
    if (doctorId == null) {
      alert('Vui lòng chọn bác sỹ trước khi chọn ngày')
      return;
    }
    const dayvalue = `${day.nam}-${String(day.thang).padStart(2, '0')}-${String(day.ngayOfMonth).padStart(2, '0')}`;
    setActiveDayIndex(index);
    setDaySelected(dayvalue);
    const data = {
      doctorId: doctorId,
      day: dayvalue
    }
    try {
      const fetchedSlotByDoctorAndDay = await axios.get(`http://localhost:8080/api/schedules/doctor/${data.doctorId}/day/${data.day}`);
      if (fetchedSlotByDoctorAndDay.status === 200) {
        setSchedules(fetchedSlotByDoctorAndDay.data)
      } else if (fetchedSlotByDoctorAndDay.status === 404) {
        setSchedules([])
      }

    } catch (error) {
      if (error.response && error.response.status === 404) {
        setSchedules([]);
      } else {
        console.error('An error occurred:', error);
      }
    }
  }
  console.log(schedules)

  const formatDate = (index) => {
    return format(Date(index), 'dd MMMM, yyyy')
  }

  const isSlotAvailable = (slot) => {
    const scheduleList = schedules;
    return scheduleList.find(schedule => schedule.slotName === slot);
  }

  // Tìm dữ liệu của 1 bác sỹ
  const handleDoctorClick = async (index) => {
    setDoctorId(index);
    setActiveDoctorIndex(index);
    try {
      const fetchedDoctor = await axios.get('http://localhost:8080/api/doctor/' + index);
      setDoctor(fetchedDoctor.data)
    } catch (error) {

    }
  }

  const handleSearch = async (event) => {
    setSearchName(event.target.value);
    if (event.target.value) {
      const response = await axios.get(`http://localhost:8080/api/doctor/search?name=${event.target.value}`);
      setDoctors(response.data);
    }
  }
  const handleSlotClick = (slotId, id, slotName) => {
    setSlotId(slotId);
    setScheduleId(id);
    setActiveHourIndex(slotId);
    setSlotName(slotName);
  }
  console.log(doctor)
  const handleSubmitBook = () => {
    if (!getUserData) {
      alert('Vui lòng đăng nhập để sử dụng chức năng này!');
      return;
    } 
    const data = {
      patientId: getUserData.user.id,
      patientName: getUserData.user.fullName,
      doctorTitle: doctor.title,
      doctorName: doctor.fullName,
      scheduleId: scheduleId,
      dayselect: formatDate(daySelected),
      slotName: slotName,
      price: doctor.price,
      day: daySelected,
      payment: '',
      status: 'success',
    }
    console.log(data);
    setModalData(data);
    setIsModalOpen(true);

  }

  const RatingStar = ({ rating }) => {
    const fullStar = '★';
    const emptyStar = '☆';

    const stars = Array(5)
      .fill(emptyStar)
      .map((star, index) => index < rating ? fullStar : emptyStar);

    return (
      <div>
        {stars.join(' ')}
      </div>
    );
  };

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
                  <input type="text" placeholder='Search doctor' className='booking__search-input'
                    name='searchName'
                    onChange={handleSearch} />
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
                      <div key={item.id} className={`service__item ${activeIndex === item.id ? 'active' : ''}`} onClick={() => handleServiceClick(item.id)}>
                        <img src={"http://localhost:8080/images/department/" + item.icon} alt="" className='service__item-img' />
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
                              <img src={"http://localhost:8080/images/doctors/" + item.image} alt="" className='img-fluid' />
                            </div>
                            <div className='doctr_info'>
                              <div>
                                <div className='name'>{item.title} {item.fullName}</div>
                                <div className='department'>{item.department?.name}</div>
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
                        <div key={i} className={`day_item ${activeDayIndex === i ? 'active' : ''}`} onClick={() => handleDayClick(i, day)}>
                          <span className='day-title'>{day.tenThu}</span>
                          <span className='day-number'>{day.ngayOfMonth}</span>
                        </div>
                      )
                      )}
                    </div>
                    <div className="body_date">
                      {slots.map((slot, index) => {
                        const matchedSchedule = isSlotAvailable(slot.name);
                        return (
                          <div
                            key={index}
                            className={`hour_item ${matchedSchedule ? '' : 'disabled'} ${activeHourIndex === slot.id ? 'active' : ''}`}
                            onClick={() => matchedSchedule && handleSlotClick(slot.id, matchedSchedule.id, slot.name)}
                            data-id="{matchedSchedule.id}"
                          >
                            <div>{slot.name}</div>
                          </div>
                        );
                      })}
                    </div>
                    <div className="footer_date">
                      <div className="date_view">
                        <div className='date_view_day'><span>{formatDate(daySelected)}</span> | <span className='hour'>{slotName}</span></div>
                        <div className='btn__booking-appointment' onClick={handleSubmitBook}  data-bs-toggle="modal" data-bs-target="#exampleModal">
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
              <img src={`http://localhost:8080/images/doctors/${doctor.image}`} alt="" className='img__doctor' />
              <div className="doctor_info">
                <div className='name'>{doctor.title} {doctor.fullName}</div>
                <div className='department'>{doctor.department?.name}</div>
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
              {doctor.biography && doctor.biography ? (
                <div className="content">
                  {doctor.biography} <a href="#">Read more</a>
                </div>
              ) : (
                <p>Thông tin đang cập nhật</p>
              )}
            </div>
            <div className="feedback">
              <div className="title">Feedback</div>
              {doctor.feedbackDtoList && doctor.feedbackDtoList ? (
                doctor.feedbackDtoList.slice(0, 2).map((item) => (
                  <div className="feedback_content" key={item.id}>
                    <div className='feedback__title'>
                      <img src={`http://localhost:8080/images/patients/${item.patient.image}`} alt="" className='img-fluid' />
                      <div className='name__rate'>
                        <div className='name'>{item.patient.fullName}</div>
                        <div className='rate'>
                          <RatingStar rating={item.rate} className='icon' />
                          <div>({item.rate})</div>
                        </div>
                      </div>
                    </div>
                    <div className='feedback__content'>
                      <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Quia culpa illo corrupti ipsam hic, ratione nihil saepe labore qui</p>
                    </div>
                  </div>
                ))
              ) : (
                <p>Thông tin đang cập nhật</p>
              )}
            </div>
          </div>
        </div>
      </div>
      {isModalOpen && <Payment data={modalData} isOpen={isModalOpen} onClose={() => setIsModalOpen(false)} />}
    </section>
  )
}

export default Booking