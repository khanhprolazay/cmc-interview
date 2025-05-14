import { useEffect, useState } from 'react';
import { fetchCreators } from '../apis/admin.api';

export default function AdminPage() {
	const [creators, setCreators] = useState([]);

	useEffect(() => {
		fetchCreators()
			.then((res) => res.json())
			.then((data) => setCreators(data));
	}, []);

	return JSON.stringify(creators);
}
