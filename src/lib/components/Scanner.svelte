<script lang="ts">
	import { Html5Qrcode } from 'html5-qrcode';
	import { onMount } from 'svelte';
	import { createEventDispatcher } from 'svelte';

	const dispatch = createEventDispatcher();

	let scanning = false;

	let html5Qrcode: Html5Qrcode;

	onMount(init);

	function init() {
		html5Qrcode = new Html5Qrcode('reader');
	}

	function start() {
		html5Qrcode.start(
			{ facingMode: 'environment' },
			{
				fps: 60,
				qrbox: { width: 250, height: 250 }
			},
			onScanSuccess,
			onScanFailure
		);
		scanning = true;
	}

	async function stop() {
		await html5Qrcode.stop();
		scanning = false;
	}

	function onScanSuccess(decodedText: any, decodedResult: any) {
		console.log(decodedResult);
		dispatch('code', {
			code: decodedText
		});
	}

	function onScanFailure(error: any) {
		console.warn(`Code scan error = ${error}`);
	}

	export let indice: string;
</script>

<main class="h-screen w-screen">
	<reader class="flex h-screen w-screen" id="reader" />
	{#if scanning}
		<button class="absolute bottom-8 left-8 btn variant-filled-error font-semibold" on:click={stop}>Stop</button>
	{:else}
		<button class="absolute bottom-8 left-8 btn variant-filled-success font-semibold" on:click={start}>Start</button>
	{/if}
	<div class="absolute top-8 left-8 right-8 card p-3 flex flex-col justify-center items-center">
		<span>💡Indice</span>
		<span class="font-semibold">{indice}</span>
	</div>
</main>

<style>
	#reader > video {
		height: 100svh;
	}
</style>
