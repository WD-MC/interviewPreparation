//import React from 'react'
import { Route, Routes } from 'react-router-dom'
import DashboardPage from "./pages/DashboardPage";
import EquipmentListPage from "./pages/EquipmentListPage";
import AddEquipmentPage from "./pages/AddEquipmentPage";

export default function routes() {
  return (
    <Routes>
        <Route path="/" element={<DashboardPage />} />
        <Route path="/equipments" element={<EquipmentListPage />} />
        <Route path="/equipments/add" element={<AddEquipmentPage />} />
        {/* <Route path="/equipments/edit/:id" element={<EditEquipmentPage />} />
        <Route path="/equipments/:id" element={<EquipmentDetailPage />} /> */}
    </Routes>
  )
}
