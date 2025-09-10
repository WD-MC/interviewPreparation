import { NavLink } from 'react-router-dom';
import { useState } from 'react';

type NavLink = {
  label: string;
  href: string;
  actif?: boolean;
};

type NavBarProps = {
  logo: string;
  links: NavLink[];
};

const Navbar = ({logo, links}:NavBarProps) => {
    const [menuOuvert, setMenuOuvert] = useState(false);

    const toggleMenu = () => setMenuOuvert(!menuOuvert);
    return (
        <nav className="nav-bar">
            <div className="nav-bar__logo">{logo}</div>
            <button className="nav-bar__toggle" onClick={toggleMenu}>
                ☰
            </button>
            <ul className={`nav-bar__links ${menuOuvert ? 'nav-bar__links--open' : ''}`}>
                {links.map((link, index) => (
                    <li key={index}>
                        <NavLink
                            to={link.href}
                            end 
                            className={({ isActive }) =>
                                isActive ? 'nav-bar__link nav-bar__link--actif' : 'nav-bar__link'
                            }
                        >
                            {link.label}
                        </NavLink>
                    </li>
                ))}
            </ul>
        </nav>
    );
};

/* const Navbar = () => {
  return (
    <nav className={styles.navbar}>
      <div className={styles.logo}>Equipment Manager</div>
      <ul className={styles.navLinks}>
        <li>
          <NavLink
            to="/"
            className={({ isActive }) => isActive ? styles.active : ''}
          >
            Dashboard
          </NavLink>
        </li>
        <li>
          <NavLink
            to="/equipments"
            className={({ isActive }) => isActive ? styles.active : ''}
          >
            Équipements
          </NavLink>
        </li>
        <li>
          <NavLink
            to="/equipments/add"
            className={({ isActive }) => isActive ? styles.active : ''}
          >
            Ajouter
          </NavLink>
        </li>
      </ul>
    </nav>
  );
}; */

export default Navbar;