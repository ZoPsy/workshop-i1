import type { PageServerLoad } from './$types';

export const load = (async ({ locals, params }) => {
	console.log(params.etablissement);

	const sql = locals.sql;
	const etablissementExpected = params.etablissement;

	const question = await sql`
		SELECT
		question_text, explanation, enigme
		FROM questions
		WHERE establishment id = (SELECT establishment_id FROM establishment WHERE name = ${etablissementExpected} );
    `;
	
	console.log(question)

	return {
		etablissement: params.etablissement,
		question_id: params.question_id
	};
}) satisfies PageServerLoad;
