import { fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';

export const load = (async () => {
    return {};
}) satisfies PageServerLoad;

export const actions: Actions = {
    new: async ({ request, locals }) => {
        const data = await request.formData();
        const name = data.get("name");

        console.log("Received request with name:", name); // Debug log

        const sql = locals.sql;

        const exists = await sql`
            SELECT establishment_id
            FROM establishment
            WHERE name = ${name}
        `;

        console.log("Checking if establishment exists:", exists); // Debug log

        if (exists.length > 0) {
            console.log("Establishment already exists. Returning 409."); // Debug log
            return fail(409, { name, exists: true });
        }

        const insert = await sql`
            INSERT INTO establishment
            (name)
            VALUES (${name})    
        `;

        console.log("Inserting new establishment:", insert); // Debug log

        throw redirect(301, `/create/${name}`)
    }
};
