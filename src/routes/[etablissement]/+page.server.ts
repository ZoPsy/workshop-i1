import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load = (async ({ locals, params }) => {

    const sql = locals.sql;
    const etablissementExpected = params.etablissement;

    const etablissement = await sql`
        SELECT
        name
        FROM establishment
        WHERE name = ${etablissementExpected}
    `;

    if (!etablissement || etablissement.length === 0) {
        throw error(404, 'Etablissement not found');
    }

    return { etablissement };
}) satisfies PageServerLoad;