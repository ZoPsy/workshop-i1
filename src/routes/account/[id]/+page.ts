import type { PageLoad } from './$types';

export const load = (async ({ params }) => {
    const name = params.id;

    return { name };
}) satisfies PageLoad;