import React from 'react'
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';
import { format } from 'date-fns';

const Payment = ({ isOpen, data, onClose }) => {
    const formatDay = (index) => {
        return format(Date(index), 'dd/MM/yyyy')
      }
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
                <p>Số tiền cầm thanh toán giữ chỗ: {data?.price* 0.3} VNĐ</p>
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
            </Modal.Footer>
        </Modal>
    )
}

export default Payment