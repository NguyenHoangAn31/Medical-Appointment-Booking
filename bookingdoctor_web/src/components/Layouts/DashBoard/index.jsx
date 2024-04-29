import React, { useEffect, useState } from 'react';
import { useLocation, useNavigate } from 'react-router-dom';
import getUserData from '../../../route/CheckRouters/token/Token';

import {
    MenuFoldOutlined,
    MenuUnfoldOutlined,
    FireFilled,
    BulbOutlined,
    AppstoreOutlined,
    ShopOutlined,
    DashboardOutlined,
    MedicineBoxOutlined,
    UserOutlined,
    HomeOutlined,
    FieldTimeOutlined,
    InfoCircleOutlined,
    QuestionCircleOutlined,
    FormOutlined,
    ProfileOutlined,
    ScheduleOutlined
} from '@ant-design/icons';
import { Button, Breadcrumb, Layout, Menu, theme } from 'antd';
const { Header, Content, Footer, Sider } = Layout;

var items = []
if (getUserData != null) {
    var role = getUserData.user.roles[0];
    if (role == "ADMIN") {
        items.push(
            {
                label: "Dashboard",
                icon: <DashboardOutlined />,
                key: "/dashboard/admin",
            },
            {
                label: "Manage Patient",
                key: "/dashboard/admin/manage-patient",
                icon: <MedicineBoxOutlined />,
            },
            {
                label: "Manage Doctor",
                key: "/dashboard/admin/manage-doctor",
                icon: <UserOutlined />,
            },
            {
                label: "Manage Department",
                key: "/dashboard/admin/manage-department",
                icon: <HomeOutlined />,
            },
            {
                label: "Manage Slot",
                key: "/dashboard/admin/manage-slot",
                icon: <FieldTimeOutlined />,
            },
            {
                label: "Manage Appointment",
                key: "/dashboard/admin/manage-appointment",
                icon: <ShopOutlined />,
            },
            {
                label: "Manage Schedule",
                key: "/dashboard/admin/manage-schedule",
                icon: <ScheduleOutlined />,
            },
            {
                label: "Manage Feedback",
                key: "/dashboard/admin/manage-feedback",
                icon: <QuestionCircleOutlined />,
            },
            {
                label: "Manage New",
                key: "/dashboard/admin/manage-new",
                icon: <FormOutlined />,
            },
            {
                label: "Profile",
                icon: <ProfileOutlined />,
                key: "/dashboard/admin/profile",
            }
        )
    }
    else if (role == "DOCTOR") {
        items.push(
            {
                label: "Dashboard",
                key: "/dashboard/doctor",
                icon: <DashboardOutlined />,
            },
            {
                label: "Schedule",
                key: "/dashboard/doctor/schedule",
                icon: <ScheduleOutlined />,
            },
            {
                label: "Profile",
                icon: <ProfileOutlined />,
                key: "/dashboard/doctor/profile",
            }
        )
    }
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
            <Sider theme={darkTheme ? 'dark' : 'light'} width={250} trigger={null} collapsible collapsed={collapsed}
            style={{
                position: 'fixed',
                height: '100vh',}}
            >
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

            <Layout style={{marginLeft: collapsed ? 80 : 250,transition:'.2s'}}>
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


const ToggleThemeButton = ({ toggleTheme }) => {
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





