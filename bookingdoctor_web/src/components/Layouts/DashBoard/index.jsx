import React, { useEffect, useState, createContext, useContext } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import getUserData from '../../../route/CheckRouters/token/Token';
import { getAuth, signOut } from "firebase/auth";

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
    LogoutOutlined,
    DashboardTwoTone,
    PlusSquareTwoTone,
    MedicineBoxTwoTone,
    IdcardTwoTone,
    ShopTwoTone,
    CreditCardTwoTone,
    CalendarTwoTone,
    HighlightTwoTone,
    QuestionCircleTwoTone,
    BellTwoTone,
    CarryOutTwoTone
} from '@ant-design/icons';
import { Button, Breadcrumb, Layout, Menu, theme, Dropdown, Space, Badge } from 'antd';
import openAlert from '../../openAlert';
const { Header, Content, Footer, Sider } = Layout;


var itemslist = []
if (getUserData != null) {
    var role = getUserData.user.roles[0];
    if (role == "ADMIN") {
        itemslist.push(
            {
                label: "Dashboard",
                icon: <DashboardTwoTone twoToneColor='blue' />,
                key: "/dashboard/admin",
            },
            {
                label: "Manage Patient",
                key: "/dashboard/admin/manage-patient",
                icon: <MedicineBoxTwoTone twoToneColor='red' />,
            },
            {
                label: "Manage Doctor",
                key: "/dashboard/admin/manage-doctor",
                icon: <IdcardTwoTone twoToneColor='green' />,
            },
            {
                label: "Manage Department",
                key: "/dashboard/admin/manage-department",
                icon: <ShopTwoTone twoToneColor='#c6c243' />,
            },
            // {
            //     label: "Manage Slot",
            //     key: "/dashboard/admin/manage-slot",
            //     icon: <FieldTimeOutlined />,
            // },
            {
                label: "Manage Appointment",
                key: "/dashboard/admin/manage-appointment",
                icon: <CreditCardTwoTone twoToneColor='purple' />,
            },
            {
                label: "Manage Schedule",
                key: "/dashboard/admin/manage-schedule",
                icon: <CalendarTwoTone twoToneColor='#f081ff' />,
            },
            {
                label: "Manage Feedback",
                key: "/dashboard/admin/manage-feedback",
                icon: <QuestionCircleTwoTone twoToneColor='#eb2f96' />,
            },
            {
                label: "Manage News",
                key: "/dashboard/admin/manage-news",
                icon: <HighlightTwoTone twoToneColor='#00fff6' />,
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
    const [collapsed, setCollapsed] = useState(true);
    const [darkTheme, setDarkTheme] = useState(true);
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
    const curentPath = paths.slice(2).join(' / ');
    // xử lý logout
    const handleLogout = () => {
        sessionStorage.removeItem("Token");
        const auth = getAuth();
        signOut(auth).then(() => {
            // Sign-out successful.
        }).catch((error) => {
            // An error happened.
        });
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
                backgroundColor:'#f4f7fe',
                minHeight:'100vh',
                paddingBottom:50
            }}
            >
                {contextHolder}
                <Sider theme={darkTheme ? 'dark' : 'light'} width={250} trigger={null} collapsible collapsed={collapsed}
                    style={{
                        position: 'fixed',
                        height: '100vh',
                        zIndex: 999,
                        overflow: 'auto'
                    }}
                >
                    <div style={{ textAlign: 'center', color: 'white', fontSize: '45px', margin: '20px 0' }}>
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
                        style={{
                            userSelect: 'none',
                            border: 'none'
                        }}
                    ></Menu>
                    <ToggleThemeButton darkTheme={darkTheme} toggleTheme={toggleTheme} />
                </Sider>


                <Layout style={{ marginLeft: collapsed ? 80 : 250, transition: '.2s', paddingTop: '115px' , backgroundColor:'#f4f7fe'}}>
                    <Header
                        style={{
                            padding: 0,
                            background: colorBgContainer,
                            left: collapsed ? 106 : 276,
                            borderRadius: '10px',
                            overflow: 'hidden',
                            top: '14px',
                            right: '26px',
                            zIndex: 998,
                            position: 'fixed',
                            display: 'flex',
                            justifyContent: 'space-between',
                            height: '100px',
                            padding: '10px',
                            backgroundColor: 'transparent',
                            backdropFilter: 'blur(10px)',

                        }}
                    >
                        <div style={{ display: 'flex', alignItems: 'center', gap: '15px' }}>
                            <Button
                                type="text"
                                icon={collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
                                onClick={() => setCollapsed(!collapsed)}
                                style={{
                                    fontSize: '16px',
                                    width: 64,
                                    height: 64,
                                    float: 'left'
                                }}
                            />

                            <div>
                                <Breadcrumb style={{ float: 'left' }}>
                                    <Breadcrumb.Item>pages</Breadcrumb.Item>
                                    <Breadcrumb.Item>{curentPath}</Breadcrumb.Item>
                                </Breadcrumb>
                                <h1 style={{clear:'both'}}>{curentPath}</h1>
                            </div>

                        </div>



                        <div style={{ display: 'flex', float: 'right', alignItems: 'center', gap: '25px', userSelect: 'none', borderRadius: "50px", padding: "0 25px", backgroundColor: "white", height: '65px' }}>
                            <Dropdown
                                menu={{
                                    items: [
                                        {
                                            key: '1',
                                            label: (
                                                <a target="_blank" rel="noopener noreferrer" href="https://www.antgroup.com">
                                                    1st menu item
                                                </a>
                                            ),
                                        },
                                        {
                                            key: '2',
                                            label: (
                                                <a target="_blank" rel="noopener noreferrer" href="https://www.aliyun.com">
                                                    2nd menu item
                                                </a>
                                            ),
                                        },
                                        {
                                            key: '3',
                                            label: (
                                                <a target="_blank" rel="noopener noreferrer" href="https://www.luohanacademy.com">
                                                    3rd menu item
                                                </a>
                                            ),
                                        },
                                    ]
                                }}
                                placement="bottomRight"
                            >
                                <Badge count={5}>
                                    <BellTwoTone style={{ fontSize: '20px' }} />
                                </Badge>
                            </Dropdown>


                            <Dropdown
                                menu={{
                                    items: [
                                        {
                                            key: '1',
                                            label: (
                                                <a target="_blank" rel="noopener noreferrer" href="https://www.antgroup.com">
                                                    1st menu item
                                                </a>
                                            ),
                                        },
                                        {
                                            key: '2',
                                            label: (
                                                <a target="_blank" rel="noopener noreferrer" href="https://www.aliyun.com">
                                                    2nd menu item
                                                </a>
                                            ),
                                        },
                                        {
                                            key: '3',
                                            label: (
                                                <a target="_blank" rel="noopener noreferrer" href="https://www.luohanacademy.com">
                                                    3rd menu item
                                                </a>
                                            ),
                                        },
                                    ]
                                }}
                                placement="bottomRight"
                            >
                                <Badge count={5}>
                                    <CarryOutTwoTone style={{ fontSize: '20px' }} />
                                </Badge>
                            </Dropdown>

                            <Dropdown
                                menu={{
                                    items: [{
                                        key: '1',
                                        label: (
                                            <Link style={{ textDecoration: 'none', userSelect: 'none' }} to={role === "ADMIN" ? "/dashboard/admin/profile" : "/dashboard/doctor/profile"}>
                                                <ProfileOutlined /> <span style={{ marginLeft: '7px' }}>Profile</span>
                                            </Link>
                                        ),
                                    },
                                    {
                                        key: '2',
                                        label: (
                                            <span onClick={handleLogout} style={{ userSelect: 'none' }}>
                                                <LogoutOutlined /><span style={{ marginLeft: '7px' }}>Logout</span>
                                            </span>
                                        ),
                                    },],
                                }}
                                placement="bottom"
                            >
                                <div >
                                    <img
                                        src="/images/dashboard/default_user.jpg"
                                        alt=""
                                        height="50"
                                        width="50"
                                        style={{
                                            borderRadius: '50%',
                                            marginRight: '10px'
                                        }}
                                    />
                                    <span>{getUserData.user.email}</span>

                                </div>
                            </Dropdown>
                        </div>
                    </Header>
                    <Content
                        style={{
                            margin: '0 26px',
                        }}
                    >
                        <div
                            style={{
                                padding: 24,
                                minHeight: 360,
                                background: colorBgContainer,
                                borderRadius: '10px',
                            }}
                        >
                            {children}
                        </div>
                    </Content>
                    {/* <Footer
                        style={{
                            textAlign: 'center',
                            backgroundColor:'rgb(244, 247, 254)'
                        }}
                    >
                        Ant Design ©{new Date().getFullYear()} Created by Ant UED
                    </Footer> */}
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
            position: 'fixed'
        }} >
            <Button onClick={toggleTheme}>
                <BulbOutlined />

            </Button>
        </div>
    )
}
export default DashBoardLayout;





