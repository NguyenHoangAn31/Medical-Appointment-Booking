import React, { useContext, useState } from 'react'
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
import { addDepartment } from '../../../../services/API/departmentService';
import { AlertContext } from '../../../../components/Layouts/DashBoard';


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
const normFile = (e) => {
  if (Array.isArray(e)) {
    return e;
  }
  return e?.fileList;
};
function AddDepartment() {

  const navigate = useNavigate();

  // thông báo
  const Alert = useContext(AlertContext);
  // state cho department
  const [department, setDepartment] = useState({
    name: '',
    status: '1',
    url: ''
  });
  // state cho icon
  const [icon, setIcon] = useState('');

  const [form] = Form.useForm();


  // cập nhật thay đổi giá trị cho departmnet
  const onInputChangeForDepartment = (name, value) => {
    console.log(icon)

    setDepartment({ ...department, [name]: value });
  };

  // cập nhật thay đổi giá trị cho icon
  const onInputChangeForIcon = (value) => {
    console.log(value)
    setIcon(value);
  }
  // reset field
  const onReset = () => {
    form.resetFields();
  };

  // xử lý submit
  const handleFormSubmit = async () => {
    try {
      const formData = new FormData()
      formData.append('icon', icon)
      formData.append('department', JSON.stringify((department)))
      await addDepartment(formData);
      Alert('success', 'Add New Department Successfully', '')
      navigate("/dashboard/admin/manage-department");

    }
    catch (error) {
      console.log(error)
      Alert('error', 'Error Creating New Department', '')

    }
  };
  return (
    <>

      {/* <Link to={`/dashboard/admin/manage-slot`}><LeftOutlined /> Back To Slot</Link> */}
      <h2>Add New Department</h2>

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
        <Form.Item label="Name" rules={[
          {
            required: true,
          },
        ]} name="name">
          <Input onChange={(e) => onInputChangeForDepartment('name', e.target.value)} />
        </Form.Item>

        {/* <Form.Item label="Status" rules={[
          {
            required: true,
          },
        ]} name="status">
          <Select onChange={(e) => onInputChangeForDepartment('status', e)} >
            <Select.Option value="1">Active</Select.Option>
            <Select.Option value="0">Not Active</Select.Option>

          </Select>
        </Form.Item> */}

        <Form.Item label="URL" rules={[
          {
            required: true,
          },
        ]} name="url">
          <Input onChange={(e) => onInputChangeForDepartment('url', e.target.value)} />
        </Form.Item>

        <Form.Item label="Icon" valuePropName="fileList" getValueFromEvent={normFile} rules={[
          {
            required: true,
          },
        ]} name="icon">
          <Upload beforeUpload={() => false} listType="picture-card" maxCount={1} onChange={(e) => onInputChangeForIcon(e.file)}>
            <button
              style={{
                border: 0,
                background: 'none',
              }}
              type="button"
            >
              <PlusOutlined />
              <div
                style={{
                  marginTop: 8,
                }}
              >
                Upload
              </div>
            </button>
          </Upload>
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

export default AddDepartment