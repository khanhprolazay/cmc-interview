import React, { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import './index.css';
import App from './App.jsx';
import { OidcProvider } from './oidc.js';
import { AppProvider } from './context/AppContext.jsx';
import { BrowserRouter } from 'react-router-dom';

createRoot(document.getElementById('root')).render(
	<StrictMode>
		<OidcProvider>
			<BrowserRouter>
				<AppProvider>
					<App />
				</AppProvider>
			</BrowserRouter>
		</OidcProvider>
	</StrictMode>
);
