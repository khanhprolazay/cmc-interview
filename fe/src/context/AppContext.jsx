import React, { createContext, useState, useContext, useEffect } from 'react';
import { fetchWithAuth, useOidc } from '../oidc';
import { jwtDecode } from 'jwt-decode';

const AppContext = createContext();

export const useAppContext = () => {
	return useContext(AppContext);
};

export const AppProvider = ({ children }) => {
	const [user, setUser] = useState(null);
	const { isUserLoggedIn, tokens } = useOidc();

	useEffect(() => {
		if (isUserLoggedIn && tokens?.accessToken) {
			fetchWithAuth(import.meta.env.VITE_IAM_USERINFO_ENDPOINT)
				.then((response) => response.json())
				.then((data) => setUser(jwtDecode(tokens.accessToken)));
		}
	}, [isUserLoggedIn, tokens?.accessToken]);

	return <AppContext.Provider value={{ user }}>{children}</AppContext.Provider>;
};
