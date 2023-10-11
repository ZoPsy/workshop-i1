<script lang="ts">
	import { goto } from '$app/navigation';
	import Scanner from '$lib/components/Scanner.svelte';
	import type { PageData } from './$types';

	export let data: PageData;

	let errorText: string;

	function handleCode(event: { detail: { code: string } }) {
		const code = event.detail.code;
		checkCorrectUrl(code);
	}

	const checkCorrectUrl = (codeUrl: string) => {
		const parts: string[] = codeUrl.split('/');

		const lastTwoItems: string[] = parts.slice(-2);

		const etablissement: string = lastTwoItems[0];
		const question: number = parseInt(lastTwoItems[1], 10);

		if (etablissement !== data.etablissement) {
			errorText = 'Etablissement non correcte';
			return;
		}

		if (question != data.question_id) {
			errorText = 'Pas la bonne question';
			return;
		}

		goto(codeUrl);
	};

	//<div class="absolute bottom-2">{errorText}</div>
</script>

<div class="h-screen w-screen relative">
	<Scanner indice={"Retrouve le QR Code derrière le tabouret"} on:code={handleCode} />
</div>
