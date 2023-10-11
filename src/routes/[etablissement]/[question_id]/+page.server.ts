import type { PageServerLoad } from './$types';

export const load = (async ({ locals, params }) => {
	console.log(params.etablissement);

	const sql = locals.sql;
	const establishment = params.etablissement;
	const question_number = params.question_id

	console.log(establishment, question_number)

	const questions = await sql`
		SELECT
		*
		FROM questions
		WHERE number = ${question_number}
		AND establishment_id = (SELECT establishment_id FROM establishment WHERE name = ${establishment} )
    `;

	const question = questions[0]

	const answers = await sql`
		SELECT * FROM answer
		WHERE question_id = ${question.question_id}
	`;



	return {
		question,
		answers
	};
}) satisfies PageServerLoad;
