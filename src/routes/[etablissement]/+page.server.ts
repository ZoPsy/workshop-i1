import { error, type Actions, fail } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { redirect } from '@sveltejs/kit';

export const load = (async ({ locals, params }) => {
	const sql = locals.sql;
	const etablissementExpected = params.etablissement;

	const etablissements = await sql`
        SELECT
        name
        FROM establishment
        WHERE name = ${etablissementExpected}
    `;

	if (!etablissements || etablissements.length === 0) {
		throw error(404, 'Etablissement not found');
	}

	const etablissement = etablissements[0];

	return { etablissement };
}) satisfies PageServerLoad;

export const actions: Actions = {
	checkUser: async ({ locals, params, cookies, request }) => {
		const data = await request.formData();
		const sql = locals.sql;
		const establishment_name = params.etablissement;

		const username = data.get('username')?.toString();
		if (username === null || username === undefined) {
			throw fail(400);
		}

		let valid = false;

		while (!valid) {
			console.log('username : ', username);

			const dbUsers = await sql`
                SELECT
                name
                FROM player
                WHERE name = ${username}
                AND establishment_id = (SELECT establishment_id FROM establishment WHERE name = ${establishment_name} )
            `;

			if (dbUsers.length === 0) {
				valid = true;
			} else {
				console.log(`Username ${username} already exists. Retrying...`);
				throw fail(400);
			}
		}

		// Insert the valid username into the database
		console.log(`Inserting username ${username} into the database.`);
		await sql`
            INSERT INTO player (name, establishment_id)
            VALUES (${username}, (SELECT establishment_id FROM establishment WHERE name = ${establishment_name} ))
        `;

		cookies.set('username', username);

		throw redirect(301, `/${establishment_name}/1`);
	}
};
