import * as Client from '../pages/Client'
import * as DashBoard from '../pages/DashBoard'
import { ClientLayout, DashBoardLayout } from '../components/Layouts'

const publicRouters = [
    { path: '/', component: Client.Home, layout: ClientLayout },
    { path: '/home', component: Client.Home, layout: ClientLayout },
    { path: '/about', component: Client.About, layout: ClientLayout },
    { path: '/contact', component: Client.Contact, layout: ClientLayout },
    { path: '/service', component: Client.Service, layout: ClientLayout },
    { path: '/doctor', component: Client.Doctor, layout: ClientLayout },
    { path: '/doctor/:id', component: Client.DoctorDetail, layout: ClientLayout },
    { path: '/working/:id', component: Client.DoctorDetail, layout: ClientLayout },
    { path: '/login', component: Client.Login, layout: ClientLayout },
    { path: '/login-by-phone', component: Client.LoginPhone, layout: ClientLayout },
    { path: '/login-by-phone-submit', component: Client.LoginPhoneStep, layout: ClientLayout },
    { path: '/login-by-gmail', component: Client.LoginGmail, layout: ClientLayout },
    { path: '/login-by-gmail-submit', component: Client.LoginGmailStep, layout: ClientLayout },
    { path: '/booking', component: Client.Booking, layout: ClientLayout },
    { path: '/signup', component: Client.Signup, layout: ClientLayout },     
]

const patientRouters = [
    { path: '/profilepatient', component: Client.ProfilePatient, layout: ClientLayout },
    { path: '/checkout', component: Client.CheckOut, layout: ClientLayout }
]



const doctorRouters = [
    { path: '/dashboard/doctor', component: DashBoard.DashboardDoctor, layout: DashBoardLayout },
    { path: '/dashboard/doctor/profile', component: DashBoard.ProfileDoctor, layout: DashBoardLayout },
    { path: '/dashboard/doctor/schedule', component: DashBoard.Schedule, layout: DashBoardLayout }
]
const adminRouters = [
    { path: '/dashboard/admin', component: DashBoard.DashboardAdmin, layout: DashBoardLayout },
    { path: '/dashboard/admin/profile', component: DashBoard.ProfileAdmin, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-schedule', component: DashBoard.Schedule, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-patient', component: DashBoard.ManagePatient, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-doctor', component: DashBoard.ManageDoctor, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-department', component: DashBoard.ManageDepartment, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-department/create', component: DashBoard.AddDepartment, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-department/edit/:id', component: DashBoard.EditDepartment, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-slot', component: DashBoard.ManageSlot, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-slot/create', component: DashBoard.AddSlot, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-slot/edit/:id', component: DashBoard.EditSlot, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-appointment', component: DashBoard.ManageAppointment, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-feedback', component: DashBoard.ManageFeedback, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-feedback/detail/:id', component: DashBoard.Detail, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-news', component: DashBoard.ManageNews, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-news/create', component: DashBoard.AddNews, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-news/edit/:id', component: DashBoard.EditNews, layout: DashBoardLayout },
    { path: '/dashboard/admin/manage-news/detail/:id', component: DashBoard.DetailNews, layout: DashBoardLayout }
]

export { publicRouters, patientRouters, doctorRouters, adminRouters }
