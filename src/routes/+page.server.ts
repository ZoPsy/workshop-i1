import { redirect, fail } from '@sveltejs/kit';

export const actions = {
	submit: async ({ request }) => {
		const data = await request.formData();
		const name = data.get('name');

		if (name !== null && name !== '') {
			throw redirect(303, '/' + name);
		} else {
			throw fail(404);
		}
	}
};
