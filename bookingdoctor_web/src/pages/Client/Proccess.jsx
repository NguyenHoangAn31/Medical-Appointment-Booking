import React, { useEffect, useState } from 'react';
import { useLocation } from 'react-router-dom';
import axios from 'axios';

const Proccess = () => {
    const location = useLocation();
  const [message, setMessage] = useState('Đang xử lý thanh toán...');

  useEffect(() => {
    const queryParams = new URLSearchParams(location.search);
    axios.get('http://localhost:8080/payment_return', { params: queryParams })
      .then(response => {
        setMessage(response.data);
      })
      .catch(error => {
        setMessage('Thanh toán thất bại: ' + error.response.data);
      });
  }, [location.search]);
  return (
    <div className='container mt-5'>
        <div className="row">
            <div className="col-md-6">

            </div>
            <div className="col-md-6">
                <h2>Kết quả thanh toán</h2>
                <p>{message}</p>
            </div>
        </div>
      
    </div>
  )
}

export default Proccess