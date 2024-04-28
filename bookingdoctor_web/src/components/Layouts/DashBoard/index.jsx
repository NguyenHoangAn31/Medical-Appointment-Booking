import React, { useEffect, useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import getUserData from '../../../route/CheckRouters/token/Token';

import {
    MenuFoldOutlined,
    MenuUnfoldOutlined,
    FireFilled,
    BulbOutlined,
    AppstoreOutlined,
    ShopOutlined
} from '@ant-design/icons';
import { Button, Breadcrumb, Layout, Menu, theme } from 'antd';
const { Header, Content, Footer, Sider } = Layout;

const role = getUserData.user.roles[0]
var items = [
]
if (role == "ADMIN") {
    items.push(
        {
            label: "Dashbaord",
            icon: <AppstoreOutlined />,
            key: "/dashboard/admin",
        },
        {
            label: "Manage Patient",
            key: "/dashboard/admin/manage-patient",
            icon: <ShopOutlined />,
        },
        {
            label: "Manage Doctor",
            key: "/dashboard/admin/manage-doctor",
            icon: <ShopOutlined />,
        },
        {
            label: "Manage Department",
            key: "/dashboard/admin/manage-department",
            icon: <ShopOutlined />,
        },
        {
            label: "Manage Slot",
            key: "/dashboard/admin/manage-slot",
            icon: <ShopOutlined />,
        },
        {
            label: "Manage Appointment",
            key: "/dashboard/admin/manage-appointment",
            icon: <ShopOutlined />,
        },
        {
            label: "Manage Schedule",
            key: "/dashboard/admin/manage-schedule",
            icon: <ShopOutlined />,
        },
        {
            label: "Manage Feedback",
            key: "/dashboard/admin/manage-feedback",
            icon: <ShopOutlined />,
        },
        {
            label: "Manage New",
            key: "/dashboard/admin/manage-new",
            icon: <ShopOutlined />,
        },
        {
            label: "Profile",
            icon: <AppstoreOutlined />,
            key: "/dashboard/admin/profile",
        }
    )
}
else if (role == "DOCTOR") {
    items.push(
        {
            label: "Dashboard",
            key: "/dashboard/doctor",
            icon: <ShopOutlined />,
        },
        {
            label: "Schedule",
            key: "/dashboard/doctor/schedule",
            icon: <ShopOutlined />,
        },
        {
            label: "Profile",
            icon: <AppstoreOutlined />,
            key: "/dashboard/doctor/profile",
        }
    )
}
const DashBoardLayout = ({ children }) => {
    const [collapsed, setCollapsed] = useState(false);
    const [darkTheme, setDarkTheme] = useState(true);
    const navigate = useNavigate();

    const toggleTheme = () => {
        setDarkTheme(!darkTheme)
    }
    //Breadcrumb
    const location = useLocation();
    const pathname = location.pathname;
    const paths = pathname.split('/').filter(path => path !== '');
    const lastPath = paths[paths.length - 1];


    const [selectedKeys, setSelectedKeys] = useState("/");

    useEffect(() => {
        setSelectedKeys(pathname);
    }, [location.pathname]);


    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();
  
    return (

        <Layout
            style={{
                minHeight: '100vh',
            }}
        >
            <Sider theme={darkTheme ? 'dark' : 'light'} width={250} trigger={null} collapsible collapsed={collapsed}>
                <div className="demo-logo-vertical text-center text-white fs-1 my-2">
                    <div style={{ width: 60, height: 60 }} className='logo-icon d-flex m-auto bg-dark justify-content-center rounded-circle align-items-center'>
                        <FireFilled />
                    </div>
                </div>
                <Menu theme={darkTheme ? 'dark' : 'light'}
                    className="SideMenuVertical"
                    mode="vertical"
                    onClick={(item) => {
                        navigate(item.key);
                    }}
                    selectedKeys={[selectedKeys]}
                    items={items}
                ></Menu>
                <ToggleThemeButton darkTheme={darkTheme} toggleTheme={toggleTheme} />
            </Sider>

            <Layout>
                <Header
                    style={{
                        padding: 0,
                        background: colorBgContainer,
                    }}
                >
                    <Button
                        type="text"
                        icon={collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
                        onClick={() => setCollapsed(!collapsed)}
                        style={{
                            fontSize: '16px',
                            width: 64,
                            height: 64,
                        }}
                    />
                </Header>
                <Content
                    style={{
                        margin: '0 16px',
                    }}
                >
                    <Breadcrumb
                        style={{
                            margin: '16px 0',
                        }}
                    >
                        <Breadcrumb.Item>{role}</Breadcrumb.Item>
                        <Breadcrumb.Item>{lastPath}</Breadcrumb.Item>
                    </Breadcrumb>
                    <div
                        style={{
                            padding: 24,
                            minHeight: 360,
                            background: colorBgContainer,
                            borderRadius: borderRadiusLG,
                        }}
                    >
                        {children}
                    </div>
                </Content>
                <Footer
                    style={{
                        textAlign: 'center',
                    }}
                >
                    Ant Design ©{new Date().getFullYear()} Created by Ant UED
                </Footer>
            </Layout>
        </Layout>
    );
};


const ToggleThemeButton = ({toggleTheme }) => {
    return (
        <div style={{
            bottom: 17,
            left: 17
        }} className='toggle-theme-btn position-absolute'>
            <Button onClick={toggleTheme}>
                <BulbOutlined />

            </Button>
        </div>
    )
}
export default DashBoardLayout;