import {
	fetchAsset,
	fetchAssets,
	fetchAvailableAssets,
	fetchPurchasedAssets,
	purchaseAsset,
} from '../apis/customer.api';
import { useOidc } from '../oidc';
import React, { useCallback, useEffect, useState } from 'react';

export default function CustomerPage() {
	const { login, isUserLoggedIn } = useOidc();
	const [assets, setAssets] = useState([]);
	const [selectedAssets, setSelectedAssets] = useState([]);
	const [purchasedAssets, setPurchasedAssets] = useState([]);

	const handlePurchase = useCallback(
		(assetIds) => {
			if (!isUserLoggedIn) return login();
			purchaseAsset(assetIds)
				.then(() => fetchPurchasedAssets())
				.then((res) => res.json())
				.then((data) => setPurchasedAssets(data));
		},
		[isUserLoggedIn]
	);

	const handleDownload = useCallback((assetId) => {
		fetchAsset(assetId)
			.then((res) => res.json())
			.then((data) => window.open(data.fileUrl, '_blank'));
	}, []);

	const handleSelectChange = (assetId) => {
		setSelectedAssets((prevSelected) => {
			if (prevSelected.includes(assetId)) {
				return prevSelected.filter((id) => id !== assetId);
			} else {
				return [...prevSelected, assetId];
			}
		});
	};

	useEffect(() => {
		const fetch = isUserLoggedIn ? fetchAvailableAssets : fetchAssets;
		fetch()
			.then((res) => res.json())
			.then((data) => setAssets(data));

		if (isUserLoggedIn)
			fetchPurchasedAssets()
				.then((res) => res.json())
				.then((data) => setPurchasedAssets(data));
	}, [isUserLoggedIn]);

	return (
		<>
			<div className="container mx-auto p-4">
				<h1 className="text-2xl font-bold mb-4">Available Assets</h1>
				<div className="flex flex-wrap gap-6">
					{assets.length === 0 ? (
						<p>No assets available to display.</p>
					) : (
						assets.map((asset) => (
							<div
								key={asset.id}
								className="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 xl:w-1/5 p-4 bg-gray-100 rounded-lg shadow-lg">
								<h2 className="text-xl font-semibold">{asset.title}</h2>
								<p className="text-gray-700">{asset.description}</p>
								<p className="text-lg font-semibold">Price: ${asset.price}</p>
								<div className="flex items-center gap-2">
									<input
										type="checkbox"
										id={`asset-${asset.id}`}
										checked={selectedAssets.includes(asset.id)}
										onChange={() => handleSelectChange(asset.id)}
										className="h-5 w-5"
									/>
									<label htmlFor={`asset-${asset.id}`} className="text-sm">
										Select Asset
									</label>
								</div>
							</div>
						))
					)}
				</div>

				<button
					onClick={() => handlePurchase(selectedAssets)}
					className="mt-6 px-6 py-2 bg-blue-500 text-white rounded hover:bg-blue-700"
					disabled={selectedAssets.length === 0}>
					Purchase Selected Assets
				</button>
			</div>
			<div className="container mx-auto p-4">
				<h1 className="text-2xl font-bold mb-4">Purchased Assets</h1>
				<div className="flex flex-wrap gap-6">
					{purchasedAssets.length === 0 ? (
						<p>You have not purchased any assets yet.</p>
					) : (
						purchasedAssets.map((asset) => (
							<div
								key={asset.id}
								className="w-full sm:w-1/2 md:w-1/3 lg:w-1/4 xl:w-1/5 p-4 bg-gray-100 rounded-lg shadow-lg">
								<h2 className="text-xl font-semibold">{asset.title}</h2>
								<p className="text-gray-700">{asset.description}</p>
								<p className="text-lg font-semibold">Price: ${asset.price}</p>
								<div className="flex items-center gap-2">
									<button
										onClick={() => handleDownload(asset.id)}
										className="mt-4 px-4 py-2 bg-green-500 text-white rounded hover:bg-green-700">
										Download
									</button>
								</div>
							</div>
						))
					)}
				</div>
			</div>
		</>
	);
}
