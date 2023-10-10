export const actions = {
	submit: async ({ request, url }) => {
		const data = await request.formData();
		const name = data.get('name');

		return { sucess: name !== '' };
	}
};
