import React, { useEffect, useState, createContext, useContext } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
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
    ScheduleOutlined,
    LogoutOutlined
} from '@ant-design/icons';
import { Button, Breadcrumb, Layout, Menu, theme, Dropdown, Space } from 'antd';
import openAlert from '../../openAlert';
const { Header, Content, Footer, Sider } = Layout;


var itemslist = []
if (getUserData != null) {
    var role = getUserData.user.roles[0];
    if (role == "ADMIN") {
        itemslist.push(
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
            }
        )
    }
    else if (role == "DOCTOR") {
        itemslist.push(
            {
                label: "Dashboard",
                key: "/dashboard/doctor",
                icon: <DashboardOutlined />,
            },
            {
                label: "Schedule",
                key: "/dashboard/doctor/schedule",
                icon: <ScheduleOutlined />,
            }
        )
    }
}

export const AlertContext = createContext();


const DashBoardLayout = ({ children }) => {
    const [collapsed, setCollapsed] = useState(false);
    const [darkTheme, setDarkTheme] = useState(false);
    const navigate = useNavigate();


    const toggleTheme = () => {
        setDarkTheme(!darkTheme)
    }
    // thông báo 

    const [openNotificationWithIcon, contextHolder] = openAlert();

    // Breadcrumb
    const location = useLocation();
    const pathname = location.pathname;
    const paths = pathname.split('/').filter(path => path !== '');
    const lastPath = paths[paths.length - 1];
    // xử lý logout
    const handleLogout = () => {
        sessionStorage.removeItem("Token");
        navigate("/");
        window.location.reload();
    }

    const [selectedKeys, setSelectedKeys] = useState("/");

    useEffect(() => {
        setSelectedKeys(pathname);
    }, [location.pathname]);


    const {
        token: { colorBgContainer, borderRadiusLG },
    } = theme.useToken();

    return (
        <AlertContext.Provider value={openNotificationWithIcon}>

            <Layout
                style={{
                    minHeight: '100vh',
                }}
            >
                {contextHolder}
                <Sider theme={darkTheme ? 'dark' : 'light'} width={250} trigger={null} collapsible collapsed={collapsed}
                    style={{
                        position: 'fixed',
                        height: '100vh',
                    }}
                >
                    <div style={{ textAlign: 'center', color: 'white', fontSize: '45px', margin: '10px' }}>
                        <div style={{ width: 60, height: 60, display: 'flex', margin: 'auto', backgroundColor: 'black', justifyContent: 'center', alignItems: 'center', borderRadius: '50%' }}>
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
                        items={itemslist}
                    ></Menu>
                    <ToggleThemeButton darkTheme={darkTheme} toggleTheme={toggleTheme} />
                </Sider>

                <Layout style={{ marginLeft: collapsed ? 80 : 250, transition: '.2s' }}>
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
                        <Dropdown
                            menu={{
                                items: [{
                                    key: '1',
                                    label: (
                                        <Link to={role === "ADMIN" ? "/dashboard/admin/profile" : "/dashboard/doctor/profile"}>
                                            <ProfileOutlined /> <span style={{ marginLeft: '7px' }}>Profile</span>
                                        </Link>
                                    ),
                                },
                                {
                                    key: '2',
                                    label: (
                                        <span onClick={handleLogout}>
                                            <LogoutOutlined /><span style={{ marginLeft: '7px' }}>Logout</span>
                                        </span>
                                    ),
                                },],
                            }}
                            placement="bottom"
                        >
                            <div style={{ display: 'flex', float: 'right', alignItems: 'center', marginRight: '20px', gap: '7px' }}>
                                <img
                                    src="/images/dashboard/default_user.jpg"
                                    alt=""
                                    height="50"
                                    width="50"
                                    style={{
                                        borderRadius: '50%'
                                    }}
                                />
                                <span>example@gmail.com</span>

                            </div>

                        </Dropdown>
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
                                position: 'relative'
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
        </AlertContext.Provider>

    );


};


const ToggleThemeButton = ({ toggleTheme }) => {
    return (
        <div style={{
            bottom: 17,
            left: 17,
            position: 'absolute'
        }} >
            <Button onClick={toggleTheme}>
                <BulbOutlined />

            </Button>
        </div>
    )
}
export default DashBoardLayout;





