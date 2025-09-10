import Card from "../composants/Card/Card";
import "../css/card/card.css";
import "../css/page/dashboardPage.css";
import EquipmentTable from "../composants/EquipmentTable/EquipmentTable";
import "../css/EquipmentTable/EquipmentTable.css"
const card = [
  { title: 10100, subTitle: 'Valeur du materiel', icon: "https://img.freepik.com/vecteurs-libre/employe-entrepot-verifiant-inventaire_3446-395.jpg?semt=ais_hybrid&w=740&q=80" },
  { title: 0, subTitle: 'Total retrouve', icon: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6-Dwt-coPJLdI51mhEv8kp_ReKCEstSLVk5VVXLq7jt6Su-SMcZgly9BZDKZrCMcaNTA&usqp=CAU" },
  { title: 43, subTitle: 'Total materiel', icon: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTkjsLxkjlZQrVRNCb-JW513IG1051PlagMIKvZ4rhpectzC-1HjpfyxlDBvU1qihXWseg&usqp=CAU" },
];
const equipments = [
  { id: 1, name: "Clé à molette", brand: "Facom", status: "Disponible", quantity: 15, category: "Outils" },
  { id: 2, name: "Perceuse", brand: "Bosch", status: "En réparation", quantity: 3, category: "Électroportatif" },
  { id: 3, name: "Clé à molette", brand: "Facom", status: "Disponible", quantity: 15, category: "Outils" },
  { id: 4, name: "Perceuse", brand: "Bosch", status: "En réparation", quantity: 3, category: "Électroportatif" },
];

export default function dashboardPage() {
  const handleEdit = (id: number) => {
    alert(`Modifier équipement ID: ${id}`);
  };

  const handleDelete = (id: number) => {
    if (window.confirm("Voulez-vous vraiment supprimer cet équipement ?")) {
      alert(`Supprimer équipement ID: ${id}`);
    }
  };

  return (
    <div>
      <Card card={card}/>
      <div className="equipment">
        <h1>Tableau de bord</h1>
        <h4 className="equipment--color">Liste des equipements</h4>
      </div>
      <EquipmentTable data={equipments} onEdit={handleEdit} onDelete={handleDelete} />
    </div>
  )
}
