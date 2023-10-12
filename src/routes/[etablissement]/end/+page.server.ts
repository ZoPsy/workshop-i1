import type { PageServerLoad } from './$types';

export const load = (async ({ params, locals, cookies }) => {
	console.log(params.etablissement);

	const sql = locals.sql;
	const username = cookies.get('username');

	const user = await sql`
                SELECT
                score
                FROM player
                WHERE name = ${username}
                AND establishment_id = (SELECT establishment_id FROM establishment WHERE name = ${params.etablissement} )
            `;

			console.log(user)
			

	return {
		etablissement: params.etablissement,
		score: user[0].score
	};
}) satisfies PageServerLoad;
