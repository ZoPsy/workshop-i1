import type { PageServerLoad } from './$types';

export const load = (async ({ params, locals }) => {
	const establishment = params.etablissement;
	const sql = locals.sql;

	const dbUsers = await sql`
                SELECT
                *
                FROM player
                WHERE establishment_id = (SELECT establishment_id FROM establishment WHERE name = ${establishment} )
				ORDER BY score DESC
            `;

	console.log(dbUsers);
	return {
		etablissement: params.etablissement,
		sourceData: dbUsers
	};
}) satisfies PageServerLoad;
