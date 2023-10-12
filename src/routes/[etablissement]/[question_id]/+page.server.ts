import { redirect, fail } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load = (async ({ locals, params, parent }) => {
	const { username } = await parent();

	const sql = locals.sql;
	const establishment = params.etablissement;
	const question_number = params.question_id;

	if (!username) {
		throw redirect(301, `/${establishment}`);
	}

	console.log(establishment, question_number);

	const questions = await sql`
        SELECT
            q.*
        FROM questions q
        JOIN establishment_question eq ON q.question_id = eq.question_id
        JOIN establishment e ON e.establishment_id = eq.establishment_id
        WHERE q.number = ${question_number}
        AND e.name = ${establishment}
    `;

	const question = questions[0];

	console.log(question);
	if (question === undefined || question === null) {
		console.log('yep');
		throw redirect(301, `${establishment}/end`);
	}

	const answers = await sql`
        SELECT * FROM answer
        WHERE question_id = ${question.question_id}
    `;

	return {
		question,
		answers
	};
}) satisfies PageServerLoad;

export const actions = {
	submit: async ({ locals, request, params }) => {
		const data = await request.formData();
		const btn = data.get('btn');
		const username = data.get('username');
		const sql = locals.sql;

		const question_id = params.question_id;
		const establishment = params.etablissement;

		if (btn !== null && btn !== '') {
			console.log(btn);
			const dbUser = await sql`
                SELECT
                *
                FROM player
                WHERE name = ${username}
                AND establishment_id = (SELECT establishment_id FROM establishment WHERE name = ${establishment} )
            `;
			console.log('dbUser : ', dbUser);
			console.log('dbUser : ', dbUser[0].name);
			if (dbUser) {
				const newscore = dbUser[0].score + parseInt(btn.toString());
				console.log('newscore : ', newscore);
				await sql`
            UPDATE player SET score = ${newscore} WHERE name = ${username}
        `;
				throw redirect(301, `${question_id}/scanner`);
			}
		} else {
			throw fail(404);
		}
	}
};
