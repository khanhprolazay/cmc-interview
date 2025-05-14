import { createReactOidc } from "oidc-spa/react";
import { z } from "zod";

export const { OidcProvider, useOidc, getOidc, withLoginEnforced, enforceLogin } =
    createReactOidc(async () => ({
        issuerUri: import.meta.env.VITE_IAM_ISSUER_URI,
        clientId: "fe",
        homeUrl: import.meta.env.VITE_BASE_URL,
        extraQueryParams: () => ({
            ui_locales: "en"
        }),
        decodedIdTokenSchema: z.object({
            preferred_username: z.string(),
            name: z.string(),
        })
    }));

export const fetchWithAuth = async (
    input,
    init
) => {
    const oidc = await getOidc();
    
    if (oidc.isUserLoggedIn) {
        const { accessToken } = await oidc.getTokens();

        (init ??= {}).headers = {
            ...init.headers,
            Authorization: `Bearer ${accessToken}`
        };
    }

    return fetch(input, init);
};