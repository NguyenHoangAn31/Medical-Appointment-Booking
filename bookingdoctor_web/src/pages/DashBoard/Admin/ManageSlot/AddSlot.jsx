import React, { useState } from 'react'
import {
    Button,
    Form,
    Input,
    Space,
    TimePicker,
} from 'antd';
import { Link } from 'react-router-dom';
import { LeftOutlined } from '@ant-design/icons';
import { addSlot } from '../../../../services/API/slotService';
import openAlert from '../../../../components/Layouts/DashBoard/openAlert';

const layout = {
    labelCol: {
        span: 8,
    },
    wrapperCol: {
        span: 16,
    },
};
const tailLayout = {
    wrapperCol: {
        offset: 8,
        span: 16,
    },
};
function AddSlot() {

    const [slot, setSlot] = useState({
        name: '',
    });

    const [form] = Form.useForm();

    //thông báo
    const [openNotificationWithIcon, contextHolder] = openAlert();

    const onInputChange = (name, value) => {
        setSlot({ ...slot, [name]: value });
    };
    //reset field
    const onReset = () => {
        form.resetFields();
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

            {/* <Link to={`/dashboard/admin/manage-slot`}><LeftOutlined /> Back To Slot</Link> */}
            <h2>Add New Slot</h2>

            <Form
                {...layout}
                form={form}
                name="control-hooks"
                onFinish={handleFormSubmit}
                style={{
                    maxWidth: 600,
                    marginTop: '45px'
                }}
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


                <Form.Item {...tailLayout}>
                    <Space>
                        <Button type="primary" htmlType="submit">
                            Submit
                        </Button>
                        <Button htmlType="button" onClick={onReset}>
                            Reset
                        </Button>
                    </Space>
                </Form.Item>
            </Form>
        </>
    )
}

export default AddSlot