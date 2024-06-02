import React, { useContext, useState } from 'react';
import ReactQuill from 'react-quill';
import 'react-quill/dist/quill.snow.css';

import {
  Button,
  Form,
  Input,
  Select,
  Space,
  TimePicker,
  Upload,
} from 'antd';
import { Link, useNavigate } from 'react-router-dom';

import { LeftOutlined, PlusOutlined } from '@ant-design/icons';
import { addNews } from '../../../../services/API/news';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import getUserData from '../../../../route/CheckRouters/token/Token';
import { createUser } from '../../../../services/API/userService';

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

function AddUser() {
  const { currentUser } = useContext(AlertContext);

  const navigate = useNavigate();

  // thông báo
  const { openNotificationWithIcon } = useContext(AlertContext);
  // state cho user
  const [user, setUser] = useState({status:1,provider:'phone',keyCode:null});

  const [form] = Form.useForm();


  // cập nhật thay đổi giá trị cho user
  const onInputChangeForUser = (name, value) => {

    setUser({ ...user, [name]: value });

  };

  console.log(user)

  // reset field
  const onReset = () => {
    form.resetFields();
  };

  // xử lý submit
  const handleFormSubmit = async () => {
    try {
      await createUser(user);
      openNotificationWithIcon('success', 'Add New User Successfully', '')
      navigate("/dashboard/admin/manage-user");

    }
    catch (error) {
      console.log(error)
      openNotificationWithIcon('error', 'Error Creating New User', '')

    }
  };
  return (
    <>

      {/* <Link to={`/dashboard/admin/manage-slot`}><LeftOutlined /> Back To Slot</Link> */}
      <h2>Add New User</h2>

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

        <Form.Item label="Email" rules={[
          {
            required: true,
          },
        ]} name="email">
          <Input onChange={(e) => onInputChangeForUser('email', e.target.value)} />
        </Form.Item>

        <Form.Item label="Phone" rules={[
          {
            required: true,
          },
        ]} name="phone">
          <Input onChange={(e) => onInputChangeForUser('phone', e.target.value)} />
        </Form.Item>


        <Form.Item label="Full Name" rules={[
          {
            required: true,
          },
        ]} name="fullName">
          <Input onChange={(e) => onInputChangeForUser('fullName', e.target.value)} />
        </Form.Item>

        {/* <Form.Item label="Select Role" name="roles" rules={[
          {
            required: true,
          }]}>
          <Select placeholder="Select Role" onChange={(e) => onInputChangeForUser('roles', e)} >
            <Select.Option value="ADMIN">Admin</Select.Option>
            <Select.Option value="DOCTOR">Doctor</Select.Option>
            <Select.Option value="USER">User</Select.Option>
          </Select>
        </Form.Item> */}

        <Form.Item label="Select Role" name="roleId" rules={[
          {
            required: true,
          }]}>
          <Select placeholder="Select Role" onChange={(e) => onInputChangeForUser('roleId', e)}>
            {/* <Select.Option value="1">User</Select.Option> */}
            <Select.Option value="2">Doctor</Select.Option>
            <Select.Option value="3">Admin</Select.Option>
          </Select>
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

export default AddUser