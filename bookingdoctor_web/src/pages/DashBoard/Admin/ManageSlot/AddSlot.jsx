import React, { useState } from 'react'
import {
    Button,
    Form,
    Input,
    TimePicker,
} from 'antd';
import { Link } from 'react-router-dom';
import { LeftOutlined } from '@ant-design/icons';
import { addSlot } from '../../../../services/API/slotService';
import openAlert from '../../../../components/Layouts/DashBoard/openAlert';

const formItemLayout = {
    labelCol: {
        xs: {
            span: 24,
        },
        sm: {
            span: 6,
        },
    },
    wrapperCol: {
        xs: {
            span: 24,
        },
        sm: {
            span: 14,
        },
    },
};

function AddSlot() {

    const [slot, setSlot] = useState({
        name: '',
    });
    //thông báo
    const [openNotificationWithIcon, contextHolder] = openAlert();

    const onInputChange = (name, value) => {
        setSlot({ ...slot, [name]: value });
    };


    const handleFormSubmit = async () => {
        try {
            await addSlot(slot);
            openNotificationWithIcon('success', 'Add New Slot Successfully', '')
        }
        catch (error) {
            console.log(error)
            openNotificationWithIcon('error', 'Error Creating New Slot', '')

        }
    };
    return (
        <>
            {contextHolder}

            <Link to={`/dashboard/admin/manage-slot`}><LeftOutlined /> Back To Slot</Link>
            <h1 className='mb-3'>Create New Slot</h1>

            <Form
                {...formItemLayout}
                variant="filled"
                style={{
                    maxWidth: 600,
                }}
                onFinish={handleFormSubmit}
            >
                <Form.Item
                    label="Time"
                    name="name"
                    rules={[
                        {
                            required: true,
                            message: 'Please select time!',
                        },
                    ]}
                >
                    <TimePicker format="HH:mm" onChange={(e) => onInputChange("name", e.format('HH:mm'))} />
                </Form.Item>


                <Form.Item
                    wrapperCol={{
                        offset: 6,
                        span: 16,
                    }}
                >
                    <Button type="primary" htmlType="submit">
                        Submit
                    </Button>
                </Form.Item>
            </Form>
        </>
    )
}

export default AddSlot