import "./LeftMenu.css";
import Logo from './../../assets/logo.svg';
import Analytics from './../../assets/analytics.svg';
import Dashboard from './../../assets/dashboard.svg';
import Profile from './../../assets/profile.jpg';
import Performance from './../../assets/performance.svg';
import Settings from './../../assets/settings.svg';
import Funds from './../../assets/funds.svg';
import Help from './../../assets/help.svg';

function LeftMenu() {

  return (
    <nav>
      <div class="sidebar-top">
        <a href="#" class="logo__wrapper">
          <img src={Logo} alt="Logo" class="logo" />
          <h1 class="hide">Flowers</h1>
        </a>
      </div>
      <div class="sidebar-links">
        <ul>
          <li>
            <a href="#dashboard" title="Dashboard" class="tooltip">
              <img src={Dashboard} alt="Dashboard" />
              <span class="link hide">Trang chủ</span>
            </a>
          </li>
          <li>
            <a href="#project" title="Project" class="tooltip">
              <img src={Analytics} alt="Analytics" />
              <span class="link hide">Đơn hàng</span>
            </a>
          </li>
          <li>
            <a href="#performance" title="Performance" class="tooltip">
              <img src={Performance} alt="Performance" />
              <span class="link hide">Khách hàng</span>
            </a>
          </li>
          <li>
            <a href="#funds" title="Funds" class="tooltip">
              <img src={Funds} alt="Funds" />
              <span class="link hide">Nhân viên</span>
            </a>
          </li>
          <li>
            <a href="#funds" title="Funds" class="tooltip">
              <img src={Help} alt="Funds" />
              <span class="link hide">Sản phẩm</span>
            </a>
          </li>
        </ul>
      </div>
      <div class="sidebar-bottom">
        <div class="sidebar-links">
          <ul>
            <li>
              <a href="#settings" title="Settings" class="tooltip">
                <img src={Settings} alt="Settings" />
                <span class="link hide">Cài đặt</span>
              </a>
            </li>
          </ul>
        </div>
        <div class="sidebar__profile">
          <div class="avatar__wrapper">
            <img class="avatar" src={Profile} alt="Profile" />
            <div class="online__status"></div>
          </div>
          <div class="avatar__name hide">
            <div class="user-name">Hau Lam</div>
            <div class="email">094.123.9992</div>
          </div>
        </div>
      </div>
    </nav>
  );
}

export default LeftMenu;
