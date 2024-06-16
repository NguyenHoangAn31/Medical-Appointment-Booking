import Header from './Header';
import Footer from './Footer';
import { Toaster } from "react-hot-toast";
import { createContext, useEffect, useState } from 'react';
import getUserData from '../../../route/CheckRouters/token/Token';

export const UserContext = createContext();

function ClientLayout({ children, isForPatient }) {
    const [currentUser, setCurrentUser] = useState(null)
    //console.log("current user : ",currentUser)
    useEffect(() => {
        var token = getUserData();
        if (token!=null && token.user.roles[0] == 'USER') {
            setCurrentUser(token)
        }
    }, [])
    //console.log("child : " ,children)
    return (
        <UserContext.Provider value={{ currentUser, setCurrentUser }}>

            <div>
                <div className='float-end'><Toaster toastOptions={{ duration: 4000 }} /></div>
                <Header />
                <div className='main-app'>
                    {isForPatient ? <div className='container mt-5'>
                        <div className='row'>
                            <div className='col-md-2'>
                                <div className='col-12'>
                                    <ul className='sidebar'>
                                        <li className='item active'>
                                            <a href="#" className='link'>Profile</a>
                                        </li>
                                        <li className='item'>
                                            <a href="#" className='link'>Booking</a>
                                        </li>
                                        <li className='item'>
                                            <a href="#" className='link'>Fauvorite</a>
                                        </li>
                                        <li className='item'>
                                            <a href="#" className='link'>Medical history</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div className='col-md-10'>
                                {children}
                            </div>
                        </div>
                    </div> : <div className='content'>
                        {children}
                    </div>}
                </div>
                <Footer />
            </div>
        </UserContext.Provider>

    );
}

export default ClientLayout;