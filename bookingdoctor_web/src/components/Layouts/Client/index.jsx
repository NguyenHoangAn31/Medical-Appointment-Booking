import Header from './Header';
import Footer from './Footer';
import { Toaster } from "react-hot-toast";
import { createContext, useEffect, useState } from 'react';
import getUserData from '../../../route/CheckRouters/token/Token';

export const UserContext = createContext();

function ClientLayout({ children, isForPatient }) {
    const [currentUser, setCurrentUser] = useState()
    useEffect(() => {
        var token = getUserData();
        console.log(token)
        if (token!=null && token.user.roles[0] == 'USER') {
            setCurrentUser(token)
        }
    }, [])
    return (
        <UserContext.Provider value={{ currentUser, setCurrentUser }}>

            <div>
                <div className='float-end'><Toaster toastOptions={{ duration: 4000 }} /></div>
                <Header />
                <div className='main-app'>
                    {isForPatient ? <div>sidebar</div> : null}
                    <div className='content'>{children}</div>
                </div>
                <Footer />
            </div>
        </UserContext.Provider>

    );
}

export default ClientLayout;