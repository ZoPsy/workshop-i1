import type { PageServerLoad } from './$types';

export const load = (async ({ locals, params }) => {
	console.log(params.etablissement);

	const sql = locals.sql;
	const establishment = params.etablissement;
	const question_number = params.question_id

	console.log(establishment, question_number)

	const question = await sql`
		SELECT
		question_text, explanation
		FROM questions
		WHERE number = ${question_number}
		AND establishment_id = (SELECT establishment_id FROM establishment WHERE name = ${establishment} )
    `;

	console.log(question)

	return {
		question
	};
}) satisfies PageServerLoad;
