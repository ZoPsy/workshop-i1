import type { PageServerLoad } from './$types';

export const load = (async ({ params }) => {
	console.log(params.etablissement);
	return {
		etablissement: params.etablissement
	};
}) satisfies PageServerLoad;