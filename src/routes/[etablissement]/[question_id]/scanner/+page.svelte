<script lang="ts">
	import Scanner from '$lib/components/Scanner.svelte';
	import type { PageData } from './$types';

	export let data: PageData;

	let errorText: string;

	const pattern: RegExp = /https:\/\/workshop-i1-production\.up\.railway\.app\/(\w+)\/(\w+)/;

	function handleCode(event: { detail: { code: string } }) {
		checkCorrectUrl(event.detail.code);
	}

	const checkCorrectUrl = (codeUrl: string) => {
		const match = codeUrl.match(pattern);

		if (match) {
			const etablissement: string = match[1];
			const question_number: string = match[2];

			if (etablissement !== data.etablissement) {
				errorText = 'Etablissement non correcte';
			}
		}
	};
</script>

<Scanner on:code={handleCode} />
{#if errorText}
	<p class="text-red-500">{errorText}</p>
{/if}
