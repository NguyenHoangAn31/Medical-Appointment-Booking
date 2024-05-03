import React, { useContext, useEffect, useRef, useState } from 'react';
import { PlusOutlined, SearchOutlined } from '@ant-design/icons';
import { Button, Input, Popconfirm, Space, Spin, Table } from 'antd';
import Highlighter from 'react-highlight-words';
import { getAllSlot, deleteSlot } from '../../../../services/API/slotService';
import { Link } from 'react-router-dom';
import Spinner from '../../../../components/Spinner';
import { AlertContext } from '../../../../components/Layouts/DashBoard';
const ManageSlot = () => {
  const Alert = useContext(AlertContext);

  // useState cho search
  const [searchText, setSearchText] = useState('');
  const [searchedColumn, setSearchedColumn] = useState('');
  const searchInput = useRef(null);
  // thông báo
  // const [openNotificationWithIcon, contextHolder] = openAlert();

  // useState cho mảng dữ liệu slots
  const [slots, setSlots] = useState([]);
  // tải dữ liệu và gán vào slots thông qua hàm setSlots
  const loadSlots = async () => {
    const fetchedSlots = await getAllSlot();
    // thêm key vào mỗi slot
    const slotsWithKeys = fetchedSlots.map((slot, index) => ({
      ...slot,
      key: index.toString(),
    }));
    setSlots(slotsWithKeys);
  };
  // thực hiện load dữ liệu 1 lần 
  useEffect(() => {
    loadSlots();
  }, []);
  // xóa record và reload lại và gọi lại hàm reload dữ liệu
  const delete_Slot = async (id) => {
    try {
      await deleteSlot(id);
      loadSlots();
      Alert('success', 'Deletete Successfully', '')
    } catch (error) {
      console.log(error)
    }

  };


  const handleSearch = (selectedKeys, confirm, dataIndex) => {
    confirm();
    setSearchText(selectedKeys[0]);
    setSearchedColumn(dataIndex);
  };
  const handleReset = (clearFilters) => {
    clearFilters();
    setSearchText('');
  };
  const getColumnSearchProps = (dataIndex) => ({
    filterDropdown: ({ setSelectedKeys, selectedKeys, confirm, clearFilters, close }) => (
      <div
        style={{
          padding: 8,
        }}
        onKeyDown={(e) => e.stopPropagation()}
      >
        <Input
          ref={searchInput}
          placeholder={`Search ${dataIndex}`}
          value={selectedKeys[0]}
          onChange={(e) => setSelectedKeys(e.target.value ? [e.target.value] : [])}
          onPressEnter={() => handleSearch(selectedKeys, confirm, dataIndex)}
          style={{
            marginBottom: 8,
            display: 'block',
          }}
        />
        <Space>
          <Button
            type="primary"
            onClick={() => handleSearch(selectedKeys, confirm, dataIndex)}
            icon={<SearchOutlined />}
            size="small"
            style={{
              width: 90,
            }}
          >
            Search
          </Button>
          <Button
            onClick={() => clearFilters && handleReset(clearFilters)}
            size="small"
            style={{
              width: 90,
            }}
          >
            Reset
          </Button>
          <Button
            type="link"
            size="small"
            onClick={() => {
              confirm({
                closeDropdown: false,
              });
              setSearchText(selectedKeys[0]);
              setSearchedColumn(dataIndex);
            }}
          >
            Filter
          </Button>
          <Button
            type="link"
            size="small"
            onClick={() => {
              close();
            }}
          >
            close
          </Button>
        </Space>
      </div>
    ),
    filterIcon: (filtered) => (
      <SearchOutlined
        style={{
          color: filtered ? '#1677ff' : undefined,
        }}
      />
    ),
    onFilter: (value, record) =>
      record[dataIndex].toString().toLowerCase().includes(value.toLowerCase()),
    onFilterDropdownOpenChange: (visible) => {
      if (visible) {
        setTimeout(() => searchInput.current?.select(), 100);
      }
    },
    render: (text) =>
      searchedColumn === dataIndex ? (
        <Highlighter
          highlightStyle={{
            backgroundColor: '#ffc069',
            padding: 0,
          }}
          searchWords={[searchText]}
          autoEscape
          textToHighlight={text ? text.toString() : ''}
        />
      ) : (
        text
      ),
  });
  const columns = [
    {
      title: 'Id',
      dataIndex: 'id',
      key: 'id',
      width: '33.333%',
      ...getColumnSearchProps('id'),
      sorter: (a, b) => a.id - b.id,
    },
    {
      title: 'Time',
      dataIndex: 'name',
      key: 'name',
      width: '33.333%',
      ...getColumnSearchProps('name'),
      sorter: (a, b) => {
        return a.name.localeCompare(b.name);
      },
      sortDirections: ['descend', 'ascend']
    },
    {
      title: 'Action',
      dataIndex: 'operation',
      render: (_, record) => (
        <>
          <Link style={{ marginRight: '16px',color:'blue' }}
            to={`/dashboard/admin/manage-slot/edit/${record.id}`}>Edit</Link>
          {slots.length >= 1 ? (
            <Popconfirm title="Sure to delete?" onConfirm={() => delete_Slot(record.id)}>
              <span style={{color:'red'}}>Delete</span>
            </Popconfirm>
          ) : null}
        </>
      ),
    },
  ];
  return (
    <>
      {slots.length == 0 ? <Spinner/> : <> <Link to="/dashboard/admin/manage-slot/create">
        <Button type="primary" icon={<PlusOutlined />} style={{ float: 'right', marginBottom: '15px' }}>
          Add New Slot
        </Button>
      </Link> <Table columns={columns} dataSource={slots} /></>}
    </>
  )
};




export default ManageSlot;