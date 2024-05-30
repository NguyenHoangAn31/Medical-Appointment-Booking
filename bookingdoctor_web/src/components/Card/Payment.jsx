import React from 'react'
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';
import { format } from 'date-fns';
import { addAppointment } from '../../services/API/bookingService';
import axios from 'axios';

const Payment = ({ setSchedules, isOpen, data, onClose }) => {
    const formatDay = (index) => {
        return format(Date(index), 'dd/MM/yyyy')
    }
    const handleSubmitBook = async () => {
        data.price = data.price * 0.3;
        try {
            await addAppointment(data);
            const response = await axios.get(`http://localhost:8080/api/schedules/doctor/${data.doctorId}/day/${data.bookingDate}`);
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
                <p>Bệnh nhân: {data?.patientName}</p>
                <p>Bác sỹ Khám:  {data?.doctorTitle} {data?.doctorName}</p>
                <p>Giá khám bệnh: {data?.price} VNĐ</p>
                <p>Ngày khám bệnh: {formatDay(data?.dayselect)}</p>
                <p>Giờ khám bệnh: {data?.slotName}</p>
                <p>Số tiền cầm thanh toán giữ chỗ: {data?.price * 0.3} VNĐ</p>
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