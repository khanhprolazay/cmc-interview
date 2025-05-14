import { fetchWithAuth } from '../oidc';


export function bulkImportAssets(file) {
	const formData = new FormData();
	formData.append('file', file);
	return fetchWithAuth(`${import.meta.env.VITE_API_URL}/assets/bulk_import`, {
		method: 'POST',
		body: formData,
	});
}
