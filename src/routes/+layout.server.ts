import type { LayoutServerLoad } from './$types';

export const load = (async ({ cookies }) => {

    const username = cookies.get("username");

    if (username) {
        return { username }
    }
    
    return {};
}) satisfies LayoutServerLoad;