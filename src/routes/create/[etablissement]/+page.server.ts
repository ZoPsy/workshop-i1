import type { PageServerLoad } from './$types';

export const load = (async ({ params }) => {
    const establishment = params.etablissement;
    return { establishment };
}) satisfies PageServerLoad;