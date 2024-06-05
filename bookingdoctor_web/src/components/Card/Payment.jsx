import React, { useState } from 'react'
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';
import { format } from 'date-fns';
import { addAppointment } from '../../services/API/bookingService';
import axios from 'axios';
import { formatDate } from '../../ultils/formatDate';
import { Input } from 'antd';
import TextArea from 'antd/es/input/TextArea';

const Payment = ({ setSchedules, isOpen, data, onClose }) => {
    const dateObj = new Date();
    const year = dateObj.getFullYear();
    const month = String(dateObj.getMonth() + 1).padStart(2, '0');
    const day = String(dateObj.getDate()).padStart(2, '0');
    const formattedDate = `${year}-${month}-${day}`;

    const [note,setNote] = useState('')
    const handleChangeContent = (value)=>{
        setNote(value)
    }
    const handleSubmitBook = async () => {
        data.price = data.price * 0.3;
        data.note = note
        data.appointmentDate = formattedDate
        try {
            await addAppointment(data);
            const response = await axios.get(`http://localhost:8080/api/schedules/doctor/${data.doctorId}/day/${data.medicalExaminationDay}`);
            setSchedules(response.data);
            onClose();
            alert('Booking successfully');
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
                <Modal.Title>Thông tin lịch book khám bệnh</Modal.Title>
            </Modal.Header>
            <Modal.Body>
                <p>Bệnh nhân: {data?.partientName}</p>
                <p>Bác sỹ Khám:  {data?.doctorTitle} {data?.doctorName}</p>
                <p>Giá khám bệnh: {data?.price} VNĐ</p>
                <p>Ngày khám bệnh: {formatDate(data?.medicalExaminationDay)}</p>
                <p>Giờ khám bệnh: {data?.clinicHours}</p>
                <p>Số tiền cầm thanh toán giữ chỗ: {data?.price * 0.3} VNĐ</p>
                <div>
                    <span>note</span>
                    <TextArea value={note} onChange={(e)=>handleChangeContent(e.target.value)} rows={4} />
                </div>
                <p>Chọn phương thức thanh toán:</p>
                <Button variant="primary" className='me-3' onClick={() => handlePayment('VNPay')}>
                    VN Pay
                </Button>

                <Button variant="primary" className='me-3' onClick={() => handlePayment('Momo')}>
                    Momo
                </Button>
                <Button variant="primary" onClick={() => handlePayment('PayPal')}>
                    PayPal
                </Button>
            </Modal.Body>
            <Modal.Footer>
                <Button variant="secondary" onClick={onClose}>
                    Close
                </Button>
                <Button variant="primary" onClick={handleSubmitBook}>
                    Book Now (dùng để test chưa có chức năng thanh toán)
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default Payment