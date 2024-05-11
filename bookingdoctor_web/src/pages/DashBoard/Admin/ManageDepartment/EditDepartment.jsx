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
import { Link, useLocation, useNavigate, useParams } from 'react-router-dom';
import { LeftOutlined, PlusOutlined, SoundTwoTone } from '@ant-design/icons';
import { findDepartmentById } from '../../../../services/API/departmentService';
import { updateDepartment } from '../../../../services/API/departmentService';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
import Spinner from '../../../../components/Spinner';


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
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const id = queryParams.get("id");

  // khởi tạo đối tượng department
  const [department, setDepartment] = useState({});
  // state cho icon
  const [icon, setIcon] = useState(null);


  // gọi hàm loadDepartments 1 lần
  useEffect(() => {
    loadDepartment();
  }, []);

  // xét giá trị cho department
  const loadDepartment = async () => {
    setDepartment(await findDepartmentById(id));

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
    }
    catch (error) {
      console.log(error)
      Alert('error', 'Error Editing Department', '')
    }
  };

  return (
    <>
      {Object.keys(department).length == 0 ? <Spinner /> : <> <h2>Edit Department - {department.status != null ?
        department.status == 0 ? <span style={{ color: 'red' }}>Not Active</span> : <span style={{ color: 'rgb(82, 196, 26)' }}>Active</span>
        : <></>
      }</h2>

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
            <Input value={department.name} onChange={(e) => onInputChangeForDepartment('name', e.target.value)} required />
          </Form.Item>

          <Form.Item label="URL">
            <Input value={department.url} onChange={(e) => onInputChangeForDepartment('url', e.target.value)} required />
          </Form.Item>



          {/* <Form.Item label="Select Status" name="status">
            <Select placeholder="Select Status" onChange={(e) => onInputChangeForDepartment('status', e)} >
              <Select.Option value="1">Active</Select.Option>
              <Select.Option value="0">Not Active</Select.Option>
            </Select>
          </Form.Item> */}

          {department.icon ?
            <Form.Item label="Icon">
              <Image
                width={100}
                src={"http://localhost:8080/images/department/" + department.icon}
              /></Form.Item> : <></>
          }
          <Form.Item label="Select Icon" valuePropName="fileList" getValueFromEvent={normFile}>
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
        </Form></>}

    </>
  )
}

export default EditDepartment