import React, { useState } from 'react'
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';
import { format } from 'date-fns';
import { addAppointment } from '../../services/API/bookingService';
import axios from 'axios';
import { formatDate } from '../../ultils/formatDate';
import { Input } from 'antd';
import TextArea from 'antd/es/input/TextArea';

const Payment = ({ setActiveHourIndex, setSlotName, setSchedules, isOpen, data, onClose }) => {
    const dateObj = new Date();
    const year = dateObj.getFullYear();
    const month = String(dateObj.getMonth() + 1).padStart(2, '0');
    const day = String(dateObj.getDate()).padStart(2, '0');
    const formattedDate = `${year}-${month}-${day}`;
    const [paymentUrl, setPaymentUrl] = useState('');
    const [paymentMethod, setPaymentMethod] = useState('');

    const [note, setNote] = useState('')
    const handleChangeContent = (value) => {
        setNote(value)
    }
    const handlePaymentChange = async (method) => {
        setPaymentMethod(method);
        if(method === 'vnpay'){
            try {
                const response = await axios.get('http://localhost:8080/api/payment/create_payment_url', {
                    params: {
                        amount: data?.price * 0.3, // Số tiền cần thanh toán
                        orderType: 'billpayment',
                        returnUrl: 'http://localhost:5173/proccess-payment',
                    },
                });
                setPaymentUrl(response.data.url);
            } catch (error) {
                console.error('Error creating payment URL:', error);
            }
        }else if(method === 'paypal'){
            const paymentResponse = await axios.post('http://localhost:8080/paypal/pay', null, {
                params: {
                    sum: (data.price * 0.3) / 25455, // Số tiền thanh toán
                },
            });

            // Chuyển hướng người dùng sang trang thanh toán của PayPal
            setPaymentUrl(paymentResponse.data);
        }else{
            console.log('Payment method is not recognized, handle accordingly');
        }
    }

    console.log(paymentUrl)

    const handleSubmitBook = async () => {
        data.price = data.price * 0.3;
        data.note = note
        data.appointmentDate = formattedDate
        data.payment = paymentMethod
        // 
        try {
            // Đặt lịch hẹn
            await addAppointment(data);
            window.location.href = paymentUrl;
            
        } catch (error) {
            console.log(error);
        }
    };
    

    return (
        <Modal show={isOpen} onHide={onClose}
            aria-labelledby="contained-modal-title-vcenter"
            centered
        >
            <Modal.Header closeButton>
                <Modal.Title>Medical Examination Schedule Information
                </Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <p>Patient Name : {data?.partientName}</p>
                <p>Doctor Name :  {data?.doctorTitle} {data?.doctorName}</p>
                <p>Medical Examination Price : {data?.price} VNĐ</p>
                <p>Medical Examination Day : {formatDate(data?.medicalExaminationDay)}</p>
                <p>Medical Examination Hours : {data?.clinicHours}</p>
                <p>Amount To Be Paid To Reserve A Place : {data?.price * 0.3} VNĐ</p>
                <div>
                    <span>Note</span>
                    <TextArea value={note} onChange={(e) => handleChangeContent(e.target.value)} rows={4} />
                </div>
                <p>Select A Payment Method : </p>

                <div className='payment_choose'>
                    <div className=''>
                        <input type="radio" name="payment" id="vnpay_check" onClick={() => handlePaymentChange('vnpay')} />
                        <label htmlFor="vnpay_check"><img src="/images/vnpay.png" alt="" className='img_payment' /></label>
                    </div>
                    <div className=''>
                        <input type="radio" name="payment" id="paypal_check" onClick={() => handlePaymentChange('paypal')} />
                        <label htmlFor="paypal_check"><img src="/images/paypal.png" alt="" className='img_payment'/></label>
                    </div>
                </div>

            </Modal.Body>
            <Modal.Footer>
                <Button variant="secondary" onClick={onClose}>
                    Close
                </Button>
                <Button variant="primary" onClick={handleSubmitBook}>
                    Thanh toán để hoàn tất booking
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default Payment