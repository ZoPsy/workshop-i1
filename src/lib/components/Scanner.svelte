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
				qrbox: { width: 250, height: 250 },
				disableFlip: true
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
		stop();
	}

	function onScanFailure(error: any) {
		console.warn(`Code scan error = ${error}`);
	}

	export let indice: string;
</script>

<main class="h-[100svh] w-[100svw]">
	<reader class="flex h-full w-full" id="reader" />
	{#if scanning}
		<button class="absolute bottom-8 left-8 right-8 lg:left-60 lg:right-60 btn variant-filled-error font-semibold" on:click={stop}
			>Stop</button
		>
	{:else}
		<div class="absolute top-8 left-8 right-8 lg:left-60 lg:right-60 bottom-30 card p-3 flex flex-col items-center">
			<span class="text-xl font-bold">💡Indice</span>
			<span class="mt-1">{indice}</span>
		</div>
		<button
			class="absolute bottom-8 left-8 right-8 lg:left-60 lg:right-60 btn variant-filled-success font-semibold"
			on:click={start}>Start</button
		>
	{/if}
</main>

<style>
	#reader > video {
		height: 100svh;
	}
</style>
