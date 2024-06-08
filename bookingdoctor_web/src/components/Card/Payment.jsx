import React, { useState } from 'react'
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';
import { format } from 'date-fns';
import { addAppointment } from '../../services/API/bookingService';
import axios from 'axios';
import { formatDate } from '../../ultils/formatDate';
import { Input } from 'antd';
import TextArea from 'antd/es/input/TextArea';

const Payment = ({ setActiveHourIndex , setSlotName , setSchedules, isOpen, data, onClose }) => {
    const dateObj = new Date();
    const year = dateObj.getFullYear();
    const month = String(dateObj.getMonth() + 1).padStart(2, '0');
    const day = String(dateObj.getDate()).padStart(2, '0');
    const formattedDate = `${year}-${month}-${day}`;

    const [note, setNote] = useState('')
    const handleChangeContent = (value) => {
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
            setActiveHourIndex('');
            setSlotName('');
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
                    Book Now (test function)
                </Button>
            </Modal.Footer>
        </Modal>
    )
}

export default Payment