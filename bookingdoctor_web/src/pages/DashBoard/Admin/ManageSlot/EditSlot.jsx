import React, { useEffect, useState } from 'react'
import {
  Button,
  Form,
  Input,
  TimePicker,
} from 'antd';
import { Link, useParams } from 'react-router-dom';
import { LeftOutlined } from '@ant-design/icons';
import { findSlotById } from '../../../../services/API/slotService';
import { updateSlot } from '../../../../services/API/slotService';
import openAlert from '../../../../components/Layouts/DashBoard/openAlert';


const layout = {
  labelCol: {
    span: 8,
  },
  wrapperCol: {
    span: 16,
  },
};

function EditSlot() {
  // lấy id từ url
  const { id } = useParams();

  // khởi tạo đối tượng slot
  const [slot, setSlot] = useState({ name: '' });
  // khởi tạo đối tượng slot kiểm tra sự thay đổi
  const [initialSlot, setInitialSlot] = useState({ name: '' });

  const { name } = slot;

  // thông báo
  const [openNotificationWithIcon, contextHolder] = openAlert();

  // hàm cập nhật giá trị cho đối tượng slot môi khi input thay đổi
  const onInputChange = (name, value) => {
    console.log(value)
    setSlot({ ...slot, [name]: value });
  };

  // gọi hàm loadSlots 1 lần
  useEffect(() => {
    loadSlots();
  }, []);

  // xét giá trị cho 2 đối tượng slot và initialSlot
  const loadSlots = async () => {
    setSlot(await findSlotById(id));
    setInitialSlot(await findSlotById(id));
  };

  // hàm submit 
  const handleFormSubmit = async () => {
    if (JSON.stringify(slot) !== JSON.stringify(initialSlot)) {
      try {
        await updateSlot(id, slot);
        setInitialSlot(await findSlotById(id));
        openNotificationWithIcon('success', 'Editing Slot Successfully', '')
      }
      catch (error) {
        console.log(error)
        openNotificationWithIcon('error', 'Error Editing Slot', '')
      }
    }
  };
  return (
    <>
      {contextHolder}
      {/* <Link to={`/dashboard/admin/manage-slot`}><LeftOutlined /> Back To Slot</Link> */}
      <h2>Edit Slot</h2>

      <Form
        {...layout}
        name="control-hooks"
        onFinish={handleFormSubmit}
        style={{
          maxWidth: 600,
          marginTop: '45px'
        }}
      >

        <Form.Item
          label="Time"
        >
          <TimePicker format="HH:mm" onChange={(e) => { if (e != null) { onInputChange("name", e.format('HH:mm')) } else { onInputChange("name", name) } }} />
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

export default EditSlot