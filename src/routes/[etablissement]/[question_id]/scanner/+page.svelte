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
			const etablissement: string = match[1];
			const question: number = parseInt(match[2], 10);

			if (etablissement !== data.etablissement) {
				errorText = 'Etablissement non correcte';
				alert('mauvais etablissement');
			}

			if (question != data.question_id) {
				alert('question not next');
			}
		}
	};
</script>

<Scanner on:code={handleCode} />
{#if errorText}
	<p class="text-red-500">{errorText}</p>
{/if}
