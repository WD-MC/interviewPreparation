import React, { useState, useMemo } from 'react';

type Equipment = {
  id: number;
  name: string;
  brand: string;
  status: string;
  quantity: number;
  category: string;
};

type Props = {
  data: Equipment[];
  onEdit: (id: number) => void;
  onDelete: (id: number) => void;
};

const EquipmentTable: React.FC<Props> = ({ data, onEdit, onDelete }) => {
  const [searchTerm, setSearchTerm] = useState('');
  const [sortConfig, setSortConfig] = useState<{ key: keyof Equipment; direction: 'asc' | 'desc' } | null>(null);

  
  const sortedData = useMemo(() => {
    let sortableItems = [...data];

    if (sortConfig !== null) {
      sortableItems.sort((a, b) => {
        const aKey = a[sortConfig.key];
        const bKey = b[sortConfig.key];

        if (typeof aKey === 'string' && typeof bKey === 'string') {
          return sortConfig.direction === 'asc'
            ? aKey.localeCompare(bKey)
            : bKey.localeCompare(aKey);
        }
        if (typeof aKey === 'number' && typeof bKey === 'number') {
          return sortConfig.direction === 'asc' ? aKey - bKey : bKey - aKey;
        }
        return 0;
      });
    }

    return sortableItems;
  }, [data, sortConfig]);

  // Filtrage par recherche sur name et category
  const filteredData = sortedData.filter((item) =>
    item.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
    item.category.toLowerCase().includes(searchTerm.toLowerCase())
  );

  
  const requestSort = (key: keyof Equipment) => {
    let direction: 'asc' | 'desc' = 'asc';
    if (sortConfig && sortConfig.key === key && sortConfig.direction === 'asc') {
      direction = 'desc';
    }
    setSortConfig({ key, direction });
  };

  
  const SortArrow = ({ columnKey }: { columnKey: keyof Equipment }) => {
    if (!sortConfig || sortConfig.key !== columnKey) return null;
    return sortConfig.direction === 'asc' ? ' 🔼' : ' 🔽';
  };

  return (
    <div className='equipment-list'>
      <input
        type="text"
        placeholder="Rechercher par nom ou catégorie..."
        value={searchTerm}
        onChange={(e) => setSearchTerm(e.target.value)}
        className='equipment-list__search'
      />

      <table className="equipment-list__table">
        <thead className="equipment-list__thead">
          <tr className="equipment-list__tr">
            <th className="equipment-list__th">ID</th>
            <th className="equipment-list__th equipment-list__th--sortable" onClick={() => requestSort('name')} >
              Nom{<SortArrow columnKey="name" />}
            </th>
            <th className="equipment-list__th">Marque</th>
            <th className="equipment-list__th">Status</th>
            <th className="equipment-list__th">Quantité</th>
            <th className="equipment-list__th equipment-list__th--sortable" onClick={() => requestSort('category')}>
              Catégorie{<SortArrow columnKey="category" />}
            </th>
            <th className="equipment-list__th">Actions</th>
          </tr>
        </thead>
        <tbody className="equipment-list__tbody">
          {filteredData.length === 0 && (
            <tr className="equipment-list__tr">
              <td colSpan={7} className="equipment-list__empty">
                Aucun équipement trouvé.
              </td>
            </tr>
          )}
          {filteredData.map((equip) => (
            <tr key={equip.id} className="equipment-list__tr">
              <td className="equipment-list__td">{equip.id}</td>
              <td className="equipment-list__td">{equip.name}</td>
              <td className="equipment-list__td">{equip.brand}</td>
              <td className="equipment-list__td">{equip.status}</td>
              <td className="equipment-list__td">{equip.quantity}</td>
              <td className="equipment-list__td">{equip.category}</td>
              <td className="equipment-list__td">
                <button onClick={() => onEdit(equip.id)} className="equipment-list__btn equipment-list__btn--edit">
                  Modifier
                </button>
                <button onClick={() => onDelete(equip.id)} className="equipment-list__btn equipment-list__btn--delete">
                  Supprimer
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default EquipmentTable;
