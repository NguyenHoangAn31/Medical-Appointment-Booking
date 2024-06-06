// eslint-disable-next-line no-unused-vars
import React from 'react'
// eslint-disable-next-line no-unused-vars
import { Link } from 'react-router-dom';
import { PlusOutlined } from '@ant-design/icons';
import { Button, } from 'antd';

function Schedule() {
  return (
    <>
      <Button
        type="primary"
        icon={<PlusOutlined />}
        style={{ backgroundColor: '#52c41a' }}
      // onClick={handleCreateWorking}
      >
        Add New Schedule
      </Button>
    </>
  )
}

export default Schedule