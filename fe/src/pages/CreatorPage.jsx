import React, { useRef, useState } from 'react';
import { bulkImportAssets } from '../apis/creator.api';

const BulkImport = () => {
	const [file, setFile] = useState(null);
	const [loading, setLoading] = useState(false);
	const [error, setError] = useState(null);
	const inputRef = useRef();

	const handleFileChange = (e) => {
		const selectedFile = e.target.files[0];
		if (selectedFile && selectedFile.type === 'application/json') {
			setFile(selectedFile);
			setError(null);
		} else {
			setError('Please upload a valid JSON file');
		}
	};

	const handleSubmit = async () => {
		if (!file) {
			setError('Please upload a file before submitting.');
			return;
		}

		setLoading(true);
		setError(null);

		try {
			const response = await bulkImportAssets(file);

			if (response.ok) {
				alert('Assets imported successfully!');
				setFile(null);
				inputRef.current.value = null;
			} else {
				throw new Error('Failed to import assets');
			}
		} catch (err) {
			setError(err.message);
		}
		setLoading(false);
	};

	return (
		<div className="container mx-auto p-6">
			<h1 className="text-2xl font-bold mb-4">Bulk Import Assets</h1>

			<div className="mb-4">
				<label htmlFor="file-upload" className="block text-gray-700 font-semibold mb-2">
					Upload JSON File
				</label>
				<input
					ref={inputRef}
					type="file"
					id="file-upload"
					accept="application/json"
					onChange={handleFileChange}
					className="border border-gray-300 p-2 rounded-md"
				/>
			</div>

			{error && (
				<div className="text-red-500 mb-4">
					<p>{error}</p>
				</div>
			)}

			<button
				onClick={handleSubmit}
				disabled={loading || !file}
				className={`${
					loading || !file ? 'bg-gray-400 cursor-not-allowed' : 'bg-blue-500 hover:bg-blue-700'
				} text-white px-6 py-2 rounded-md mt-4`}>
				{loading ? 'Uploading...' : 'Submit Bulk Import'}
			</button>
		</div>
	);
};

export default BulkImport;
