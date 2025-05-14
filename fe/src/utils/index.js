export function isUserHaveRole(user, role) {
	const roles = user?.realm_access?.roles || [];
	return roles.some((userRole) => userRole === role);
}