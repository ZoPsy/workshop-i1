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
            return fail(409, { name, exists: true });
        }

        const result = await sql`
            INSERT INTO establishment (name)
            VALUES (${name})
            RETURNING establishment_id;
        `;

        const insertedEstablishmentId = result[0].establishment_id;


        console.table(result);

        const questions = await sql`
            SELECT question_id FROM questions;
        `;

        questions.forEach(async (question: { question_id: number }) => {
            await sql`
                INSERT INTO establishment_question
                    (establishment_id,question_id)
                VALUES (${insertedEstablishmentId}, ${question.question_id})
            `;
        });


        throw redirect(301, `/create/${name}`)
    }
};
