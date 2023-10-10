<script lang="ts">
	import { goto } from '$app/navigation';
	import Scanner from '$lib/components/Scanner.svelte';
	import type { PageData } from './$types';

	export let data: PageData;

	let errorText: string;

	const pattern: RegExp = /https:\/\/\w+\.\w+\.railway\.app\/(\w+)\/(\d+)/;

	function handleCode(event: { detail: { code: string } }) {
		const code = event.detail.code;
		alert(code)
		checkCorrectUrl(code);
	}

	const checkCorrectUrl = (codeUrl: string) => {
		const match = codeUrl.match(pattern);

		if (match) {
			alert("match")
			
			const etablissement: string = match[1];
			const question: number = parseInt(match[2], 10);

			alert(etablissement + " " + question)

			if (etablissement !== data.etablissement) {
				errorText = 'Etablissement non correcte';
				return;
			}

			if (question != data.question_id) {
				errorText = 'Pas la bonne question';
				return;
			}

			goto(codeUrl);
		}
	};
</script>

Trouve le qr code suivant, indice :  kinder countryy
<Scanner on:code={handleCode} />
{errorText}