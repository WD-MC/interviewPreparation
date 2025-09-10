import { BrowserRouter } from 'react-router-dom';
import AppRoutes from "./routes";
import Navbar from "./composants/navBar/NavBar";
import "./css/navBar/NavBar.css";
import "./css/card/card.css";

function App() {

  const links = [
    { label: 'Équipements', href: '/', actif: true },
    { label: 'Ajouter', href: '/equipments'},
    { label: 'Reports', href: '/equipments/add' },
  ];

  return (
    <BrowserRouter>
      <Navbar logo="Equipment Manager" links={links}/>
      <AppRoutes />
    </BrowserRouter>
  )
}

export default App
