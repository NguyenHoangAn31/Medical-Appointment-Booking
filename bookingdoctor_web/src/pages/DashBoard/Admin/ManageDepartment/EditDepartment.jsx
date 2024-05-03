import React, { useContext, useEffect, useState } from 'react'
import {
  Button,
  Form,
  Image,
  Input,
  Select,
  Space,
  TimePicker,
  Upload,
} from 'antd';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { LeftOutlined, PlusOutlined, SoundTwoTone } from '@ant-design/icons';
import { findDepartmentById } from '../../../../services/API/departmentService';
import { updateDepartment } from '../../../../services/API/departmentService';
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

function EditDepartment() {
  const navigate = useNavigate();

  // thông báo
  const Alert = useContext(AlertContext);
  // lấy id từ url
  const { id } = useParams();

  // khởi tạo đối tượng department
  const [department, setDepartment] = useState({ name: '', status: '', url: '' });
  // state cho icon
  const [icon, setIcon] = useState(null);

  const { name, status, url } = department;


  // gọi hàm loadDepartments 1 lần
  useEffect(() => {
    loadDepartment();
  }, []);

  // xét giá trị cho department
  const loadDepartment = async () => {
    setDepartment(await findDepartmentById(id));
    console.log(department.icon)

  };

  // cập nhật thay đổi giá trị cho departmnet
  const onInputChangeForDepartment = (name, value) => {
    setDepartment({ ...department, [name]: value });
    // console.log(department)
  };

  // cập nhật thay đổi giá trị cho icon
  const onInputChangeForIcon = (value) => {
    setIcon(value);
  }

  // hàm submit 
  const handleFormSubmit = async () => {
    try {
      const formData = new FormData()
      formData.append('icon', icon)
      formData.append('department', JSON.stringify((department)))
      await updateDepartment(id, formData);
      Alert('success', 'Editing Department Successfully', '')
      navigate("/dashboard/admin/manage-department");
      window.location.reload();

    }
    catch (error) {
      console.log(error)
      Alert('error', 'Error Editing Department', '')
    }

  };
  return (
    <>
      {/* <Link to={`/dashboard/admin/manage-department`}><LeftOutlined /> Back To Department</Link> */}
      <h2>Edit Department</h2>

      <Form
        {...layout}
        name="control-hooks"
        onFinish={handleFormSubmit}
        style={{
          maxWidth: 600,
          marginTop: '45px'
        }}
      >

        <Form.Item label="Name">
          <Input value={name} onChange={(e) => onInputChangeForDepartment('name', e.target.value)} />
        </Form.Item>

        <Form.Item label="URL">
          <Input value={url} onChange={(e) => onInputChangeForDepartment('url', e.target.value)} />
        </Form.Item>

        <Form.Item label="Status" name="status">
          <Select placeholder="Select Status" onChange={(e) => onInputChangeForDepartment('status', e)} >
            <Select.Option value="1">Active</Select.Option>
            <Select.Option value="0">Not Active</Select.Option>
          </Select>
        </Form.Item>

        {department.icon ?
          <Form.Item label="Image">
            <Image
              width={200}
              src={"http://localhost:8080/images/department/" + department.icon}
            /></Form.Item>: <></>
        }
        <Form.Item label="Select Image" valuePropName="fileList" getValueFromEvent={normFile}>
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
          </Space>
        </Form.Item>
      </Form>
    </>
  )
}

export default EditDepartment