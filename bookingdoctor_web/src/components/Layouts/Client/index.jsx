import Header from './Header';
import Footer from './Footer';
import { Toaster } from "react-hot-toast";

function ClientLayout({children}) {
    return (
        <div>
            <div className='float-end'><Toaster toastOptions={{ duration: 4000 }} /></div>
            <Header/>
            <div className='main-app'>
                <div className='content'>{children}</div>
            </div>
            <Footer/>
        </div>
    );
}

export default ClientLayout;