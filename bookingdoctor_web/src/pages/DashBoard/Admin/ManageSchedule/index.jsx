import React, { useEffect, useRef, useState } from 'react';
import Calendar from 'react-calendar';
import { useNavigate } from 'react-router-dom';
import { findAllWorkDay } from '../../../../services/API/scheduleService';
// import 'react-calendar/dist/Calendar.css';


function ManageSchedule() {
  const [value, setValue] = useState(new Date());
  const [workDay, setWorkDay] = useState([]);
  const [calendarRendered, setCalendarRendered] = useState(false);
  const navigate = useNavigate();
  const isFirstRender = useRef(true);

  useEffect(() => {
    if (!isFirstRender.current) {
      setValue(new Date());
    } else {
      isFirstRender.current = false;
    }
  }, [calendarRendered]);


  useEffect(() => {
    const buttonList = document.querySelectorAll('.react-calendar__navigation>button');
    buttonList.forEach(button => {
      button.addEventListener('click', () => {
        setCalendarRendered(false);
      });
    });
    loadWorkDay();
  }, []);

  const loadWorkDay = async () => {
    setWorkDay(await findAllWorkDay())
  };


  const formattedDates = Object.fromEntries(
    Object.entries(workDay).map(([dateString, status]) => {
      const dateObj = new Date(dateString);
      const options = { month: 'long', day: 'numeric', year: 'numeric' };
      const formattedDate = dateObj.toLocaleDateString('en-US', options);
      return [formattedDate, status];
    })
  );


  useEffect(() => {
    const renderedDates = document.querySelectorAll('.react-calendar__month-view__days__day abbr');
    renderedDates.forEach((dateElement) => {
      const dateValue = dateElement.getAttribute('aria-label');
      const buttonElement = dateElement.parentElement;
      if (formattedDates[dateValue]) {
        buttonElement.style.color = '#7dff79';
      }
    });
  }, [value, workDay]);




  const handleChange = (newValue) => {
    setValue(newValue);
    const dateObj = new Date(newValue);
    const year = dateObj.getFullYear();
    const month = String(dateObj.getMonth() + 1).padStart(2, '0');
    const day = String(dateObj.getDate()).padStart(2, '0');
    let status = '';

    const formattedDate = `${year}-${month}-${day}`;

    for (const [date, state] of Object.entries(workDay)) {
      if (date === formattedDate) {
        status = state;
        break;
      }
    }

    navigate(`/dashboard/admin/manage-schedule/detail?day=${formattedDate}&status=${status}`);
  };



  return (
    <div className='calendar'>
      <Calendar onChange={handleChange} value={value} onActiveStartDateChange={() => setCalendarRendered(true)} />
    </div>

  );
}

export default ManageSchedule;
