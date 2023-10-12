import type { PageServerLoad } from './$types';

export const load = (async ({ params, locals }) => {
	const sql = locals.sql;
	const etablissement = params.etablissement;
	const question_id = parseInt(params.question_id, 10);

	const questions = await sql`
        SELECT
            enigme
        FROM questions q
        JOIN establishment_question eq ON q.question_id = eq.question_id
        JOIN establishment e ON e.establishment_id = eq.establishment_id
        WHERE q.number = ${question_id}
        AND e.name = ${etablissement}
    `;

	const indice = questions[0];
	console.log('indice : ', indice);

	return { etablissement, question_id, indice };
}) satisfies PageServerLoad;
