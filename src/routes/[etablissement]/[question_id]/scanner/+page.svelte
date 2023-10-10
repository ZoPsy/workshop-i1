<script lang="ts">
	import Scanner from '$lib/components/Scanner.svelte';
	import type { PageData } from './$types';

	export let data: PageData;

	let errorText: string;

	const pattern: RegExp = /https:\/\/\w+\.\w+\.railway\.app\/(\w+)\/(\d+)/;

	function handleCode(event: { detail: { code: string } }) {
		const code = event.detail.code;
		checkCorrectUrl(code);
	}

	const checkCorrectUrl = (codeUrl: string) => {
		const match = codeUrl.match(pattern);

		if (match) {
			console.log("match")
			const etablissement: string = match[1];
			const question: number = parseInt(match[2], 10);

			console.log(etablissement, question)

			if (etablissement !== data.etablissement) {
				errorText = 'Etablissement non correcte';
			}

			if (question != data.question_id) {
				errorText = 'Pas la bonne question';
			}
		}
	};
</script>

<Scanner on:code={handleCode} />
{errorText}