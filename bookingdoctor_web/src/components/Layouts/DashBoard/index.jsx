import Header from './Header';
import SideBar from './SideBar';

function DashBoardLayout({children}) {
    return (
        <div>
            <Header/>
            <div className='container'>
                <div className='content'>{children}</div>
            </div>
            <SideBar/>
        </div>
    );
}

export default DashBoardLayout;