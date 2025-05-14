import { fetchWithAuth } from '../oidc';

export function fetchCreators() {
	return fetchWithAuth(`${import.meta.env.VITE_API_URL}/creators`);
}
