import type { PageServerLoad } from './$types';

export const load = (async ({ params }) => {

    const etablissement = params.etablissement;
    const question_id = params.question_id;

    return { etablissement, question_id };
}) satisfies PageServerLoad;