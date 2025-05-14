import { fetchWithAuth } from '../oidc';

export function fetchAssets() {
	return fetch(`${import.meta.env.VITE_API_URL}/assets`);
}

export function fetchAvailableAssets() {
	return fetchWithAuth(`${import.meta.env.VITE_API_URL}/assets/available`);
}

export function fetchPurchasedAssets() {
	return fetchWithAuth(`${import.meta.env.VITE_API_URL}/assets/purchased`);
}

export function purchaseAsset(assetIds) {
	return fetchWithAuth(`${import.meta.env.VITE_API_URL}/assets/bulk_purchase`, {
		method: 'POST',
		body: JSON.stringify({
			asset_ids: assetIds,
		}),
	});
}

export function fetchAsset(assetId) {
	return fetchWithAuth(`${import.meta.env.VITE_API_URL}/assets/${assetId}`);
}
