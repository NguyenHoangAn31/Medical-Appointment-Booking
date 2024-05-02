import React, { useEffect, useRef, useState } from 'react';
import { PlusOutlined, SearchOutlined } from '@ant-design/icons';
import { Button, Input, Popconfirm, Space, Spin, Table, Tag } from 'antd';
import Highlighter from 'react-highlight-words';
import { getAllDepartment, deleteDepartment } from '../../../../services/API/departmentService';
import { Link } from 'react-router-dom';
import openAlert from '../../../../components/Layouts/DashBoard/openAlert';
import Spinner from '../../../../components/Layouts/DashBoard/Spinner';


const ManageDepartment = () => {
  // useState cho search
  const [searchText, setSearchText] = useState('');
  const [searchedColumn, setSearchedColumn] = useState('');
  const searchInput = useRef(null);
  // thông báo
  const [openNotificationWithIcon, contextHolder] = openAlert();

  // useState cho mảng dữ liệu departments
  const [departments, setDepartments] = useState([]);
  // tải dữ liệu và gán vào departments thông qua hàm setDepartments
  const loadDepartments = async () => {
    const fetchedDepartments = await getAllDepartment();
    // thêm key vào mỗi department
    const departmentsWithKeys = fetchedDepartments.map((department, index) => ({
      ...department,
      key: index.toString(),
    }));
    setDepartments(departmentsWithKeys);
  };
  // thực hiện load dữ liệu 1 lần 
  useEffect(() => {
    loadDepartments();
  }, []);
  // xóa record và reload lại và gọi lại hàm reload dữ liệu
  const delete_Department = async (id) => {
    try {
      await deleteDepartment(id);
      loadDepartments();
      openNotificationWithIcon('success', 'Deletete Department Successfully', '')
    } catch (error) {
      openNotificationWithIcon('warning', 'Department is active', '')
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
      width: '16.666%',
      ...getColumnSearchProps('id'),
      sorter: (a, b) => a.id - b.id,
    },
    {
      title: 'Name',
      dataIndex: 'name',
      key: 'name',
      width: '16.666%',
      ...getColumnSearchProps('name'),
      sorter: (a, b) => {
        return a.name.localeCompare(b.name);
      },
      sortDirections: ['descend', 'ascend']
    },    
    {
      title: 'Icon',
      dataIndex: 'icon',
      key: 'icon',
      width: '16.666%'
    }, ,
    {
      title: 'Url',
      dataIndex: 'url',
      key: 'url',
      width: '16.666%'
    },
    {
      title: 'Status',
      dataIndex: 'status',
      key: 'status',
      width: '16.666%',
      render: (_, { status }) => {
        console.log(status)
        let color = status ? 'green' : 'volcano';
        let title = status ? 'Active' : 'Not Active'
        return (
          <Tag color={color} key={title}>
            {title ? title.toUpperCase() : ''}
          </Tag>
        );
      },
    },

    {
      title: 'Action',
      dataIndex: 'operation',
      render: (_, record) => (
        <>
          <Link style={{ marginRight: '16px',color:'blue' }}
            to={`/dashboard/admin/manage-department/edit/${record.id}`}>Edit</Link>
          {departments.length >= 1 ? (
            <Popconfirm title="Sure to delete?" onConfirm={() => delete_Department(record.id)}>
              <span style={{color:'red'}}>Delete</span>
            </Popconfirm>
          ) : null}
        </>
      ),
    },
  ];
  return (
    <>
      {contextHolder}

      {departments.length == 0 ? <Spinner /> : <><Link to="/dashboard/admin/manage-department/create">
        <Button type="primary" icon={<PlusOutlined />} style={{ float: 'right', marginBottom: '15px' }}>
          Add New Department
        </Button>
      </Link><Table columns={columns} dataSource={departments} /></>}
    </>
  )
};




export default ManageDepartment;