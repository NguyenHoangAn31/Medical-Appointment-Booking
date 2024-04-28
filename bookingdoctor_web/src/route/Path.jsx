import * as Client from '../pages/Client'
import * as DashBoard from '../pages/DashBoard'
import { ClientLayout , DashBoardLayout } from '../components/Layouts'

const publicRouters = [
    {path:'/',component:Client.Home,layout:ClientLayout},
    {path:'/home',component:Client.Home,layout:ClientLayout},
    {path:'/about',component:Client.About,layout:ClientLayout},
    {path:'/contact',component:Client.Contact,layout:ClientLayout},
    {path:'/service',component:Client.Service,layout:ClientLayout},
    {path:'/doctor',component:Client.Doctor,layout:ClientLayout},
    {path:'/doctordetail',component:Client.DoctorDetail,layout:ClientLayout},
    {path:'/login',component:Client.Login,layout:ClientLayout},
    {path:'/login-by-phone',component:Client.LoginPhone,layout:ClientLayout},
    {path:'/login-by-phone-submit',component:Client.PhoneSubmit,layout:ClientLayout},
    {path:'/login-by-gmail',component:Client.LoginGmail,layout:ClientLayout},
    {path:'/booking',component:Client.Booking,layout:ClientLayout},
    {path:'/signup',component:Client.Signup,layout:ClientLayout},
]

const patientRouters = [
    {path:'/profilepatient',component:Client.ProfilePatient,layout:ClientLayout},
    {path:'/checkout',component:Client.CheckOut,layout:ClientLayout}
]

const privateRouters = [
    {path:'/dashboard',component:DashBoard.Dashboard,layout:DashBoardLayout},
    {path:'/dashboard/profile',component:DashBoard.Profile,layout:DashBoardLayout},
]

const doctorRouters = [
    {path:'/dashboard/doctor/schedule',component:DashBoard.Schedule,layout:DashBoardLayout}
]
const adminRouters = [
    {path:'/dashboard/admin/manage-schedule',component:DashBoard.Schedule,layout:DashBoardLayout},
    {path:'/dashboard/admin/manage-patient',component:DashBoard.ManagePatient,layout:DashBoardLayout},
    {path:'/dashboard/admin/manage-doctor',component:DashBoard.ManageDoctor,layout:DashBoardLayout}
]

export{publicRouters,patientRouters,privateRouters, doctorRouters,adminRouters}