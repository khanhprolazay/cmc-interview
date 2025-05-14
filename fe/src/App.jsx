import React from 'react';
import { useAppContext } from './context/AppContext';
import { useOidc } from './oidc';
import { Routes, Route, Link, Navigate } from 'react-router-dom';
import CustomerPage from './pages/CustomerPage';
import CreatorPage from './pages/CreatorPage';
import AdminPage from './pages/AdminPage';

import { Role } from './constants/role';
import { isUserHaveRole } from './utils';

const buttonClassName = 'p-2 text-black border border-black';

function App() {
	const { user } = useAppContext();
	const { login, logout, isUserLoggedIn } = useOidc();
	return (
		<>
			{isUserLoggedIn ? (
				<button className={buttonClassName} onClick={() => logout({ redirectTo: '/' })}>
					Logout
				</button>
			) : (
				<button className={buttonClassName} onClick={login}>
					Login
				</button>
			)}
			{isUserHaveRole(user, Role.CREATOR) && (
				<Link to="/creator">
					<button className={buttonClassName}>Create asset</button>
				</Link>
			)}
			{isUserHaveRole(user, Role.ADMIN) && (
				<Link to="/admin">
					<button className={buttonClassName}>Manage creator</button>
				</Link>
			)}
			<Routes>
				<Route index element={<CustomerPage />} />
				{isUserHaveRole(user, Role.CREATOR) && <Route path="creator" element={<CreatorPage />} />}
				{isUserHaveRole(user, Role.ADMIN) && <Route path="admin" element={<AdminPage />} />}
				<Route path="*" element={<Navigate to="/" replace />} />
			</Routes>
		</>
	);
}

export default App;
