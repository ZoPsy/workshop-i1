import { error, type Actions } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { generateUsername } from "unique-username-generator";

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

    const etablissement = etablissements[0]

    return { etablissement };
}) satisfies PageServerLoad;

export const actions: Actions = {
    checkUser: async ({ locals, params, cookies }) => {
        const sql = locals.sql;
        const establishment_name = params.etablissement;

        let generatedUsername: string = "";
        let valid = false;

        while (!valid) {
            generatedUsername = generateUsername("-");

            const dbUsers = await sql`
                SELECT
                name
                FROM player
                WHERE name = ${generatedUsername}
                AND establishment_id = (SELECT establishment_id FROM establishment WHERE name = ${establishment_name} )
            `;

            if (dbUsers.length === 0) {
                valid = true;
            }
        }

        // Insert the valid username into the database
        console.log(`Inserting username ${generatedUsername} into the database.`);
        await sql`
            INSERT INTO player (name, establishment_id)
            VALUES (${generatedUsername}, (SELECT establishment_id FROM establishment WHERE name = ${establishment_name} ))
        `;

        cookies.set("username", generatedUsername)

        return { username: generatedUsername }
    }
};
