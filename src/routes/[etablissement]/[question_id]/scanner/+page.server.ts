import type { PageServerLoad } from './$types';

export const load = (async ({ params }) => {

    const etablissement = params.etablissement;
    const question_id = parseInt(params.question_id, 10);

    return { etablissement, question_id };
}) satisfies PageServerLoad;