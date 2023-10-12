<script lang="ts">
	import { goto } from '$app/navigation';
	import Scanner from '$lib/components/Scanner.svelte';
	import type { PageData } from './$types';
	import { getToastStore } from '@skeletonlabs/skeleton';
	export let data: PageData;

	console.log("data : ",data.indice)

	const toastStore = getToastStore();

	let errorText: string;

	function handleCode(event: { detail: { code: string } }) {
		const code = event.detail.code;
		checkCorrectUrl(code);
	}

	const checkCorrectUrl = (codeUrl: string) => {
		const parts: string[] = codeUrl.split('/');

		const lastTwoItems: string[] = parts.slice(-2);

		const etablissement: string = lastTwoItems[0];
		console.log('etablissement : ', etablissement);
		const question: number = parseInt(lastTwoItems[1], 10);
		console.log('question : ', question);

		if (etablissement !== data.etablissement) {
			toastStore.trigger({
				message: 'Etablissement non correct',
				background: 'variant-filled-error'
			});
			errorText = 'Etablissement non correct';
			return;
		}

		console.log(data.question_id);

		if (question != data.question_id + 1) {
			toastStore.trigger({
				message: "Ce n'est pas le bon QR Code",
				background: 'variant-filled-error'
			});
			errorText = 'Pas la bonne question';
			return;
		}

		goto(codeUrl);
	};

	//<div class="absolute bottom-2">{errorText}</div>
</script>

<div class="h-[100svh] w-[100svw] relative">
	<Scanner indice={data.indice.enigme} on:code={handleCode} />
</div>
